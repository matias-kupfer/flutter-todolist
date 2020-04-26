import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todolist/models/userdata.dart';
import 'package:todolist/pages/profile/profile_view.dart';
import 'package:todolist/services/firestore.dart';
import 'package:todolist/shared/loader.dart';
import 'tasks.dart';
import 'new.dart';
import 'package:provider/provider.dart';

class TasksView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TasksView();
  }
}

class _TasksView extends State<TasksView> {
  final String newTask = '';
  int _tab = 0;
  bool showInputStatus = false;

  void updateTasks(String uid, UserData userData, int index, int action) {
    // 0 update - 1 delete
    switch (action) {
      case 0:
        userData.tasks[index].completed = !userData.tasks[index].completed;
        break;
      case 1:
        userData.tasks.removeAt(index);
        break;
    }
    FirestoreService(uid).updateUser(userData);
  }

  void addTask(uid, newTask) {
    FirestoreService(uid).addTask({'task': newTask, 'completed': false});
  }

  void _onTabSelectorTap(int index) {
    setState(() {
      _tab = index;
    });
  }

  void _toggleInput() {
    setState(() {
      showInputStatus = !showInputStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final uid = Provider.of<String>(context);
    return StreamBuilder<UserData>(
        stream: FirestoreService(uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                backgroundColor: Colors.white10,
                title: showInputStatus
                    ? New(uid, newTask, addTask)
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('To do list'),
                          userData.imageUrl != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(50),
                                    onTap: () => Navigator.pushNamed(
                                        context, '/profile'),
                                    child: Container(
                                      child: Image.network(
                                        userData.imageUrl,
                                        width: 30,
                                        height: 30,
                                      ),
                                    ),
                                  ),
                                )
                              : IconButton(
                                  icon: Icon(Icons.person),
                                  color: Colors.teal,
                                  onPressed: () =>
                                      Navigator.pushNamed(context, '/profile'),
                                ),
                        ],
                      ),
              ),
              body: _tab == 0
                  ? Tasks(uid, userData, updateTasks, false)
                  : Tasks(uid, userData, updateTasks, true),
//        _tab == 0
//            ? Tasks(_tasks, changeTaskStatus, false)
//            : Tasks(_completedTasks, changeTaskStatus, true),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.teal,
                child: showInputStatus ? Icon(Icons.close) : Icon(Icons.edit),
                onPressed: _toggleInput,
                elevation: 2.0,
              ),
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Colors.white10,
                fixedColor: Colors.white,
                unselectedItemColor: Colors.white30,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.notifications_active),
                      title: Text('Pending')),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.done_all), title: Text('Completed'))
                ],
                currentIndex: _tab,
                onTap: _onTabSelectorTap,
              ),
            );
          } else {
            return Loader();
          }
        });
  }
}
