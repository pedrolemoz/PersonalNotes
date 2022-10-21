import 'package:animations/animations.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'core/controllers/root/root_bloc.dart';
import 'modules/authentication/authentication_module.dart';
import 'modules/coordinator/coordinator_module.dart';
import 'modules/home/home_module.dart';

class RootModule extends Module {
  @override
  List<Bind> get binds => [Bind<RootBloc>((i) => RootBloc(), onDispose: (bloc) => bloc.close())];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(
          '/',
          module: CoordinatorModule(),
          transition: TransitionType.custom,
          customTransition: CustomTransition(
            transitionDuration: const Duration(milliseconds: 400),
            transitionBuilder: (context, animation, secondaryAnimation, child) {
              return FadeThroughTransition(
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                child: child,
              );
            },
          ),
        ),
        ModuleRoute(
          '/authentication',
          module: AuthenticationModule(),
          transition: TransitionType.custom,
          customTransition: CustomTransition(
            transitionDuration: const Duration(milliseconds: 400),
            transitionBuilder: (context, animation, secondaryAnimation, child) {
              return FadeThroughTransition(
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                child: child,
              );
            },
          ),
        ),
        ModuleRoute(
          '/home',
          module: HomeModule(),
          transition: TransitionType.custom,
          customTransition: CustomTransition(
            transitionDuration: const Duration(milliseconds: 400),
            transitionBuilder: (context, animation, secondaryAnimation, child) {
              return FadeThroughTransition(
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                child: child,
              );
            },
          ),
        ),
      ];
}
