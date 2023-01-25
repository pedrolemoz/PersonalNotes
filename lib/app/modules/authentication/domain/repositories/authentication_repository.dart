import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/user.dart';
import '../../../../core/domain/failures/failure.dart';
import '../inputs/login_with_credentials_input.dart';
import '../inputs/register_with_credentials_input.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, User>> registerWithCredentials(
    RegisterWithCredentialsInput input,
  );

  Future<Either<Failure, User>> loginWithCredentials(
    LoginWithCredentialsInput input,
  );

  Future<Either<Failure, User>> authWithGoogle();
}
