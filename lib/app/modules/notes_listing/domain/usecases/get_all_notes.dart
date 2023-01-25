import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/note.dart';
import '../../../../core/domain/failures/failure.dart';
import '../../../../core/domain/repositories/notes_repository.dart';

class GetAllNotes {
  final NotesRepository _notesRepository;

  const GetAllNotes(this._notesRepository);

  Future<Either<Failure, List<Note>>> call() async {
    return await _notesRepository.getAllNotes();
  }
}
