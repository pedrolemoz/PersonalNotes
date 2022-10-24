import 'package:bloc/bloc.dart';

import '../../../core/controllers/base/base_states.dart';
import '../../../core/controllers/base/common_states.dart';
import '../../../core/models/note_model.dart';
import '../../../core/models/user_model.dart';
import 'note_visualization_events.dart';
import 'note_visualization_states.dart';

class NoteVisualizationBloc extends Bloc<NoteVisualizationEvent, AppState> {
  NoteVisualizationBloc() : super(InitialState()) {
    on<UpdateCurrentNoteInVisualizationBloc>(_onUpdateCurrentNoteInVisualizationBloc);
    on<DeleteCurrentNote>(_onDeleteCurrentNote);
  }

  late NoteModel noteModel;

  Future<void> _onUpdateCurrentNoteInVisualizationBloc(
    UpdateCurrentNoteInVisualizationBloc event,
    Emitter<AppState> emit,
  ) async {
    emit(UpdatingCurrentNoteState());

    try {
      noteModel = event.noteModel;
      emit(SuccessfullyUpdatedCurrentNoteState());
    } catch (exception) {
      emit(UnableToUpdateCurrentNoteState());
    }
  }

  Future<void> _onDeleteCurrentNote(DeleteCurrentNote event, Emitter<AppState> emit) async {
    emit(DeletingCurrentNoteState());

    try {
      await noteModel.deleteCurrentNoteFromLocalStorage();
      final userModel = await UserModel.fromLocalStorage();
      await noteModel.deleteCurrentNoteFromFirebase(userModel);
      emit(SuccessfullyDeletedCurrentNoteState());
    } catch (exception) {
      emit(UnableToDeleteCurrentNoteState());
    }
  }
}
