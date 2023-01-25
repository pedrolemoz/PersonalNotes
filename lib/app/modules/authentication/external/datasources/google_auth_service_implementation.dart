import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/domain/entities/user.dart';
import '../../infrastructure/datasources/google_auth_service.dart';
import '../../infrastructure/exceptions/exceptions.dart';

class GoogleAuthServiceImplementation implements GoogleAuthService {
  @override
  Future<User> authWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      final googleAuthentication = await googleUser?.authentication;

      final credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuthentication?.accessToken,
        idToken: googleAuthentication?.idToken,
      );

      final userCredential = await firebase_auth.FirebaseAuth.instance
          .signInWithCredential(credential);

      final user = User(
        name: googleUser!.displayName!,
        email: googleUser.email,
        userID: userCredential.user!.uid,
      );

      return user;
    } catch (_) {
      throw UnableToAuthenticateUserException();
    }
  }
}
