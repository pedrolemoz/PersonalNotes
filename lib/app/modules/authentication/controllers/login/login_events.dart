abstract class LoginEvent {}

class LoginWithCredentials implements LoginEvent {
  final String email;
  final String password;

  const LoginWithCredentials({required this.email, required this.password});
}

class LoginWithGoogle implements LoginEvent {
  const LoginWithGoogle();
}
