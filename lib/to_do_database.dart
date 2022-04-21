import 'to_do_page.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ToDoDatabase {
  static final ToDoDatabase instance = ToDoDatabase._init();

  static Database? _database;

  ToDoDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('to_do.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableToDo ( 
  ${NoteFields.id} $idType, 
  ${NoteFields.isImportant} $boolType,
  ${NoteFields.number} $integerType,
  ${NoteFields.title} $textType,
  ${NoteFields.description} $textType,
  ${NoteFields.time} $textType
  )
''');
  }

  Future<ToDo> create(ToDo todo_item) async {
    final db = await instance.database;

    final id = await db.insert(tableToDo, todo_item.toJson());
    return todo_item.copy(id: id);
  }

  Future<ToDo> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableToDo,
      columns: NoteFields.values,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return ToDo.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<ToDo>> readAllNotes() async {
    final db = await instance.database;

    final orderBy = '${NoteFields.time} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableToDo ORDER BY $orderBy');

    final result = await db.query(tableToDo, orderBy: orderBy);

    return result.map((json) => ToDo.fromJson(json)).toList();
  }

  Future<int> update(ToDo note) async {
    final db = await instance.database;

    return db.update(
      tableToDo,
      note.toJson(),
      where: '${NoteFields.id} = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableToDo,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    _database = null;
    db.close();
  }
}
