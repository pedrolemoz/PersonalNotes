import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../storage/cache_keys.dart';

class NoteModel {
  final String title;
  final String content;
  late final DateTime date;
  late final String _uuid;
  final _uuidGenerator = const Uuid();

  NoteModel({required this.title, required this.content, DateTime? date, String? uuid}) {
    this.date = date ?? DateTime.now();
    _uuid = uuid ?? _uuidGenerator.v4();
  }

  Map<String, dynamic> toMap() => {
        'title': title,
        'content': content,
        'date': date.millisecondsSinceEpoch,
        'uuid': _uuid,
      };

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      title: map['title'],
      content: map['content'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      uuid: map['uuid'],
    );
  }

  Future<void> storeNoteInLocalStorage() async {
    final box = await Hive.openBox(CacheKeys.appCache);
    final currentNotes = await getAllNotesFromLocalStorage();
    currentNotes.add(this);
    final encodedNotes = currentNotes.map((note) => note.toMap()).toList();
    await box.put(CacheKeys.userNotes, json.encode(encodedNotes));
  }

  static Future<List<NoteModel>> getAllNotesFromLocalStorage() async {
    final box = await Hive.openBox(CacheKeys.appCache);
    final rawNotes = await box.get(CacheKeys.userNotes);
    final decodedNotes = rawNotes == null ? [] : json.decode(rawNotes);
    return List<NoteModel>.from(decodedNotes.map((note) => NoteModel.fromMap(note)));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NoteModel &&
        other.title == title &&
        other.content == content &&
        other.date == date &&
        other._uuid == _uuid;
  }

  @override
  int get hashCode => title.hashCode ^ content.hashCode ^ date.hashCode ^ _uuid.hashCode;
}
