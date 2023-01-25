import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/user.dart';
import '../../../../core/domain/failures/failure.dart';
import '../failures/authentication_failures.dart';
import '../inputs/register_with_credentials_input.dart';
import '../repositories/authentication_repository.dart';
import '../validators/authentication_validator.dart';

class RegisterWithCredentials {
  final AuthenticationRepository _authRepository;

  const RegisterWithCredentials(this._authRepository);

  Future<Either<Failure, User>> call(RegisterWithCredentialsInput input) async {
    if (!AuthenticationValidator.hasValidName(input.name)) {
      return Left(InvalidUserNameFailure());
    }

    if (!AuthenticationValidator.hasValidEmail(input.email)) {
      return Left(InvalidUserEmailFailure());
    }

    if (!AuthenticationValidator.hasValidPassword(input.password)) {
      return Left(InvalidUserPasswordFailure());
    }

    return await _authRepository.registerWithCredentials(input);
  }
}
