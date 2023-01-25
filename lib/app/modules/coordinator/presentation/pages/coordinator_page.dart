import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/presentation/controllers/base/base_states.dart';
import '../../../../core/presentation/utils/typography.dart';
import '../controllers/coordinator_bloc.dart';
import '../controllers/coordinator_events.dart';
import '../controllers/coordinator_states.dart';

class CoordinatorPage extends StatefulWidget {
  @override
  State<CoordinatorPage> createState() => _CoordinatorPageState();
}

class _CoordinatorPageState extends State<CoordinatorPage> {
  final coordinatorBloc = Modular.get<CoordinatorBloc>();

  @override
  void initState() {
    coordinatorBloc.add(const VerifyUserAuthenticationEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CoordinatorBloc, AppState>(
      bloc: coordinatorBloc,
      listener: (context, state) {
        if (state is UserAuthenticatedState) {
          Modular.to.navigate('/notes_listing/');
        }

        if (state is UserNotAuthenticatedState) {
          Modular.to.navigate('/authentication/');
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  child: CircularProgressIndicator(strokeWidth: 3),
                  height: 25,
                  width: 25,
                ),
                const SizedBox(width: 16),
                Text(
                  'Verificando dados',
                  style: AppTypography.textHeadline(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
