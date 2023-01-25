import '../../domain/entities/note.dart';

abstract class NotesLocalDataBase {
  Future<void> createNote(Note note);

  Future<void> editNote(Note note);

  Future<void> deleteNote(Note note);

  Future<List<Note>> getAllUserNotes();
}
