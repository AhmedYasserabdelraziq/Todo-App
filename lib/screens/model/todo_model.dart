import 'package:uuid/uuid.dart';

const uuid = Uuid();

class TodoModel {
  String id;
  final String title;
  final String description;

  TodoModel({
    String? id,
    required this.title,
    required this.description,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  static TodoModel fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
    );
  }
}
