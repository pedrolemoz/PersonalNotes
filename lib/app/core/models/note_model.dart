import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../storage/cache_keys.dart';

class NoteModel {
  final String title;
  final String content;
  late final DateTime date;
  late final String uniqueIdentifier;
  final _uniqueIdentifierGenerator = const Uuid();

  NoteModel({required this.title, required this.content, DateTime? date, String? uniqueIdentifier}) {
    this.date = date ?? DateTime.now();
    this.uniqueIdentifier = uniqueIdentifier ?? _uniqueIdentifierGenerator.v4();
  }

  Map<String, dynamic> toMap() => {
        'title': title,
        'content': content,
        'date': date.millisecondsSinceEpoch,
        'uniqueIdentifier': uniqueIdentifier,
      };

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      title: map['title'],
      content: map['content'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      uniqueIdentifier: map['uniqueIdentifier'],
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

  Future<void> updateCurrentNoteInLocalStorage() async {
    final box = await Hive.openBox(CacheKeys.appCache);
    final currentNotes = await getAllNotesFromLocalStorage();
    final noteIndex = currentNotes.indexWhere((note) => note.uniqueIdentifier == uniqueIdentifier);
    if (noteIndex == -1) return;
    currentNotes[noteIndex] = this;
    final encodedNotes = currentNotes.map((note) => note.toMap()).toList();
    await box.put(CacheKeys.userNotes, json.encode(encodedNotes));
  }

  Future<void> deleteCurrentNoteFromLocalStorage() async {
    final box = await Hive.openBox(CacheKeys.appCache);
    final currentNotes = await getAllNotesFromLocalStorage();
    currentNotes.removeWhere((note) => note.uniqueIdentifier == uniqueIdentifier);
    final encodedNotes = currentNotes.map((note) => note.toMap()).toList();
    await box.put(CacheKeys.userNotes, json.encode(encodedNotes));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NoteModel &&
        other.title == title &&
        other.content == content &&
        other.date == date &&
        other.uniqueIdentifier == uniqueIdentifier;
  }

  @override
  int get hashCode => title.hashCode ^ content.hashCode ^ date.hashCode ^ uniqueIdentifier.hashCode;

  NoteModel copyWith({String? title, String? content, DateTime? date}) {
    return NoteModel(
      title: title ?? this.title,
      content: content ?? this.content,
      date: date ?? this.date,
      uniqueIdentifier: uniqueIdentifier,
    );
  }
}
