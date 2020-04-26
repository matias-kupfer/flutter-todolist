import 'package:flutter/material.dart';

class New extends StatelessWidget {
  final String uid;
  String newTask;
  final _formKey = GlobalKey<FormState>();
  final addTask;

  New(this.uid, this.newTask, this.addTask);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.teal,
        validator: (val) => val.isEmpty ? 'Enter a task' : null,
        onChanged: (val) {
          newTask = val;
        },
        decoration: InputDecoration(
            focusColor: Colors.black12,
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.teal)),
            hintText: 'Walk the fish...',
            labelText: 'Set a new task',
            labelStyle: TextStyle(color: Colors.teal),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.teal,
              ),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  addTask(uid, newTask);
                }
              },
            )),
      ),
    );
  }
}
