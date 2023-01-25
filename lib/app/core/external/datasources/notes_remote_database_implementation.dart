import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/note.dart';
import '../../domain/entities/user.dart';
import '../../infrastucture/datasources/notes_remote_database.dart';
import '../../infrastucture/exceptions/notes_exceptions.dart';
import '../mappers/note_mapper.dart';

class NotesRemoteDataBaseImplementation implements NotesRemoteDataBase {
  @override
  Future<void> createNote(Note note, User user) async {
    try {
      final currentNotes = await getAllUserNotes(user);
      currentNotes.add(note);
      final encodedNotes =
          currentNotes.map((note) => NoteMapper.toMap(note)).toList();
      await FirebaseFirestore.instance
          .collection('notes')
          .doc(user.userID)
          .set({'notes': encodedNotes});
    } catch (_) {
      throw UnableToCreateNoteException();
    }
  }

  @override
  Future<void> editNote(Note note, User user) async {
    try {
      final currentNotes = await getAllUserNotes(user);
      final noteIndex = currentNotes.indexWhere(
        (remoteNote) => remoteNote.uniqueIdentifier == note.uniqueIdentifier,
      );
      if (noteIndex == -1) return;
      currentNotes[noteIndex] = note;
      final encodedNotes =
          currentNotes.map((note) => NoteMapper.toMap(note)).toList();
      await FirebaseFirestore.instance
          .collection('notes')
          .doc(user.userID)
          .set({'notes': encodedNotes});
    } catch (_) {
      throw UnableToCreateNoteException();
    }
  }

  @override
  Future<void> deleteNote(Note note, User user) async {
    try {
      final currentNotes = await getAllUserNotes(user);
      currentNotes.removeWhere(
        (remoteNote) => remoteNote.uniqueIdentifier == note.uniqueIdentifier,
      );
      final encodedNotes =
          currentNotes.map((note) => NoteMapper.toMap(note)).toList();
      await FirebaseFirestore.instance
          .collection('notes')
          .doc(user.userID)
          .set({'notes': encodedNotes});
    } catch (_) {
      throw UnableToDeleteNoteException();
    }
  }

  @override
  Future<List<Note>> getAllUserNotes(User user) async {
    try {
      final userNotesReference = await FirebaseFirestore.instance
          .collection('notes')
          .doc(user.userID)
          .get();
      final userNotes = userNotesReference.data();

      if (userNotes == null) {
        await FirebaseFirestore.instance
            .collection('notes')
            .doc(user.userID)
            .set({'notes': []});
        return [];
      }

      return List<Note>.from(
        userNotes['notes'].map(
          (note) => NoteMapper.fromMap(note),
        ),
      );
    } catch (_) {
      throw UnableToGetNotesException();
    }
  }
}
