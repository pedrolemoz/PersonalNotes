import '../../../../core/domain/entities/note.dart';

abstract class NoteCreationEvent {}

class CreateNewNoteEvent implements NoteCreationEvent {
  final String title;
  final String content;

  const CreateNewNoteEvent({required this.title, required this.content});
}

class EditCurrentNoteEvent implements NoteCreationEvent {
  final String title;
  final String content;
  final Note note;

  const EditCurrentNoteEvent({
    required this.title,
    required this.content,
    required this.note,
  });
}
