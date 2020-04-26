import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:todolist/models/task.dart';
import 'package:todolist/models/userdata.dart';

class FirestoreService {
  FirestoreService(this.uid);

  final String uid;

  final CollectionReference tasksCollection =
      Firestore.instance.collection('tasks');

  Future<void> updateUser(UserData userData) {
    return tasksCollection.document(uid).setData(userData.toMap());
  }

  Future addTask(task) async {
    return await tasksCollection.document(uid).updateData({
      'tasks': FieldValue.arrayUnion([task])
    });
  }

  List<Task> _genTasksList(tasks) {
    List<Task> tasksList = new List();
    tasks.forEach(
        (task) => tasksList.add(Task(task['task'], task['completed'])));
    return tasksList;
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(snapshot.data['name'], snapshot.data['imageUrl'],
        _genTasksList(snapshot.data['tasks']));
  }

  Stream<UserData> get userData {
    return tasksCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
