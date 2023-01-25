import 'package:bloc/bloc.dart';

import '../../../../../core/presentation/controllers/base/base_states.dart';
import '../../../domain/failures/authentication_failures.dart';
import '../../../domain/inputs/register_with_credentials_input.dart';
import '../../../domain/usecases/auth_with_google.dart';
import '../../../domain/usecases/register_with_credentials.dart';
import '../common/authentication_common_states.dart';
import 'registration_events.dart';
import 'registration_states.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, AppState> {
  final RegisterWithCredentials _registerWithCredentials;
  final AuthWithGoogle _authWithGoogle;

  RegistrationBloc(this._registerWithCredentials, this._authWithGoogle)
      : super(InitialState()) {
    on<RegisterWithCredentialsEvent>(_onRegisterWithCredentialsEvent);
    on<RegisterWithGoogleEvent>(_onRegisterWithGoogleEvent);
  }

  Future<void> _onRegisterWithCredentialsEvent(
    RegisterWithCredentialsEvent event,
    Emitter<AppState> emit,
  ) async {
    emit(RegistratingUserState());

    final result = await _registerWithCredentials(
      RegisterWithCredentialsInput(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );

    emit(
      result.fold(
        (failure) {
          switch (failure.runtimeType) {
            case InvalidUserNameFailure:
              return InvalidUserNameState();
            case InvalidUserEmailFailure:
              return InvalidUserEmailState();
            case InvalidUserPasswordFailure:
              return InvalidUserPasswordState();
            case InvalidUserCredentialsFailure:
              return InvalidUserCredentialsState();
            default:
              return UnableToRegisterUserState();
          }
        },
        (sucess) => SuccessfullyRegistratedUserState(userName: sucess.name),
      ),
    );
  }

  Future<void> _onRegisterWithGoogleEvent(
    RegisterWithGoogleEvent event,
    Emitter<AppState> emit,
  ) async {
    emit(RegistratingUserState());

    final result = await _authWithGoogle();

    emit(
      result.fold(
        (failure) => UnableToRegisterUserState(),
        (sucess) => SuccessfullyRegistratedUserState(userName: sucess.name),
      ),
    );
  }
}
