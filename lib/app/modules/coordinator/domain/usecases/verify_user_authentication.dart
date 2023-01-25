import 'package:dartz/dartz.dart';

import '../../../../core/domain/enums/auth_state.dart';
import '../../../../core/domain/failures/failure.dart';
import '../../../../core/domain/repositories/users_repository.dart';

class VerifyUserAuthentication {
  final UsersRepository _usersRepository;

  const VerifyUserAuthentication(this._usersRepository);

  Future<Either<Failure, AuthState>> call() async {
    return await _usersRepository.getAuthState();
  }
}
