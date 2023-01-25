import 'base_states.dart';

class UpdatingCurrentNoteState implements ProcessingState {}

class SuccessfullyUpdatedCurrentNoteState implements SuccessState {}

class UnableToUpdateCurrentNoteState implements ErrorState {}
