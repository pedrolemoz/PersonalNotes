import '../../../core/controllers/base/base_states.dart';

class CreatingNewNoteState implements ProcessingState {}

class SuccessfullyCreatedNewNoteState implements SuccessState {}

class UnableToCreateNewNoteState implements ErrorState {}
