enum TaskStatus { pending, completed }

class Task {
  int? id;
  String title;
  String description;
  DateTime dueDate;
  TaskStatus status;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    this.status = TaskStatus.pending,
  });

  factory Task.fromMap(Map<String, dynamic> json) => Task(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    dueDate: DateTime.parse(json['dueDate']),
    status: json['status'] == 'Completed' ? TaskStatus.completed : TaskStatus.pending,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'description': description,
    'dueDate': dueDate.toIso8601String(),
    'status': status == TaskStatus.completed ? 'Completed' : 'Pending',
  };
}
