import 'package:dartz/dartz.dart';

import '../entities/note.dart';
import '../failures/failure.dart';
import '../failures/notes_failures.dart';
import '../inputs/edit_note_input.dart';
import '../repositories/notes_repository.dart';
import '../validators/note_validator.dart';

class EditNote {
  final NotesRepository _notesRepository;

  const EditNote(this._notesRepository);

  Future<Either<Failure, Note>> call(EditNoteInput input) async {
    if (!NoteValidator.hasValidTitle(input.title)) {
      return Left(InvalidNoteTitleFailure());
    }

    if (!NoteValidator.hasValidContent(input.content)) {
      return Left(InvalidNoteContentFailure());
    }

    return await _notesRepository.editNote(input);
  }
}
