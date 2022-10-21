import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/controllers/base/base_states.dart';
import '../../../core/controllers/root/root_bloc.dart';
import '../../../core/controllers/root/root_events.dart';
import '../../../core/controllers/root/root_states.dart';
import '../../../core/utils/typography.dart';

class CoordinatorPage extends StatefulWidget {
  @override
  State<CoordinatorPage> createState() => _CoordinatorPageState();
}

class _CoordinatorPageState extends State<CoordinatorPage> {
  final rootBloc = Modular.get<RootBloc>();

  @override
  void initState() {
    rootBloc.add(const VerifyUserAuthentication());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RootBloc, AppState>(
      bloc: rootBloc,
      listener: (context, state) {
        if (state is UserAuthenticatedState) {
          Modular.to.navigate('/home/');
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
