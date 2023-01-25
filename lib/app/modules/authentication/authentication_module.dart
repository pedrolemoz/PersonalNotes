import 'package:animations/animations.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'domain/usecases/auth_with_google.dart';
import 'domain/usecases/login_with_credentials.dart';
import 'domain/usecases/register_with_credentials.dart';
import 'external/datasources/authentication_service_implementation.dart';
import 'external/datasources/google_auth_service_implementation.dart';
import 'infrastructure/repositories/authentication_repository_implementation.dart';
import 'presentation/controllers/login/login_bloc.dart';
import 'presentation/controllers/registration/registration_bloc.dart';
import 'presentation/pages/login_page.dart';
import 'presentation/pages/registration_page.dart';

class AuthenticationModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => GoogleAuthServiceImplementation()),
        Bind((i) => AuthenticationServiceImplementation()),
        Bind((i) => AuthenticationRepositoryImplementation(i(), i(), i(), i())),
        Bind((i) => AuthWithGoogle(i())),
        Bind((i) => LoginWithCredentials(i())),
        Bind((i) => RegisterWithCredentials(i())),
        Bind<LoginBloc>(
          (i) => LoginBloc(i(), i()),
          onDispose: (bloc) => bloc.close(),
        ),
        Bind<RegistrationBloc>(
          (i) => RegistrationBloc(i(), i()),
          onDispose: (bloc) => bloc.close(),
        ),
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
