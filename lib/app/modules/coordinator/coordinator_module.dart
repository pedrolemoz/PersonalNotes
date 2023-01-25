import 'package:animations/animations.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'domain/usecases/verify_user_authentication.dart';
import 'presentation/controllers/coordinator_bloc.dart';
import 'presentation/pages/coordinator_page.dart';

class CoordinatorModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => VerifyUserAuthentication(i())),
        Bind<CoordinatorBloc>(
          (i) => CoordinatorBloc(i()),
          onDispose: (bloc) => bloc.close(),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (_, __) => CoordinatorPage(),
          transition: TransitionType.custom,
          customTransition: CustomTransition(
            transitionDuration: const Duration(milliseconds: 400),
            transitionBuilder: (context, animation, secondaryAnimation, child) {
              return SharedAxisTransition(
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                transitionType: SharedAxisTransitionType.horizontal,
                child: child,
              );
            },
          ),
        )
      ];
}
