import 'user_model.dart';

class NoteModel {
  final String title;
  final String content;
  final DateTime date;
  final UserModel userModel;

  const NoteModel({
    required this.title,
    required this.content,
    required this.date,
    required this.userModel,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NoteModel && other.title == title && other.content == content && other.date == date;
  }

  @override
  int get hashCode => title.hashCode ^ content.hashCode ^ date.hashCode;
}
