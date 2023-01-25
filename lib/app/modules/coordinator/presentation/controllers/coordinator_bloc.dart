import 'package:bloc/bloc.dart';

import '../../../../core/domain/enums/auth_state.dart';
import '../../../../core/presentation/controllers/base/base_states.dart';
import '../../domain/usecases/verify_user_authentication.dart';
import 'coordinator_events.dart';
import 'coordinator_states.dart';

class CoordinatorBloc extends Bloc<CoordinatorEvent, AppState> {
  final VerifyUserAuthentication _verifyUserAuthentication;

  CoordinatorBloc(this._verifyUserAuthentication) : super(InitialState()) {
    on<VerifyUserAuthenticationEvent>(_onVerifyUserAuthenticationEvent);
  }

  Future<void> _onVerifyUserAuthenticationEvent(
    VerifyUserAuthenticationEvent event,
    Emitter<AppState> emit,
  ) async {
    emit(VerifyingUserAuthenticationState());

    final result = await _verifyUserAuthentication();

    emit(
      result.fold(
        (failure) => UserNotAuthenticatedState(),
        (success) => success == AuthState.authenticated
            ? UserAuthenticatedState()
            : UserNotAuthenticatedState(),
      ),
    );
  }
}
