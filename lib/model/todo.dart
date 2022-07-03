class Todo {
  final int id;
  final String name;
  final Priority priority;
  final DateTime date;
  final String tag;
  final String description;

  Todo({
    required this.id,
    required this.name,
    required this.priority,
    required this.date,
    required this.tag,
    required this.description,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Todo &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          priority == other.priority &&
          date == other.date &&
          tag == other.tag &&
          description == other.description;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      priority.hashCode ^
      date.hashCode ^
      tag.hashCode ^
      description.hashCode;

  @override
  String toString() {
    return 'Todo{id: $id, name: $name, priority: $priority, date: $date, tag: $tag, description: $description}';
  }
}

enum Priority {
  low,
  normal,
  high,
}
