import '../../../../core/domain/entities/user.dart';
import '../../domain/inputs/login_with_credentials_input.dart';
import '../../domain/inputs/register_with_credentials_input.dart';

abstract class AuthenticationService {
  Future<User> registerWithCredentials(
    RegisterWithCredentialsInput input,
  );

  Future<User> loginWithCredentials(
    LoginWithCredentialsInput input,
  );
}
