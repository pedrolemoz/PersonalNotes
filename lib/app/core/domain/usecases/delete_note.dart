import 'package:dartz/dartz.dart';

import '../failures/failure.dart';
import '../inputs/delete_note_input.dart';
import '../repositories/notes_repository.dart';

class DeleteNote {
  final NotesRepository _notesRepository;

  const DeleteNote(this._notesRepository);

  Future<Either<Failure, void>> call(DeleteNoteInput input) async {
    return await _notesRepository.deleteNote(input);
  }
}
