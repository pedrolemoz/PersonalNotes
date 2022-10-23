import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:unicons/unicons.dart';

import '../../../core/controllers/base/base_states.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/disable_splash.dart';
import '../../../core/widgets/unfocus_widget.dart';
import '../../notes_listing/controllers/notes_listing_bloc.dart';
import '../../notes_listing/controllers/notes_listing_events.dart';
import '../controllers/note_creation_bloc.dart';
import '../controllers/note_creation_events.dart';
import '../controllers/note_creation_states.dart';

class NoteCreationPage extends StatelessWidget {
  final noteCreationBloc = Modular.get<NoteCreationBloc>();
  final notesListingBloc = Modular.get<NoteListingBloc>();
  final titleTextController = TextEditingController();
  final contentTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar nota'),
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
            listener: (context, state) {
              if (state is SuccessfullyCreatedNewNoteState) {
                notesListingBloc.add(const RefreshAllNotes());
                Modular.to.maybePop();
              }
            },
            builder: (context, state) {
              return ListView(
                padding: const EdgeInsets.all(32),
                children: [
                  AppTextField(
                    controller: titleTextController,
                    hintText: 'Título',
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    controller: contentTextController,
                    hintText: 'Escreva sua nota aqui',
                    maxLines: 20,
                  ),
                  const SizedBox(height: 16),
                  AppButton(
                    text: 'Criar nova nota',
                    onTap: () => noteCreationBloc.add(
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
