import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import 'model/note.dart';

class NoteDataBase {
  static const tbNotes = "notes";
  static final NoteDataBase _noteDbHandle = NoteDataBase._createInstance();
  Database? _db;
  factory NoteDataBase() {
    return _noteDbHandle;
  }

  NoteDataBase._createInstance();
  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    } else {
      _db = await initDb();
      return _db!;
    }
  }

  _onCreate(Database db, int version) async {
    String sql =
        'CREATE TABLE $tbNotes (${Note.kID} INTEGER PRIMARY KEY AUTOINCREMENT, ${Note.kTitle} VARCHAR, ${Note.kContent} TEXT, ${Note.kDate} VARCHAR)';
    await db.execute(sql);
  }

  Future<Database> initDb() async {
    final dbPath = await getDatabasesPath();
    final localDatabase = path.join(dbPath, 'Note');
    return await openDatabase(localDatabase, version: 1, onCreate: _onCreate);
  }

  Future<int> addNote(Note note) async {
    var dataBase = await db;
    int result = await dataBase.insert(tbNotes, note.toMap());
    return result;
  }

  Future<List<Note>> getNotes() async {
    var dataBase = await db;
    String sql = 'SELECT * FROM $tbNotes ORDER BY ${Note.kTitle} DESC';
    List<Map<String, dynamic>> notesMap = await dataBase.rawQuery(sql);
    List<Note> notes = notesMap.map((map) => Note.fromMap(map)).toList();
    return notes;
  }

  Future<Note> getNote(int nId) async {
    var dataBase = await db;
    String sql = 'SELECT * FROM $tbNotes WHERE ${Note.kID} = ?';
    Map<String, dynamic> noteItem = (await dataBase.rawQuery(sql, [nId]))[0];
    Note note = Note.fromMap(noteItem);

    return note;
  }

  Future<int> removeNote(int id) async {
    var dataBase = await db;
    return await dataBase.delete(
      tbNotes,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateNote(Note note) async {
    var database = await db;
    return await database.rawUpdate(
      'UPDATE $tbNotes SET ${Note.kTitle} = ?, ${Note.kContent} = ?, ${Note.kDate} = ? WHERE ${Note.kID} = ?',
      [note.title, note.content, DateTime.now().toString(), note.id],
    );
  }
}
