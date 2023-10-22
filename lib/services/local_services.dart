import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/screens/model/todo_model.dart';

import '../models/resources.dart';
import '../models/status.dart';

class LocalServices {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'todoDBBB.db');
    print("Database path: ${await getDatabasesPath()}");
    return openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE TODOS (id TEXT NOT NULL, title TEXT NOT NULL, description TEXT NOT NULL, datetime TEXT NOT NULL, daytime TEXT NOT NULL, doneTasks TEXT NOT NULL);',
        );
      },
    );
  }

  Future<void> insertTodo(TodoModel todo) async {
    final db = await database;

    await db.insert(
      'TODOS',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateTodo(TodoModel todo) async {
    if (todo.id == null) {
      throw Exception('Cannot update todo without an ID');
    }

    final db = await database;

    await db.update(
      'TODOS',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future<Resource<int>> deleteTodo(TodoModel todo) async {
    try {
      final db = await database;
      var delete = await db.delete(
        'TODOS',
        where: 'id=?',
        whereArgs: [todo.id],
      );
      return Resource(Status.SUCCESS, data: delete);
    } catch (error) {
      return Resource(Status.ERROR, errorMessage: error.toString());
    }
  }

  Future<List<TodoModel>> getAllTodos(String dayTime) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'TODOS',
      where: 'daytime=?',
      whereArgs: [dayTime],
    );
    return List.generate(maps.length, (i) => TodoModel.fromMap(maps[i]));
  }

  Future<List<TodoModel>> getAllDoneTodos(String dayTime) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'TODOS',
      where: 'daytime = ? AND doneTasks = ?',
      whereArgs: [dayTime, 'done'],
    );
    return List.generate(maps.length, (i) => TodoModel.fromMap(maps[i]));
  }
}
