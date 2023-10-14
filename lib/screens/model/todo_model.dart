import 'package:uuid/uuid.dart';

const uuid = Uuid();

class TodoModel {
  String id;
  final String? title;
  final String? description;
  final String? dateTime;
  final String? dayTime;
  final String? tasksDone;

  TodoModel({
    String? id,
    this.title,
    this.description,
    this.dateTime,
    this.dayTime,
    this.tasksDone,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'datetime': dateTime,
      'daytime': dayTime,
      'doneTasks': tasksDone,
    };
  }

  static TodoModel fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      dateTime: map['datetime'],
      dayTime: map['daytime'],
      tasksDone: map['doneTasks'],
    );
  }
}
