import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/controllers/base/base_states.dart';
import '../../../../core/controllers/base/common_states.dart';
import '../../../../core/models/user_model.dart';
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

      final userModel = UserModel(
        name: event.name,
        email: event.email,
        userID: userCredential.user!.uid,
      );
      await userModel.storeUserInFirebase();
      await userModel.storeUserInLocalStorage();

      emit(SuccessfullyRegistratedUserState(userName: userModel.name));
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

      final userModel = UserModel(
        name: googleUser!.displayName!,
        email: googleUser.email,
        userID: userCredential.user!.uid,
      );
      await userModel.storeUserInFirebase();
      await userModel.storeUserInLocalStorage();

      emit(SuccessfullyRegistratedUserState(userName: userModel.name));
    } catch (exception) {
      emit(UnableToRegisterUserState());
    }
  }
}
