import 'dart:convert';

import '../../domain/entities/note.dart';

class NoteMapper {
  static Map<String, dynamic> toMap(Note note) {
    return {
      'title': note.title,
      'content': note.content,
      'date': note.date.millisecondsSinceEpoch,
      'uniqueIdentifier': note.uniqueIdentifier,
    };
  }

  static Note fromMap(Map<String, dynamic> map) {
    return Note(
      title: map['title'],
      content: map['content'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      uniqueIdentifier: map['uniqueIdentifier'],
    );
  }

  static String toJSON(Note note) => json.encode(toMap(note));

  static Note fromJSON(String source) => fromMap(json.decode(source));
}
