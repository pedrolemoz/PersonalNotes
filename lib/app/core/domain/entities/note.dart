class Note {
  final String title;
  final String content;
  late final DateTime date;
  final String uniqueIdentifier;

  Note({
    required this.title,
    required this.content,
    DateTime? date,
    required this.uniqueIdentifier,
  }) {
    date = date ?? DateTime.now();
  }

  Note copyWith({String? title, String? content, DateTime? date}) {
    return Note(
      title: title ?? this.title,
      content: content ?? this.content,
      date: date,
      uniqueIdentifier: uniqueIdentifier,
    );
  }
}
