import 'package:bloc/bloc.dart';

import '../../../core/controllers/base/base_states.dart';
import '../../../core/models/note_model.dart';
import 'note_creation_events.dart';
import 'note_creation_states.dart';

class NoteCreationBloc extends Bloc<NoteCreationEvent, AppState> {
  NoteCreationBloc() : super(InitialState()) {
    on<CreateNewNote>(_onCreateNewNote);
  }

  Future<void> _onCreateNewNote(CreateNewNote event, Emitter<AppState> emit) async {
    emit(CreatingNewNoteState());

    try {
      final noteModel = NoteModel(title: event.title, content: event.content);
      await noteModel.storeNoteInLocalStorage();
      emit(SuccessfullyCreatedNewNoteState());
    } catch (exception) {
      emit(UnableToCreateNewNoteState());
    }
  }
}
