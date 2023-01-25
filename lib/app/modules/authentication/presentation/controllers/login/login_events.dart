abstract class LoginEvent {}

class LoginWithCredentialsEvent implements LoginEvent {
  final String email;
  final String password;

  const LoginWithCredentialsEvent({
    required this.email,
    required this.password,
  });
}

class LoginWithGoogleEvent implements LoginEvent {
  const LoginWithGoogleEvent();
}
