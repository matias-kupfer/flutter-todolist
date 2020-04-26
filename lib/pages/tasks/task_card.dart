import 'package:flutter/material.dart';
import 'package:todolist/models/task.dart';
import 'package:todolist/models/userdata.dart';

class TaskCard extends StatelessWidget {
  final String uid;
  final UserData userData;
  final int index;
  final bool status;
  final updateTasks;

  TaskCard(this.uid, this.userData, this.index, this.updateTasks, this.status);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black45,
      child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: status
                      ? Text(
                          userData.tasks[index].task,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              decoration: TextDecoration.lineThrough),
                        )
                      : Text(userData.tasks[index].task,
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        updateTasks(uid, userData, index, 1);
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        !status ? Icons.check : Icons.undo,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        updateTasks(uid, userData, index, 0);
                      },
                    ),
                  ],
                )
              ],
            ),
          ])),
    );
  }
}
