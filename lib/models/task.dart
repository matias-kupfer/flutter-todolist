class Task {
  final String task;
  bool completed;

  Task(this.task, this.completed);

  Map<String, dynamic> toMap() {
    return {
      'task': task,
      'completed': completed,
    };
  }
}
