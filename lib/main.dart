import 'package:flutter/material.dart';
import 'package:todolist/models/userdata.dart';
import 'package:todolist/pages/wrapper.dart';
import 'package:todolist/services/auth.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamProvider<String>.value(
        value: AuthService().getUid,
        child: MaterialApp(home: Wrapper()),
      ),
    );
  }
}
