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
      final userModel = await UserModel.fromLocalStorage();
      await NoteModel.getAllNotesFromFirebase(userModel);
      notes = await NoteModel.getAllNotesFromLocalStorage();

      if (notes.isEmpty) {
        emit(ZeroNotesToShowState());
        return;
      }

      emit(SuccessfullyGotAllNotesState());
    } catch (exception) {
      emit(UnableToGetNotesState());
    }
  }

  Future<void> _onRefreshAllNotes(RefreshAllNotes event, Emitter<AppState> emit) async {
    emit(RefreshingAllNotesState());
    notes.clear();
    add(const GetAllNotes());
  }
}
