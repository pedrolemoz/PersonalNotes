import 'package:animations/animations.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'core/domain/usecases/create_note.dart';
import 'core/domain/usecases/delete_note.dart';
import 'core/domain/usecases/edit_note.dart';
import 'core/external/datasources/id_generator_implementation.dart';
import 'core/external/datasources/notes_local_database_implementation.dart';
import 'core/external/datasources/notes_remote_database_implementation.dart';
import 'core/external/datasources/users_local_database_implementation.dart';
import 'core/external/datasources/users_remote_database_implementation.dart';
import 'core/infrastucture/repositories/notes_repository_implementation.dart';
import 'core/infrastucture/repositories/users_repository_implementation.dart';
import 'modules/authentication/authentication_module.dart';
import 'modules/coordinator/coordinator_module.dart';
import 'modules/note_creation/note_creation_module.dart';
import 'modules/note_visualization/note_visualization_module.dart';
import 'modules/notes_listing/notes_listing_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => const IdGeneratorImplementation()),
        Bind((i) => UsersRemoteDataBaseImplementation()),
        Bind((i) => UsersLocalDataBaseImplementation()),
        Bind((i) => UsersRepositoryImplementation(i())),
        Bind((i) => NotesLocalDataBaseImplementation()),
        Bind((i) => NotesRemoteDataBaseImplementation()),
        Bind((i) => NotesRepositoryImplementation(i(), i(), i(), i())),
        Bind((i) => DeleteNote(i())),
        Bind((i) => CreateNote(i())),
        Bind((i) => EditNote(i())),
      ];

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
