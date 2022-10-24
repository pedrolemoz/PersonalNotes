import '../../../core/controllers/base/base_states.dart';
import '../../../core/controllers/base/common_states.dart';
import '../../../core/models/note_model.dart';

class CreatingNewNoteState implements ProcessingState {}

class EditingCurrentNoteState implements ProcessingState {}

class SuccessfullyCreatedNewNoteState implements SuccessState {
  final NoteModel createdNoteModel;

  const SuccessfullyCreatedNewNoteState({required this.createdNoteModel});
}

class SuccessfullyEditedCurrentNoteState implements SuccessState {
  final NoteModel editedNoteModel;

  const SuccessfullyEditedCurrentNoteState({required this.editedNoteModel});
}

class UnableToCreateNewNoteState implements ErrorState {}

class UnableToEditCurrentNoteState implements ErrorState {}

class InvalidNoteState extends UserInputErrorState {}

class InvalidNoteTitleState implements InvalidNoteState {}

class InvalidNoteContentState implements InvalidNoteState {}
