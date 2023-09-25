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
    final path = join(dbPath, 'todo.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE Todo (id INTEGER PRIMARY KEY, title TEXT NOT NULL, description TEXT NOT NULL);',
        );
      },
    );
  }

  Future<void> insertTodo(TodoModel todo) async {
    final db = await database;

    await db.insert(
      'Todo',
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
      'Todo',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future<Resource<int>> deleteTodo(TodoModel todo) async {
    try {
      final db = await database;
      var delete = await db.delete(
        'Todo',
        where: 'id=?',
        whereArgs: [todo.id],
      );
      return Resource(Status.SUCCESS, data: delete);
    } catch (error) {
      return Resource(Status.ERROR, errorMessage: error.toString());
    }
  }

  Future<List<TodoModel>> getAllTodos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Todo');

    return List.generate(maps.length, (i) => TodoModel.fromMap(maps[i]));
  }
}
