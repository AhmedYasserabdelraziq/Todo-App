import 'package:sqflite/sqflite.dart';
import 'package:todo_app/screens/model/todo_model.dart';

import '../models/resources.dart';
import '../models/status.dart';

class LocalServices {
  Future<Resource<Database>> createDataBase() async {
    try {
      var openData = await openDatabase('Todo.db', version: 1,
          onCreate: (db, version) async {
        print('Create DataBase');
        await db.execute(
          'CREATE TABLE Todo (id INTEGER PRIMARY KEY, name TEXT NOT NULL, description TEXT NOT NULL, num REAL);',
        );
        version = 1;
      });
      return Resource(Status.SUCCESS, data: openData);
    } catch (error) {
      return Resource(Status.ERROR, errorMessage: error.toString());
    }
  }

  Future<Resource<dynamic>> addTodo(TodoModel todo) async {
    try {
      var db = await createDataBase();
      var createData = db.data!.insert('Todo', todo.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      return Resource(Status.SUCCESS, data: createData);
    } catch (error) {
      return Resource(Status.ERROR, errorMessage: error.toString());
    }
  }

  Future<Resource<dynamic>> updateTodo(TodoModel todo) async {
    try {
      var db = await createDataBase();
      var updateData = await db.data!.update(
        'Todo',
        todo.toJson(),
        where: 'id=?',
        whereArgs: [todo.id],
      );
      return Resource(Status.SUCCESS, data: updateData);
    } catch (error) {
      return Resource(Status.ERROR, errorMessage: error.toString());
    }
  }

  Future<Resource<int>> deleteTodo(TodoModel todo) async {
    try {
      var db = await createDataBase();
      var delete = await db.data!.delete(
        'Todo',
        where: 'id=?',
        whereArgs: [todo.id],
      );
      return Resource(Status.SUCCESS, data: delete);
    } catch (error) {
      return Resource(Status.ERROR, errorMessage: error.toString());
    }
  }
}
