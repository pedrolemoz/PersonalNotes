import 'package:bloc/bloc.dart';

import '../../../../core/domain/entities/note.dart';
import '../../../../core/domain/failures/notes_failures.dart';
import '../../../../core/presentation/controllers/base/base_states.dart';
import '../../domain/usecases/get_all_notes.dart';
import 'notes_listing_events.dart';
import 'notes_listing_states.dart';

class NoteListingBloc extends Bloc<NoteListingEvent, AppState> {
  final GetAllNotes _getAllNotes;

  NoteListingBloc(this._getAllNotes) : super(InitialState()) {
    on<GetAllNotesEvent>(_onGetAllNotesEvent);
    on<RefreshAllNotesEvent>(_onRefreshAllNotesEvent);
  }

  List<Note> notes = [];

  Future<void> _onGetAllNotesEvent(
    GetAllNotesEvent event,
    Emitter<AppState> emit,
  ) async {
    emit(GettingAllNotesState());

    final result = await _getAllNotes();

    emit(
      result.fold(
        (failure) {
          switch (failure.runtimeType) {
            case ZeroNotesFoundFailure:
              return ZeroNotesToShowState();
            default:
              return UnableToGetNotesState();
          }
        },
        (success) {
          notes = success.toList();
          return SuccessfullyGotAllNotesState();
        },
      ),
    );
  }

  Future<void> _onRefreshAllNotesEvent(
    RefreshAllNotesEvent event,
    Emitter<AppState> emit,
  ) async {
    emit(RefreshingAllNotesState());
    notes.clear();
    add(const GetAllNotesEvent());
  }
}
