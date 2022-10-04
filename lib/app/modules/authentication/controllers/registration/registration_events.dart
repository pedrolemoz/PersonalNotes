abstract class RegistrationEvent {}

class RegisterWithCredentials implements RegistrationEvent {
  final String name;
  final String email;
  final String password;

  const RegisterWithCredentials({required this.name, required this.email, required this.password});
}

class RegisterWithGoogle implements RegistrationEvent {
  const RegisterWithGoogle();
}
