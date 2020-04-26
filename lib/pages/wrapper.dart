import 'package:flutter/material.dart';
import 'package:todolist/models/userdata.dart';
import 'package:todolist/pages/auth/access.dart';
import 'package:todolist/pages/profile/profile_view.dart';
import 'package:todolist/pages/tasks/tasks_view.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uid = Provider.of<String>(context);
    if (uid == null) {
      return AccessView();
    } else {
      return MaterialApp(
        initialRoute: '/tasks',
        routes: {
          '/tasks': (context) => TasksView(),
          '/profile': (context) => ProfileView(),
        },
      );
    }
  }
}
