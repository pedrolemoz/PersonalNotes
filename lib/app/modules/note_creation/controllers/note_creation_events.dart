abstract class NoteCreationEvent {}

class CreateNewNote implements NoteCreationEvent {
  final String title;
  final String content;

  const CreateNewNote({required this.title, required this.content});
}
