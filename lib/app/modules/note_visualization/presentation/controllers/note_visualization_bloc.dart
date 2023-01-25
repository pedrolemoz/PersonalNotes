import 'package:bloc/bloc.dart';

import '../../../../core/domain/entities/note.dart';
import '../../../../core/domain/inputs/delete_note_input.dart';
import '../../../../core/domain/usecases/delete_note.dart';
import '../../../../core/presentation/controllers/base/base_states.dart';
import '../../../../core/presentation/controllers/base/common_states.dart';
import 'note_visualization_events.dart';
import 'note_visualization_states.dart';

class NoteVisualizationBloc extends Bloc<NoteVisualizationEvent, AppState> {
  final DeleteNote _deleteNote;

  NoteVisualizationBloc(this._deleteNote) : super(InitialState()) {
    on<UpdateCurrentNoteInVisualizationBlocEvent>(
      _onUpdateCurrentNoteInVisualizationBlocEvent,
    );
    on<DeleteCurrentNoteEvent>(_onDeleteCurrentNoteEvent);
  }

  late Note note;

  Future<void> _onUpdateCurrentNoteInVisualizationBlocEvent(
    UpdateCurrentNoteInVisualizationBlocEvent event,
    Emitter<AppState> emit,
  ) async {
    emit(UpdatingCurrentNoteState());

    try {
      note = event.note;
      emit(SuccessfullyUpdatedCurrentNoteState());
    } catch (exception) {
      emit(UnableToUpdateCurrentNoteState());
    }
  }

  Future<void> _onDeleteCurrentNoteEvent(
    DeleteCurrentNoteEvent event,
    Emitter<AppState> emit,
  ) async {
    emit(DeletingCurrentNoteState());

    final result = await _deleteNote(DeleteNoteInput(note: note));

    emit(
      result.fold(
        (failure) => UnableToDeleteCurrentNoteState(),
        (success) => SuccessfullyDeletedCurrentNoteState(),
      ),
    );
  }
}
