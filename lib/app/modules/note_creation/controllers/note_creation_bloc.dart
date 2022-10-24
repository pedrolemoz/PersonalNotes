import 'package:bloc/bloc.dart';

import '../../../core/controllers/base/base_states.dart';
import '../../../core/models/note_model.dart';
import '../../../core/models/user_model.dart';
import 'note_creation_events.dart';
import 'note_creation_states.dart';

class NoteCreationBloc extends Bloc<NoteCreationEvent, AppState> {
  NoteCreationBloc() : super(InitialState()) {
    on<CreateNewNote>(_onCreateNewNote);
    on<EditCurrentNote>(_onEditCurrentNote);
  }

  Future<void> _onCreateNewNote(CreateNewNote event, Emitter<AppState> emit) async {
    emit(CreatingNewNoteState());

    if (event.title.isEmpty) {
      emit(InvalidNoteTitleState());
      return;
    }

    if (event.content.isEmpty) {
      emit(InvalidNoteContentState());
      return;
    }

    try {
      final noteModel = NoteModel(title: event.title, content: event.content);
      await noteModel.storeNoteInLocalStorage();
      final userModel = await UserModel.fromLocalStorage();
      await noteModel.storeNoteInFirebase(userModel);
      emit(SuccessfullyCreatedNewNoteState(createdNoteModel: noteModel));
    } catch (exception) {
      emit(UnableToCreateNewNoteState());
    }
  }

  Future<void> _onEditCurrentNote(EditCurrentNote event, Emitter<AppState> emit) async {
    emit(EditingCurrentNoteState());

    if (event.title.isEmpty) {
      emit(InvalidNoteTitleState());
      return;
    }

    if (event.content.isEmpty) {
      emit(InvalidNoteContentState());
      return;
    }

    try {
      final noteModel = event.noteModel.copyWith(title: event.title, content: event.content, date: DateTime.now());
      await noteModel.updateCurrentNoteInLocalStorage();
      final userModel = await UserModel.fromLocalStorage();
      await noteModel.updateCurrentNoteInFirebase(userModel);
      emit(SuccessfullyEditedCurrentNoteState(editedNoteModel: noteModel));
    } catch (exception) {
      emit(UnableToEditCurrentNoteState());
    }
  }
}
