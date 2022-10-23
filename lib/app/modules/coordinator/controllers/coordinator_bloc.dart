import 'package:bloc/bloc.dart';

import '../../../core/controllers/base/base_states.dart';
import '../../../core/models/user_model.dart';
import 'coordinator_events.dart';
import 'coordinator_states.dart';

class CoordinatorBloc extends Bloc<CoordinatorEvent, AppState> {
  CoordinatorBloc() : super(InitialState()) {
    on<VerifyUserAuthentication>(_onVerifyUserAuthentication);
  }

  Future<void> _onVerifyUserAuthentication(VerifyUserAuthentication event, Emitter<AppState> emit) async {
    emit(VerifyingUserAuthenticationState());

    if (await UserModel.userExistsInLocalStorage()) {
      emit(UserAuthenticatedState());
      return;
    }

    emit(UserNotAuthenticatedState());
  }
}
