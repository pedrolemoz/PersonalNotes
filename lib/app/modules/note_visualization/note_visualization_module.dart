import 'package:animations/animations.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'controllers/note_visualization_bloc.dart';
import 'pages/note_visualization_page.dart';

class NoteVisualizationModule extends Module {
  @override
  List<Bind> get binds => [
        Bind<NoteVisualizationBloc>(
          (i) => NoteVisualizationBloc(),
          onDispose: (bloc) => bloc.close(),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (_, args) => NoteVisualizationPage(noteModel: args.data),
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
