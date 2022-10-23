abstract class NoteListingEvent {}

class GetAllNotes implements NoteListingEvent {
  const GetAllNotes();
}

class RefreshAllNotes implements NoteListingEvent {
  const RefreshAllNotes();
}
