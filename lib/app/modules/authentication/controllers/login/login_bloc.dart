import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/controllers/base_states.dart';
import '../../../../core/controllers/common_states.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/utils/regular_expressions.dart';
import 'login_events.dart';
import 'login_states.dart';

class LoginBloc extends Bloc<LoginEvent, AppState> {
  LoginBloc() : super(InitialState()) {
    on<LoginWithCredentials>(_onLoginWithCredentials);
    on<LoginWithGoogle>(_onLoginWithGoogle);
  }

  Future<void> _onLoginWithCredentials(LoginWithCredentials event, Emitter<AppState> emit) async {
    emit(AuthenticatingUserState());

    if (event.email.isEmpty || !RegularExpressions.email.hasMatch(event.email)) {
      emit(InvalidUserEmailState());
      return;
    }

    if (event.password.isEmpty || event.password.length < 8) {
      emit(InvalidUserPasswordState());
      return;
    }

    try {
      final authenticationService = FirebaseAuth.instance;

      final userCredential = await authenticationService.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      final userModel = await UserModel.fromFirebase(userCredential);
      await userModel.storeUserInLocalStorage();

      emit(SuccessfullyAuthenticatedUserState(userName: userModel.name));
    } on FirebaseAuthException catch (exception) {
      switch (exception.code) {
        case 'wrong-password':
          emit(InvalidUserCredentialsState());
          return;
        case 'invalid-email':
          emit(InvalidUserCredentialsState());
          return;
        case 'user-not-found':
          emit(UserNotFoundState());
          return;
        default:
          emit(UnableToAuthenticateUserState());
          return;
      }
    } catch (exception) {
      emit(UnableToAuthenticateUserState());
      return;
    }
  }

  Future<void> _onLoginWithGoogle(LoginWithGoogle event, Emitter<AppState> emit) async {
    emit(AuthenticatingUserState());

    try {
      final googleUser = await GoogleSignIn().signIn();
      final googleAuthentication = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuthentication?.accessToken,
        idToken: googleAuthentication?.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      late UserModel userModel;

      if (await UserModel.userExistsInFirebase(userCredential)) {
        userModel = await UserModel.fromFirebase(userCredential);
      } else {
        userModel = UserModel(name: googleUser!.displayName!, email: googleUser.email);
        await userModel.storeUserInFirebase(userCredential);
      }

      await userModel.storeUserInLocalStorage();

      emit(SuccessfullyAuthenticatedUserState(userName: userModel.name));
    } catch (exception) {
      emit(UnableToAuthenticateUserState());
      return;
    }
  }
}
