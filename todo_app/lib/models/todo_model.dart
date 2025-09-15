class TodoModel {
  final String id;
  final String title;
  final bool completed;
  final String userId;
  final DateTime createdAt;
  final DateTime updatedAt;

  TodoModel({
    required this.id,
    required this.title,
    required this.completed,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json["_id"],
      title: json["title"],
      completed: json["completed"] ?? false,
      userId: json["userId"],
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "title": title,
      "completed": completed,
      "userId": userId,
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
    };
  }

  TodoModel copyWith({
    String? id,
    String? title,
    bool? completed,
    String? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
