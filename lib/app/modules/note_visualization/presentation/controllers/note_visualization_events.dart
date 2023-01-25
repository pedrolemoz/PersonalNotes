import '../../../../core/domain/entities/note.dart';

abstract class NoteVisualizationEvent {}

class UpdateCurrentNoteInVisualizationBlocEvent
    implements NoteVisualizationEvent {
  final Note note;

  const UpdateCurrentNoteInVisualizationBlocEvent({required this.note});
}

class DeleteCurrentNoteEvent implements NoteVisualizationEvent {
  const DeleteCurrentNoteEvent();
}
