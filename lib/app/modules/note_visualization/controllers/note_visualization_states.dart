import '../../../core/controllers/base/base_states.dart';

class DeletingCurrentNoteState implements ProcessingState {}

class SuccessfullyDeletedCurrentNoteState implements SuccessState {}

class UnableToDeleteCurrentNoteState implements ErrorState {}
