import '../entities/note.dart';

class EditNoteInput {
  final String title;
  final String content;
  final Note note;

  const EditNoteInput({
    required this.title,
    required this.content,
    required this.note,
  });
}
