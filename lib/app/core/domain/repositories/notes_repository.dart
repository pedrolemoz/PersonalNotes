import 'package:dartz/dartz.dart';

import '../entities/note.dart';
import '../failures/failure.dart';
import '../inputs/create_note_input.dart';
import '../inputs/delete_note_input.dart';
import '../inputs/edit_note_input.dart';

abstract class NotesRepository {
  Future<Either<Failure, List<Note>>> getAllNotes();

  Future<Either<Failure, Note>> createNote(CreateNoteInput input);

  Future<Either<Failure, Note>> editNote(EditNoteInput input);

  Future<Either<Failure, void>> deleteNote(DeleteNoteInput input);
}
