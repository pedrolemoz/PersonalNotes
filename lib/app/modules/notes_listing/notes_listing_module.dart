import 'package:animations/animations.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'domain/usecases/get_all_notes.dart';
import 'presentation/controllers/notes_listing_bloc.dart';
import 'presentation/pages/notes_listing_page.dart';

class NotesListingModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => GetAllNotes(i())),
        Bind<NoteListingBloc>(
          (i) => NoteListingBloc(i()),
          onDispose: (bloc) => bloc.close(),
        )
      ];

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
