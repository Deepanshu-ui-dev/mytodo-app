enum Priority { low, medium, high }

class Todo {
  final String title;
  final DateTime date;
  final Priority priority;
  bool isCompleted;

  Todo({
    required this.title,
    required this.date,
    required this.priority,
    this.isCompleted = false,
  });
}
