import '../../../core/models/note_model.dart';

abstract class NoteVisualizationEvent {}

class UpdateCurrentNoteInVisualizationBloc implements NoteVisualizationEvent {
  final NoteModel noteModel;

  const UpdateCurrentNoteInVisualizationBloc({required this.noteModel});
}

class DeleteCurrentNote implements NoteVisualizationEvent {
  const DeleteCurrentNote();
}
