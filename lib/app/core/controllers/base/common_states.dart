import 'base_states.dart';

abstract class UserInputErrorState extends ErrorState {}

class InvalidUserNameState implements UserInputErrorState {}

class InvalidUserEmailState implements UserInputErrorState {}

class InvalidUserPasswordState implements UserInputErrorState {}

class InvalidUserCredentialsState implements UserInputErrorState {}

class UpdatingCurrentNoteState implements ProcessingState {}

class SuccessfullyUpdatedCurrentNoteState implements SuccessState {}

class UnableToUpdateCurrentNoteState implements ErrorState {}
