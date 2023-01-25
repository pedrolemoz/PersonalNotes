import '../../../../../core/presentation/controllers/base/base_states.dart';

class RegistratingUserState implements ProcessingState {}

class SuccessfullyRegistratedUserState implements SuccessState {
  final String userName;

  SuccessfullyRegistratedUserState({required this.userName});
}

class UnableToRegisterUserState implements ErrorState {}
