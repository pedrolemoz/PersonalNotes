import 'package:animations/animations.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'controllers/note_creation_bloc.dart';
import 'pages/note_creation_page.dart';

class NoteCreationModule extends Module {
  @override
  List<Bind> get binds => [Bind<NoteCreationBloc>((i) => NoteCreationBloc(), onDispose: (bloc) => bloc.close())];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (_, __) => NoteCreationPage(),
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
