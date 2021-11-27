import 'package:firebase_database/firebase_database.dart';
import 'package:notes/models/note.dart';

class DatabaseProvider {
  static final _notesRef = FirebaseDatabase.instance.reference().child('notes');

  DatabaseProvider._();

  static Future<List<Note>> fetchNotes() async {
    var notes = <Note>[];
    try {
      await _notesRef.once().then((snapshot) {
        Map<dynamic, dynamic> values = snapshot.value;
        values.forEach((key, map) {
          var note = Note(
            id: map['id'],
            title: map['title'],
            description: map['description'],
            createdDate: DateTime.parse(map['createdDate']),
            tags: [],
          );
          notes.add(note);
        });
      });
    } catch (e) {}
    return notes;
  }

  static Future<void> insertNote(Note note) async {
    _notesRef.child(note.id!).set(note.toMap());
  }

  static Future<void> updateNote(Note note) async {
    _notesRef.child(note.id!).update(note.toMap());
  }

  static Future<void> deleteNote(Note note) async {
    _notesRef.child(note.id!).remove();
  }
}
