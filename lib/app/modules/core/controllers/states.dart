abstract class AppState {}

abstract class SuccessState extends AppState {}

abstract class ErrorState extends AppState {}

abstract class ProcessingState extends AppState {}

class InitialState implements AppState {}

abstract class UserInputErrorState extends ErrorState {}

class InvalidUserNameState implements UserInputErrorState {}

class InvalidUserEmailState implements UserInputErrorState {}

class InvalidUserPasswordState implements UserInputErrorState {}

class InvalidUserCredentialsState implements UserInputErrorState {}
