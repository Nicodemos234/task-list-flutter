class Task {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime endDate;
  final bool daily;
  final bool done;
  final String title;
  final DateTime? deletedAt;

  Task({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.endDate,
    required this.daily,
    required this.done,
    required this.title,
    this.deletedAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      endDate: DateTime.parse(json['endDate']),
      daily: json['daily'],
      done: json['done'],
      title: json['title'],
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'daily': daily,
      'done': done,
      'title': title,
      'deletedAt': deletedAt?.toIso8601String(),
    };
  }

  Task copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? endDate,
    bool? daily,
    bool? done,
    String? title,
    DateTime? deletedAt,
  }) {
    return Task(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      endDate: endDate ?? this.endDate,
      daily: daily ?? this.daily,
      done: done ?? this.done,
      title: title ?? this.title,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }
}
