import '../../../core/controllers/base/base_states.dart';

class RefreshingAllNotesState implements ProcessingState {}

class GettingAllNotesState implements ProcessingState {}

class SuccessfullyGotAllNotesState implements SuccessState {}

class UnableToGetNotesState implements ErrorState {}

class ZeroNotesToShowState implements ErrorState {}
