import 'package:bloc/bloc.dart';

import '../../../core/controllers/base/base_states.dart';
import '../../../core/models/user_model.dart';
import '../../enums/auth_state.dart';
import 'root_events.dart';
import 'root_states.dart';

class RootBloc extends Bloc<RootEvent, AppState> {
  RootBloc() : super(InitialState()) {
    on<VerifyUserAuthentication>(_onVerifyUserAuthentication);
  }

  AuthState authState = AuthState.notAuthenticated;

  UserModel? userModel;

  Future<void> _onVerifyUserAuthentication(VerifyUserAuthentication event, Emitter<AppState> emit) async {
    emit(VerifyingUserAuthenticationState());

    if (await UserModel.userExistsInLocalStorage()) {
      userModel = await UserModel.fromLocalStorage();
      authState = AuthState.authenticated;
      emit(UserAuthenticatedState());
      return;
    }

    authState = AuthState.notAuthenticated;
    emit(UserNotAuthenticatedState());
    return;
  }
}
