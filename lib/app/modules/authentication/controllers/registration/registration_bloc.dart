import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/controllers/base_states.dart';
import '../../../../core/controllers/common_states.dart';
import '../../../../core/utils/regular_expressions.dart';
import 'registration_events.dart';
import 'registration_states.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, AppState> {
  RegistrationBloc() : super(InitialState()) {
    on<RegisterWithCredentials>(_onRegisterWithCredentials);
    on<RegisterWithGoogle>(_onRegisterWithGoogle);
  }

  Future<void> _onRegisterWithCredentials(RegisterWithCredentials event, Emitter<AppState> emit) async {
    emit(RegistratingUserState());

    if (event.name.isEmpty) {
      emit(InvalidUserNameState());
      return;
    }

    if (event.email.isEmpty || !RegularExpressions.email.hasMatch(event.email)) {
      emit(InvalidUserEmailState());
      return;
    }

    if (event.password.isEmpty || event.password.length < 8) {
      emit(InvalidUserPasswordState());
      return;
    }

    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      await FirebaseFirestore.instance
          .collection('data')
          .doc(userCredential.user!.uid)
          .set({'name': event.name, 'email': event.email});

      emit(SuccessfullyRegistratedUserState(userName: event.name));
    } on FirebaseAuthException catch (exception) {
      switch (exception.code) {
        case 'wrong-password':
          emit(InvalidUserCredentialsState());
          return;
        case 'invalid-email':
          emit(InvalidUserCredentialsState());
          return;
        default:
          emit(UnableToRegisterUserState());
          return;
      }
    } catch (exception) {
      emit(UnableToRegisterUserState());
      return;
    }
  }

  Future<void> _onRegisterWithGoogle(RegisterWithGoogle event, Emitter<AppState> emit) async {
    emit(RegistratingUserState());

    try {
      final googleUser = await GoogleSignIn().signIn();
      final googleAuthentication = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuthentication?.accessToken,
        idToken: googleAuthentication?.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      await FirebaseFirestore.instance
          .collection('data')
          .doc(userCredential.user!.uid)
          .set({'name': googleUser!.displayName, 'email': googleUser.email});

      emit(SuccessfullyRegistratedUserState(userName: googleUser.displayName!));
    } catch (exception) {
      emit(UnableToRegisterUserState());
      return;
    }
  }
}
