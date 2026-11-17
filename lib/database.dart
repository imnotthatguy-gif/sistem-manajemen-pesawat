import 'package:sqlite3/sqlite3.dart';

class DatabaseHelper {
  static Database? _database;
  Database get database {
    if (_database !=  null) {return _database!; }
    _database = _inidatabase();
    return _database!;
  }
  Database _inidatabase() {
    var db = sqlite3.open('mynotedb.db');
    db.execute('''
    CREATE TABLE IF NOT EXIST notes (
    id INTEGER PRIMARY KEY AUTOINCRIMENT, 
    title TEXT. 
    content TEXT)
    '''); 
    return db;
  }
} 

class Note {
  int? id;
  String title;
  String content;

  Note ({
    this.id,
    required this.title,
    required this.content,
  });

  void displayInfo() {
    print('==== Note ====');
    print('ID: ${this.id}');
    print('Title: ${this.title}');
    print('Content: ${this.content}');
  }
}

void insertNote(Note note) {
  var db = DatabaseHelper().database;
  var stmt = db.prepare(
    '''
    INSERT INTO notes (title, content)
    values (?, ?)''',
  );
  stmt.execute ([note.title, note.content]);
  stmt.dispose();
}

List<Note> getNotes () {
  var db = DatabaseHelper().database;
  var result = db.select('SELECT * FROM notes');
  List<Note> notes = [];
  for (var row in result) {
    notes.add(Note(
      id: row['id'] as int?,
      title: row['title'] as String,
      content: row['content'] as String,
     ));
  }
  return notes;
}