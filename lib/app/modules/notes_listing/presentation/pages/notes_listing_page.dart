import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:unicons/unicons.dart';

import '../../../../core/presentation/controllers/base/base_states.dart';
import '../../../../core/presentation/utils/colors.dart';
import '../../../../core/presentation/widgets/disable_splash.dart';
import '../../../../core/presentation/widgets/warning_message.dart';
import '../controllers/notes_listing_bloc.dart';
import '../controllers/notes_listing_events.dart';
import '../controllers/notes_listing_states.dart';
import '../widgets/note_card.dart';
import '../widgets/note_shimmer.dart';

class NotesListingPage extends StatefulWidget {
  @override
  State<NotesListingPage> createState() => _NotesListingPageState();
}

class _NotesListingPageState extends State<NotesListingPage> {
  final notesListingBloc = Modular.get<NoteListingBloc>();

  @override
  void initState() {
    notesListingBloc.add(const GetAllNotesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Modular.to.pushNamed('/note_creation/'),
        child: const Icon(
          UniconsLine.plus,
          size: 28,
          color: AppColors.white,
        ),
      ),
      appBar: AppBar(title: const Text('Suas Notas')),
      body: DisableSplash(
        child: BlocBuilder<NoteListingBloc, AppState>(
          bloc: notesListingBloc,
          builder: (context, state) {
            if (state is GettingAllNotesState || state is InitialState) {
              return ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(32),
                itemCount: 5,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) => const NoteShimmer(),
              );
            }

            if (state is ZeroNotesToShowState)
              return const WarningMessage(message: 'Nenhuma nota para exibir');

            if (state is UnableToGetNotesState) {
              return WarningMessage(
                message: 'Um erro inesperado ocorreu ao obter as suas notas',
                enableRetry: true,
                onRetry: () => notesListingBloc.add(const GetAllNotesEvent()),
              );
            }

            return RefreshIndicator(
              color: AppColors.blue,
              onRefresh: () async =>
                  notesListingBloc.add(const RefreshAllNotesEvent()),
              child: ListView.separated(
                padding: const EdgeInsets.all(32),
                itemCount: notesListingBloc.notes.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final note = notesListingBloc.notes[index];
                  return NoteCard(
                    onTap: () => Modular.to
                        .pushNamed('/note_visualization/', arguments: note),
                    note: note,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
