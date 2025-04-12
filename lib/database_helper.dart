import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlapp/note_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('notes.db');
    return _database!;
  }

  /// Singleton Pattern
  DatabaseHelper._();

  /// named Constructor
  DatabaseHelper._init();

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE notes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        txt TEXT NOT NULL,
        description TEXT NOT NULL
      )
    ''');
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // Close database
  Future close() async {
    final db = await database;
    db.close();
  }

  /// Crud
  // Create
  Future<NoteModel> create(NoteModel note) async {
    final db = await database;
    final id = await db.insert('notes', note.toMap());
    print(note.id);
    print('Id $id');
    return note.copyWith(id: id);
  }

  // Read
  Future<NoteModel?> readNote(int id) async {
    final db = await database;
    final maps = await db.query(
      'notes',
      columns: ['id', 'txt'],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return NoteModel.fromMap(maps.first);
    }
    return null;
  }

  // Read All
  Future<List<NoteModel>> readAllNotes() async {
    print('salam');
    final db = await database;
    final result = await db.query('notes');
    print(result.toString());
    return result.map((map) => NoteModel.fromMap(map)).toList();
  }

  // Update
  Future<int> update(NoteModel note) async {
    final db = await database;
    return db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  // Delete
  Future<int> delete(int id) async {
    final db = await database;
    return await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
