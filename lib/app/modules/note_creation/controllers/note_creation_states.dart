import '../../../core/controllers/base/base_states.dart';
import '../../../core/controllers/base/common_states.dart';

class CreatingNewNoteState implements ProcessingState {}

class SuccessfullyCreatedNewNoteState implements SuccessState {}

class UnableToCreateNewNoteState implements ErrorState {}

class InvalidNoteState extends UserInputErrorState {}

class InvalidNoteTitleState implements InvalidNoteState {}

class InvalidNoteContentState implements InvalidNoteState {}