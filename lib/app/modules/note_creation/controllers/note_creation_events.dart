import '../../../core/models/note_model.dart';

abstract class NoteCreationEvent {}

class CreateNewNote implements NoteCreationEvent {
  final String title;
  final String content;

  const CreateNewNote({required this.title, required this.content});
}

class EditCurrentNote implements NoteCreationEvent {
  final String title;
  final String content;
  final NoteModel noteModel;

  const EditCurrentNote({required this.title, required this.content, required this.noteModel});
}
