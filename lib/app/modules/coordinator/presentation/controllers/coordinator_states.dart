import '../../../../core/presentation/controllers/base/base_states.dart';

class VerifyingUserAuthenticationState implements ProcessingState {}

class UserAuthenticatedState implements SuccessState {}

class UserNotAuthenticatedState implements ErrorState {}
