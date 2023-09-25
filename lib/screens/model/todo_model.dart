class TodoModel {
  final int? id;
  final String title;
  final String description;

  TodoModel({
    this.id,
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  static TodoModel fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'] as int?,
      title: map['title'] as String,
      description: map['description'] as String,
    );
  }
}