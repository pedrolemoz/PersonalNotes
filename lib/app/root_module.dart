import 'package:animations/animations.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/authentication/authentication_module.dart';
import 'modules/coordinator/controllers/coordinator_bloc.dart';
import 'modules/coordinator/coordinator_module.dart';
import 'modules/note_creation/note_creation_module.dart';
import 'modules/note_visualization/note_visualization_module.dart';
import 'modules/notes_listing/notes_listing_module.dart';

class RootModule extends Module {
  @override
  List<Bind> get binds => [Bind<CoordinatorBloc>((i) => CoordinatorBloc(), onDispose: (bloc) => bloc.close())];

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
          '/notes_listing',
          module: NotesListingModule(),
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
          '/note_visualization',
          module: NoteVisualizationModule(),
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
          '/note_creation',
          module: NoteCreationModule(),
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
