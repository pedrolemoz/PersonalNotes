import 'package:bloc/bloc.dart';

import '../../../../core/domain/failures/notes_failures.dart';
import '../../../../core/domain/inputs/create_note_input.dart';
import '../../../../core/domain/inputs/edit_note_input.dart';
import '../../../../core/domain/usecases/create_note.dart';
import '../../../../core/domain/usecases/edit_note.dart';
import '../../../../core/presentation/controllers/base/base_states.dart';
import 'note_creation_events.dart';
import 'note_creation_states.dart';

class NoteCreationBloc extends Bloc<NoteCreationEvent, AppState> {
  final CreateNote _createNote;
  final EditNote _editNote;

  NoteCreationBloc(this._createNote, this._editNote) : super(InitialState()) {
    on<CreateNewNoteEvent>(_onCreateNewNoteEvent);
    on<EditCurrentNoteEvent>(_onEditCurrentNoteEvent);
  }

  Future<void> _onCreateNewNoteEvent(
    CreateNewNoteEvent event,
    Emitter<AppState> emit,
  ) async {
    emit(CreatingNewNoteState());

    final result = await _createNote(
      CreateNoteInput(
        title: event.title,
        content: event.content,
      ),
    );

    emit(
      result.fold(
        (failure) {
          switch (failure.runtimeType) {
            case InvalidNoteTitleFailure:
              return InvalidNoteTitleState();
            case InvalidNoteContentFailure:
              return InvalidNoteContentState();
            default:
              return UnableToCreateNewNoteState();
          }
        },
        (success) => SuccessfullyCreatedNewNoteState(createdNote: success),
      ),
    );
  }

  Future<void> _onEditCurrentNoteEvent(
    EditCurrentNoteEvent event,
    Emitter<AppState> emit,
  ) async {
    emit(EditingCurrentNoteState());

    final result = await _editNote(
      EditNoteInput(
        title: event.title,
        content: event.content,
        note: event.note,
      ),
    );

    emit(
      result.fold(
        (failure) {
          switch (failure.runtimeType) {
            case InvalidNoteTitleFailure:
              return InvalidNoteTitleState();
            case InvalidNoteContentFailure:
              return InvalidNoteContentState();
            default:
              return UnableToEditCurrentNoteState();
          }
        },
        (success) => SuccessfullyEditedCurrentNoteState(editedNote: success),
      ),
    );
  }
}
