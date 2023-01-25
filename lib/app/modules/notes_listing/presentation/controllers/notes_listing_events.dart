abstract class NoteListingEvent {}

class GetAllNotesEvent implements NoteListingEvent {
  const GetAllNotesEvent();
}

class RefreshAllNotesEvent implements NoteListingEvent {
  const RefreshAllNotesEvent();
}
