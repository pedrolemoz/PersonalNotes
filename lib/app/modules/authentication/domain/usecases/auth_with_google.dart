import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/user.dart';
import '../../../../core/domain/failures/failure.dart';
import '../repositories/authentication_repository.dart';

class AuthWithGoogle {
  final AuthenticationRepository _authRepository;

  const AuthWithGoogle(this._authRepository);

  Future<Either<Failure, User>> call() async {
    return await _authRepository.authWithGoogle();
  }
}
