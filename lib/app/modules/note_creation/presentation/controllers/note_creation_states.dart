import '../../../../core/domain/entities/note.dart';
import '../../../../core/presentation/controllers/base/base_states.dart';

class CreatingNewNoteState implements ProcessingState {}

class EditingCurrentNoteState implements ProcessingState {}

class SuccessfullyCreatedNewNoteState implements SuccessState {
  final Note createdNote;

  const SuccessfullyCreatedNewNoteState({required this.createdNote});
}

class SuccessfullyEditedCurrentNoteState implements SuccessState {
  final Note editedNote;

  const SuccessfullyEditedCurrentNoteState({required this.editedNote});
}

class UnableToCreateNewNoteState implements ErrorState {}

class UnableToEditCurrentNoteState implements ErrorState {}

class InvalidNoteState extends UserInputErrorState {}

class InvalidNoteTitleState implements InvalidNoteState {}

class InvalidNoteContentState implements InvalidNoteState {}
