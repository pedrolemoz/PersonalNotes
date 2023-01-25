class Note {
  final String title;
  final String content;
  final DateTime date;
  final String uniqueIdentifier;

  Note({
    required this.title,
    required this.content,
    required this.date,
    required this.uniqueIdentifier,
  });

  Note copyWith({String? title, String? content, DateTime? date}) {
    return Note(
      title: title ?? this.title,
      content: content ?? this.content,
      date: date ?? DateTime.now(),
      uniqueIdentifier: uniqueIdentifier,
    );
  }
}
