class Todo {
  final String name;
  final Priority priority;
  final DateTime date;
  final String tag;
  final String description;

  Todo({
    required this.name,
    required this.priority,
    required this.date,
    required this.tag,
    required this.description,
  });

  @override
  String toString() {
    return 'Todo{name: $name, priority: $priority, date: $date, tag: $tag, description: $description}';
  }
}

enum Priority {
  low,
  normal,
  high,
}
