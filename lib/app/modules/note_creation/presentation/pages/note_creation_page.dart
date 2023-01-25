import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:unicons/unicons.dart';

import '../../../../core/domain/entities/note.dart';
import '../../../../core/presentation/controllers/base/base_states.dart';
import '../../../../core/presentation/utils/colors.dart';
import '../../../../core/presentation/utils/typography.dart';
import '../../../../core/presentation/widgets/app_button.dart';
import '../../../../core/presentation/widgets/app_text_field.dart';
import '../../../../core/presentation/widgets/disable_splash.dart';
import '../../../../core/presentation/widgets/loading_dialog.dart';
import '../../../../core/presentation/widgets/unfocus_widget.dart';
import '../../../note_visualization/presentation/controllers/note_visualization_bloc.dart';
import '../../../note_visualization/presentation/controllers/note_visualization_events.dart';
import '../../../notes_listing/presentation/controllers/notes_listing_bloc.dart';
import '../../../notes_listing/presentation/controllers/notes_listing_events.dart';
import '../controllers/note_creation_bloc.dart';
import '../controllers/note_creation_events.dart';
import '../controllers/note_creation_states.dart';

class NoteCreationPage extends StatefulWidget {
  final Note? note;

  const NoteCreationPage({super.key, this.note});

  @override
  State<NoteCreationPage> createState() => _NoteCreationPageState();
}

class _NoteCreationPageState extends State<NoteCreationPage> {
  late final bool isEditingAnExistingNote;
  final noteCreationBloc = Modular.get<NoteCreationBloc>();
  final notesListingBloc = Modular.get<NoteListingBloc>();
  final titleTextController = TextEditingController();
  final contentTextController = TextEditingController();

  @override
  void initState() {
    isEditingAnExistingNote = widget.note != null;

    if (isEditingAnExistingNote) {
      titleTextController.value = TextEditingValue(
        text: widget.note!.title,
        selection: TextSelection.fromPosition(
          TextPosition(offset: widget.note!.title.length),
        ),
      );
      contentTextController.value = TextEditingValue(
        text: widget.note!.content,
        selection: TextSelection.fromPosition(
          TextPosition(offset: widget.note!.content.length),
        ),
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditingAnExistingNote ? 'Editar nota' : 'Criar nota'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          tooltip: 'Voltar',
          splashRadius: 24,
          onPressed: () => Modular.to.maybePop(),
          icon: const Icon(
            UniconsLine.arrow_left,
            size: 28,
          ),
        ),
      ),
      body: UnfocusWidget(
        child: DisableSplash(
          child: BlocConsumer<NoteCreationBloc, AppState>(
            bloc: noteCreationBloc,
            listener: (context, state) async {
              if (state is ProcessingState) {
                await showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return LoadingDialog(
                      text: isEditingAnExistingNote
                          ? 'Editando nota'
                          : 'Criando nova nota',
                    );
                  },
                );
                return;
              }

              Navigator.of(context, rootNavigator: true).pop();

              if (state is SuccessState) {
                notesListingBloc.add(const RefreshAllNotesEvent());

                if (state is SuccessfullyEditedCurrentNoteState) {
                  final noteVisualizationBloc =
                      Modular.get<NoteVisualizationBloc>();
                  noteVisualizationBloc.add(
                    UpdateCurrentNoteInVisualizationBlocEvent(
                      note: state.editedNote,
                    ),
                  );
                }

                Modular.to.maybePop();
              }

              if (state is ErrorState && state is! UserInputErrorState) {
                final errorSnackBar = SnackBar(
                  backgroundColor: AppColors.red,
                  content: Text(
                    'Não foi possível criar a nota',
                    style:
                        AppTypography.textHeadline(color: AppColors.lightGray1),
                  ),
                );

                ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
              }
            },
            builder: (context, state) {
              return ListView(
                padding: const EdgeInsets.all(32),
                children: [
                  AppTextField(
                    controller: titleTextController,
                    hintText: 'Título',
                    capitalization: TextCapitalization.sentences,
                    errorText: state is InvalidNoteTitleState
                        ? 'O título inserido não é válido'
                        : null,
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    controller: contentTextController,
                    hintText: 'Escreva sua nota aqui',
                    maxLines: 20,
                    capitalization: TextCapitalization.sentences,
                    errorText: state is InvalidNoteContentState
                        ? 'O conteúdo inserido não é válido'
                        : null,
                  ),
                  const SizedBox(height: 16),
                  AppButton(
                    text: isEditingAnExistingNote
                        ? 'Editar nota'
                        : 'Criar nova nota',
                    onTap: () => isEditingAnExistingNote
                        ? noteCreationBloc.add(
                            EditCurrentNoteEvent(
                              title: titleTextController.text,
                              content: contentTextController.text,
                              note: widget.note!,
                            ),
                          )
                        : noteCreationBloc.add(
                            CreateNewNoteEvent(
                              title: titleTextController.text,
                              content: contentTextController.text,
                            ),
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
