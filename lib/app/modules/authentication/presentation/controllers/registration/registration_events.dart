abstract class RegistrationEvent {}

class RegisterWithCredentialsEvent implements RegistrationEvent {
  final String name;
  final String email;
  final String password;

  const RegisterWithCredentialsEvent({
    required this.name,
    required this.email,
    required this.password,
  });
}

class RegisterWithGoogleEvent implements RegistrationEvent {
  const RegisterWithGoogleEvent();
}
