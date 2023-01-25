import 'package:dartz/dartz.dart';

import '../entities/note.dart';
import '../failures/failure.dart';
import '../failures/notes_failures.dart';
import '../inputs/create_note_input.dart';
import '../repositories/notes_repository.dart';
import '../validators/note_validator.dart';

class CreateNote {
  final NotesRepository _notesRepository;

  const CreateNote(this._notesRepository);

  Future<Either<Failure, Note>> call(CreateNoteInput input) async {
    if (!NoteValidator.hasValidTitle(input.title)) {
      return Left(InvalidNoteTitleFailure());
    }

    if (!NoteValidator.hasValidContent(input.content)) {
      return Left(InvalidNoteContentFailure());
    }

    return await _notesRepository.createNote(input);
  }
}
