import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/controllers/base/base_states.dart';
import '../../../../core/controllers/base/common_states.dart';
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
      final userModel = await UserModel.loginWithCredentials(event.email, event.password);
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
    }
  }

  Future<void> _onLoginWithGoogle(LoginWithGoogle event, Emitter<AppState> emit) async {
    emit(AuthenticatingUserState());

    try {
      final userModel = await UserModel.authWithGoogle();
      emit(SuccessfullyAuthenticatedUserState(userName: userModel.name));
    } catch (exception) {
      emit(UnableToAuthenticateUserState());
    }
  }
}
