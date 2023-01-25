import 'dart:convert';

import 'package:hive/hive.dart';

import '../../domain/entities/note.dart';
import '../../infrastucture/datasources/notes_local_database.dart';
import '../../infrastucture/exceptions/notes_exceptions.dart';
import '../../utils/cache_keys.dart';
import '../mappers/note_mapper.dart';

class NotesLocalDataBaseImplementation implements NotesLocalDataBase {
  @override
  Future<void> createNote(Note note) async {
    try {
      final box = await Hive.openBox(CacheKeys.appCache);
      final currentNotes = await getAllUserNotes();
      currentNotes.add(note);
      final encodedNotes =
          currentNotes.map((note) => NoteMapper.toMap(note)).toList();
      await box.put(CacheKeys.userNotes, json.encode(encodedNotes));
    } catch (_) {
      throw UnableToCreateNoteException();
    }
  }

  @override
  Future<void> editNote(Note note) async {
    try {
      final box = await Hive.openBox(CacheKeys.appCache);
      final currentNotes = await getAllUserNotes();
      final noteIndex = currentNotes.indexWhere(
        (localNote) => localNote.uniqueIdentifier == note.uniqueIdentifier,
      );
      if (noteIndex == -1) return;
      currentNotes[noteIndex] = note;
      final encodedNotes =
          currentNotes.map((note) => NoteMapper.toMap(note)).toList();
      await box.put(CacheKeys.userNotes, json.encode(encodedNotes));
    } catch (_) {
      throw UnableToEditNoteException();
    }
  }

  @override
  Future<void> deleteNote(Note note) async {
    try {
      final box = await Hive.openBox(CacheKeys.appCache);
      final currentNotes = await getAllUserNotes();
      currentNotes.removeWhere(
        (localNote) => localNote.uniqueIdentifier == note.uniqueIdentifier,
      );
      final encodedNotes =
          currentNotes.map((note) => NoteMapper.toMap(note)).toList();
      await box.put(CacheKeys.userNotes, json.encode(encodedNotes));
    } catch (_) {
      throw UnableToDeleteNoteException();
    }
  }

  @override
  Future<List<Note>> getAllUserNotes() async {
    try {
      final box = await Hive.openBox(CacheKeys.appCache);
      final rawNotes = await box.get(CacheKeys.userNotes);
      final decodedNotes = rawNotes == null ? [] : json.decode(rawNotes);
      return List<Note>.from(
        decodedNotes.map(
          (note) => NoteMapper.fromMap(note),
        ),
      );
    } catch (_) {
      throw UnableToGetNotesException();
    }
  }
}
