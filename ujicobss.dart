import 'package:belajardb/database.dart';

void main() {
  var note1 = Note(title: 'hello', content: 'world');
  insertNote(note1);

  var semuaNote = getNotes();
  for (var note in semuaNote) {
    note.displayInfo();
  }
}