import 'package:bloc/bloc.dart';

import '../../../core/controllers/base/base_states.dart';
import '../../../core/models/note_model.dart';
import '../../../core/models/user_model.dart';
import 'notes_listing_events.dart';
import 'notes_listing_states.dart';

class NoteListingBloc extends Bloc<NoteListingEvent, AppState> {
  NoteListingBloc() : super(InitialState()) {
    on<GetAllNotes>(_onGetAllNotes);
    on<RefreshAllNotes>(_onRefreshAllNotes);
  }

  List<NoteModel> notes = [];

  Future<void> _onGetAllNotes(GetAllNotes event, Emitter<AppState> emit) async {
    emit(GettingAllNotesState());

    try {
      final notesFromLocalStorage =
          await NoteModel.getAllNotesFromLocalStorage();
      final userModel = await UserModel.fromLocalStorage();
      final notesFromFirebase =
          await NoteModel.getAllNotesFromFirebase(userModel);

      for (var note in notesFromFirebase) {
        if (!notesFromLocalStorage.contains(note)) {
          final index = notesFromLocalStorage.indexWhere(
            (noteFromLocalStorage) =>
                noteFromLocalStorage.uniqueIdentifier == note.uniqueIdentifier,
          );

          if (index == -1) {
            await note.storeNoteInLocalStorage();
            notesFromLocalStorage.add(note);
            continue;
          }

          notesFromLocalStorage[index] = note;
        }
      }

      notes = notesFromLocalStorage.toList();

      for (var note in notesFromLocalStorage) {
        if (!notesFromFirebase.contains(note)) {
          note.deleteCurrentNoteFromLocalStorage();
          notes.remove(note);
        }
      }

      if (notes.isEmpty) {
        emit(ZeroNotesToShowState());
        return;
      }

      emit(SuccessfullyGotAllNotesState());
    } catch (exception) {
      emit(UnableToGetNotesState());
    }
  }

  Future<void> _onRefreshAllNotes(
    RefreshAllNotes event,
    Emitter<AppState> emit,
  ) async {
    emit(RefreshingAllNotesState());
    notes.clear();
    add(const GetAllNotes());
  }
}
