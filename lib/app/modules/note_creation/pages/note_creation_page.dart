import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:unicons/unicons.dart';

import '../../../core/controllers/base/base_states.dart';
import '../../../core/controllers/base/common_states.dart';
import '../../../core/models/note_model.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/typography.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/disable_splash.dart';
import '../../../core/widgets/loading_dialog.dart';
import '../../../core/widgets/unfocus_widget.dart';
import '../../notes_listing/controllers/notes_listing_bloc.dart';
import '../../notes_listing/controllers/notes_listing_events.dart';
import '../controllers/note_creation_bloc.dart';
import '../controllers/note_creation_events.dart';
import '../controllers/note_creation_states.dart';

class NoteCreationPage extends StatefulWidget {
  final NoteModel? noteModel;

  const NoteCreationPage({super.key, this.noteModel});

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
    isEditingAnExistingNote = widget.noteModel != null;

    if (isEditingAnExistingNote) {
      titleTextController.value = TextEditingValue(
        text: widget.noteModel!.title,
        selection: TextSelection.fromPosition(
          TextPosition(offset: widget.noteModel!.title.length),
        ),
      );
      contentTextController.value = TextEditingValue(
        text: widget.noteModel!.content,
        selection: TextSelection.fromPosition(
          TextPosition(offset: widget.noteModel!.content.length),
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
                  builder: (context) => LoadingDialog(
                    text: isEditingAnExistingNote ? 'Editando nota' : 'Criando nova nota',
                  ),
                );
                return;
              }

              Navigator.of(context, rootNavigator: true).pop();

              if (state is SuccessState) {
                notesListingBloc.add(const RefreshAllNotes());
                Modular.to.popUntil(ModalRoute.withName('/notes_listing/'));
              }

              if (state is ErrorState && state is! UserInputErrorState) {
                final errorSnackBar = SnackBar(
                  backgroundColor: AppColors.red,
                  content: Text(
                    'Não foi possível criar a nota',
                    style: AppTypography.textHeadline(color: AppColors.lightGray1),
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
                    errorText: state is InvalidNoteTitleState ? 'O título inserido não é válido' : null,
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    controller: contentTextController,
                    hintText: 'Escreva sua nota aqui',
                    maxLines: 20,
                    errorText: state is InvalidNoteContentState ? 'O conteúdo inserido não é válido' : null,
                  ),
                  const SizedBox(height: 16),
                  AppButton(
                    text: isEditingAnExistingNote ? 'Editar nota' : 'Criar nova nota',
                    onTap: () => isEditingAnExistingNote
                        ? noteCreationBloc.add(
                            EditCurrentNote(
                              title: titleTextController.text,
                              content: contentTextController.text,
                              noteModel: widget.noteModel!,
                            ),
                          )
                        : noteCreationBloc.add(
                            CreateNewNote(
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
