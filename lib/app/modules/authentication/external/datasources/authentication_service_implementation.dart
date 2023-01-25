import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../../../../core/domain/entities/user.dart';
import '../../../../core/external/mappers/user_mapper.dart';
import '../../domain/inputs/login_with_credentials_input.dart';
import '../../domain/inputs/register_with_credentials_input.dart';
import '../../infrastructure/datasources/authentication_service.dart';
import '../../infrastructure/exceptions/exceptions.dart';

class AuthenticationServiceImplementation implements AuthenticationService {
  @override
  Future<User> registerWithCredentials(
    RegisterWithCredentialsInput input,
  ) async {
    try {
      final userCredential = await firebase_auth.FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: input.email,
        password: input.password,
      );

      final user = User(
        name: input.name,
        email: input.email,
        userID: userCredential.user!.uid,
      );

      return user;
    } on firebase_auth.FirebaseAuthException catch (exception) {
      switch (exception.code) {
        case 'wrong-password':
          throw InvalidUserCredentialsException();
        case 'invalid-email':
          throw InvalidUserCredentialsException();
        default:
          throw UnableToRegisterUserException();
      }
    } catch (exception) {
      throw UnableToRegisterUserException();
    }
  }

  @override
  Future<User> loginWithCredentials(LoginWithCredentialsInput input) async {
    try {
      final userCredential =
          await firebase_auth.FirebaseAuth.instance.signInWithEmailAndPassword(
        email: input.email,
        password: input.password,
      );

      final userDataReference = await FirebaseFirestore.instance
          .collection('data')
          .doc(userCredential.user!.uid)
          .get();

      final userData = userDataReference.data()!;

      final user = UserMapper.fromMap(userData);

      return user;
    } on firebase_auth.FirebaseAuthException catch (exception) {
      switch (exception.code) {
        case 'wrong-password':
          throw InvalidUserCredentialsException();
        case 'invalid-email':
          throw InvalidUserCredentialsException();
        case 'user-not-found':
          throw UserNotFoundException();
        default:
          throw UnableToAuthenticateUserException();
      }
    } catch (exception) {
      throw UnableToAuthenticateUserException();
    }
  }
}
