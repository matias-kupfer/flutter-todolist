import 'package:flutter/material.dart';
import 'package:todolist/models/userdata.dart';
import 'task_card.dart';

class Tasks extends StatelessWidget {
  final String uid;
  final UserData userData;
  final bool status; // completed
  final updateTasks;

  Tasks(this.uid, this.userData, this.updateTasks, this.status);

//  Tasks(this.tasks, this.changeTaskStatus, this.status);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: userData.tasks.length,
      itemBuilder: (context, index) {
        return userData.tasks[index].completed == status
            ? TaskCard(uid, userData, index, updateTasks, status)
            : Container();
      },
    );
  }
}
/*return Column(
      children: tasks.map((task) {
        return Container(
          width: double.infinity,
          child: Task(task, changeTaskStatus),
        );
      }).toList(),
    );*/

/*
return CustomScrollView(
      slivers: <Widget>[
        SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) =>
                    TaskCard(tasks['tasks'][index], changeTaskStatus, status),
                childCount: tasks.length))
      ],
    );
    */
