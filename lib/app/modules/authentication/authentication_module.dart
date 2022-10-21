import 'package:animations/animations.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'controllers/login/login_bloc.dart';
import 'controllers/registration/registration_bloc.dart';
import 'pages/login_page.dart';
import 'pages/registration_page.dart';

class AuthenticationModule extends Module {
  @override
  List<Bind> get binds => [
        Bind<LoginBloc>((i) => LoginBloc(), onDispose: (bloc) => bloc.close()),
        Bind<RegistrationBloc>((i) => RegistrationBloc(), onDispose: (bloc) => bloc.close()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (_, __) => LoginPage(),
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
        ),
        ChildRoute(
          '/registration',
          child: (_, __) => RegistrationPage(),
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
        ),
      ];
}
