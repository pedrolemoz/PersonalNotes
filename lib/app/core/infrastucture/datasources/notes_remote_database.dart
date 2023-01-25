import '../../domain/entities/note.dart';
import '../../domain/entities/user.dart';

abstract class NotesRemoteDataBase {
  Future<void> createNote(Note note, User user);

  Future<void> editNote(Note note, User user);

  Future<void> deleteNote(Note note, User user);

  Future<List<Note>> getAllUserNotes(User user);
}
