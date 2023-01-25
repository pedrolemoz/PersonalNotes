import '../../../../core/domain/failures/failure.dart';

class InvalidUserNameFailure implements Failure {}

class InvalidUserEmailFailure implements Failure {}

class InvalidUserPasswordFailure implements Failure {}

class InvalidUserCredentialsFailure implements Failure {}

class UserNotFoundFailure implements Failure {}

class UnableToRegisterUserFailure implements Failure {}

class UnableToAuthenticateUserFailure implements Failure {}
