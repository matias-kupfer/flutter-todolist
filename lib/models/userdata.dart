import 'package:todolist/models/task.dart';

class UserData {
  final String name;
  String imageUrl;
  final List<Task> tasks;

  UserData(this.name, this.imageUrl, this.tasks);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'tasks': tasks.map((task) => task.toMap()).toList(),
    };
  }
}
