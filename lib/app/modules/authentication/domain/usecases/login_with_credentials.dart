import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/user.dart';
import '../../../../core/domain/failures/failure.dart';
import '../failures/authentication_failures.dart';
import '../inputs/login_with_credentials_input.dart';
import '../repositories/authentication_repository.dart';
import '../validators/authentication_validator.dart';

class LoginWithCredentials {
  final AuthenticationRepository _authRepository;

  const LoginWithCredentials(this._authRepository);

  Future<Either<Failure, User>> call(LoginWithCredentialsInput input) async {
    if (!AuthenticationValidator.hasValidEmail(input.email)) {
      return Left(InvalidUserEmailFailure());
    }

    if (!AuthenticationValidator.hasValidPassword(input.password)) {
      return Left(InvalidUserPasswordFailure());
    }

    return await _authRepository.loginWithCredentials(input);
  }
}
