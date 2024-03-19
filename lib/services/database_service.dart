import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo/models/todos.dart';

class DBProvider {
  static const dbName = 'todo.db';
  static const dbVersion = 1;

  static const tableName = 'todo';
  static const columnId = 'id';
  static const columnName = 'task';
  static const columnComplete = 'completed';

  DBProvider._();

  static final DBProvider db = DBProvider._();

  static Future<Database?>? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = _initDatabase();
    return _database;
  }

  Future<Database?> _initDatabase() async {
    String path = join(await getDatabasesPath(), dbName);
    return await openDatabase(path, version: dbVersion,
        onCreate: (db, version) {
      db.execute('''
          CREATE TABLE $tableName (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnComplete INTEGER NOT NULL
          )
          ''');
    });
  }

  Future<void> insertTodo(String todo) async {
    final db = await database;
    int id = int.parse(await DBProvider.db.generateTodoId());
    // print(id);
    await db?.insert(
        tableName, {columnId: id, columnName: todo, columnComplete: 0},
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Todos>> getTodo() async {
    final db = await database;
    if (db != null) {
      final List<Map<String, dynamic>> todoMaps = await db.query(tableName);
      return List.generate(todoMaps.length, (i) {
        return Todos(
          id: todoMaps[i]['id'],
          task: todoMaps[i]['task'],
          completed: todoMaps[i]['completed'] == 1,
        );
      });
    } else {
      throw Future.error("");
    }
  }

  Future<String> generateTodoId() async {
    final db = await database;
    // Here, you can use any logic you want to generate the ID,
    // for example, you can use the current timestamp
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    return timestamp.toString();
  }

  Future<void> deleteTodo(int id) async {
    final db = await database;
    print(id);
    await db?.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id]
    );
  }
}

// Future<Database> openMyDatabase() async {
//   final dbPaths = await getDatabasesPath();
//   final path = join(dbPaths, 'todo.db');
//   final database = await openDatabase(
//     path,
//     version: 1,
//     onCreate: (db, version) async {
//       // Create tables here
//     },
//   );
//   return database;
// }
