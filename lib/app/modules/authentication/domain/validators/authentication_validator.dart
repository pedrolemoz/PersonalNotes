import '../../../../core/utils/regular_expressions.dart';

class AuthenticationValidator {
  const AuthenticationValidator._();

  static bool hasValidName(String name) => name.isNotEmpty;

  static bool hasValidEmail(String email) =>
      email.isNotEmpty || RegularExpressions.email.hasMatch(email);

  static bool hasValidPassword(String password) =>
      password.isNotEmpty && password.length >= 8;
}
