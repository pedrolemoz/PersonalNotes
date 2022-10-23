import 'package:animations/animations.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'controllers/notes_listing_bloc.dart';
import 'pages/notes_listing_page.dart';

class NotesListingModule extends Module {
  @override
  List<Bind> get binds => [Bind<NoteListingBloc>((i) => NoteListingBloc(), onDispose: (bloc) => bloc.close())];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (_, __) => NotesListingPage(),
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
