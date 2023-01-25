import 'package:dartz/dartz.dart';

import '../../domain/entities/note.dart';
import '../../domain/failures/failure.dart';
import '../../domain/failures/notes_failures.dart';
import '../../domain/inputs/create_note_input.dart';
import '../../domain/inputs/delete_note_input.dart';
import '../../domain/inputs/edit_note_input.dart';
import '../../domain/repositories/notes_repository.dart';
import '../datasources/id_generator.dart';
import '../datasources/notes_local_database.dart';
import '../datasources/notes_remote_database.dart';
import '../datasources/users_local_database.dart';

class NotesRepositoryImplementation implements NotesRepository {
  final NotesLocalDataBase _notesLocalDataBase;
  final NotesRemoteDataBase _notesRemoteDataBase;
  final UsersLocalDataBase _usersLocalDataBase;
  final IdGenerator _idGenerator;

  const NotesRepositoryImplementation(
    this._notesLocalDataBase,
    this._notesRemoteDataBase,
    this._usersLocalDataBase,
    this._idGenerator,
  );

  @override
  Future<Either<Failure, List<Note>>> getAllNotes() async {
    try {
      final user = await _usersLocalDataBase.getUser();
      final localNotes = await _notesLocalDataBase.getAllUserNotes();
      final remoteNotes = await _notesRemoteDataBase.getAllUserNotes(user);

      for (var note in remoteNotes) {
        if (!localNotes.contains(note)) {
          final index = localNotes.indexWhere(
            (localNote) => localNote.uniqueIdentifier == note.uniqueIdentifier,
          );

          if (index == -1) {
            await _notesLocalDataBase.createNote(note);
            localNotes.add(note);
            continue;
          }

          localNotes[index] = note;
        }
      }

      final notes = localNotes.toList();

      for (final note in localNotes) {
        if (!remoteNotes.contains(note)) {
          await _notesLocalDataBase.deleteNote(note);
          notes.remove(note);
        }
      }

      if (notes.isEmpty) return Left(ZeroNotesFoundFailure());

      return Right(notes);
    } catch (_) {
      return Left(UnableToGetNotesFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteNote(DeleteNoteInput input) async {
    try {
      final user = await _usersLocalDataBase.getUser();
      await _notesLocalDataBase.deleteNote(input.note);
      await _notesRemoteDataBase.deleteNote(input.note, user);
      return const Right(null);
    } catch (_) {
      return Left(UnableToDeleteNoteFailure());
    }
  }

  @override
  Future<Either<Failure, Note>> createNote(CreateNoteInput input) async {
    try {
      final user = await _usersLocalDataBase.getUser();
      final id = _idGenerator.generate();

      final note = Note(
        title: input.title,
        content: input.content,
        date: DateTime.now(),
        uniqueIdentifier: id,
      );

      await _notesLocalDataBase.createNote(note);
      await _notesRemoteDataBase.createNote(note, user);

      return Right(note);
    } catch (_) {
      return Left(UnableToCreateNoteFailure());
    }
  }

  @override
  Future<Either<Failure, Note>> editNote(EditNoteInput input) async {
    try {
      final user = await _usersLocalDataBase.getUser();

      final note = input.note.copyWith(
        title: input.title,
        content: input.content,
      );

      await _notesLocalDataBase.editNote(note);
      await _notesRemoteDataBase.editNote(note, user);

      return Right(note);
    } catch (_) {
      return Left(UnableToEditNoteFailure());
    }
  }
}
