import 'package:bloc/bloc.dart';

import '../../../../../core/presentation/controllers/base/base_states.dart';
import '../../../domain/failures/authentication_failures.dart';
import '../../../domain/inputs/login_with_credentials_input.dart';
import '../../../domain/usecases/auth_with_google.dart';
import '../../../domain/usecases/login_with_credentials.dart';
import '../common/authentication_common_states.dart';
import 'login_events.dart';
import 'login_states.dart';

class LoginBloc extends Bloc<LoginEvent, AppState> {
  final LoginWithCredentials _loginWithCredentials;
  final AuthWithGoogle _authWithGoogle;

  LoginBloc(this._loginWithCredentials, this._authWithGoogle)
      : super(InitialState()) {
    on<LoginWithCredentialsEvent>(_onLoginWithCredentialsEvent);
    on<LoginWithGoogleEvent>(_onLoginWithGoogleEvent);
  }

  Future<void> _onLoginWithCredentialsEvent(
    LoginWithCredentialsEvent event,
    Emitter<AppState> emit,
  ) async {
    emit(AuthenticatingUserState());

    final result = await _loginWithCredentials(
      LoginWithCredentialsInput(
        email: event.email,
        password: event.password,
      ),
    );

    emit(
      result.fold(
        (failure) {
          switch (failure.runtimeType) {
            case InvalidUserEmailFailure:
              return InvalidUserEmailState();
            case InvalidUserPasswordFailure:
              return InvalidUserPasswordState();
            case InvalidUserCredentialsFailure:
              return InvalidUserCredentialsState();
            case UserNotFoundFailure:
              return InvalidUserCredentialsState();
            default:
              return UnableToAuthenticateUserState();
          }
        },
        (sucess) => SuccessfullyAuthenticatedUserState(userName: sucess.name),
      ),
    );
  }

  Future<void> _onLoginWithGoogleEvent(
    LoginWithGoogleEvent event,
    Emitter<AppState> emit,
  ) async {
    emit(AuthenticatingUserState());

    final result = await _authWithGoogle();

    emit(
      result.fold(
        (failure) => UnableToAuthenticateUserState(),
        (sucess) => SuccessfullyAuthenticatedUserState(userName: sucess.name),
      ),
    );
  }
}
