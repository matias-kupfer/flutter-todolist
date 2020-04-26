import 'package:flutter/material.dart';
import 'package:todolist/services/auth.dart';
import 'package:todolist/shared/constants.dart';
import 'package:todolist/shared/loader.dart';

class AccessView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AccessView();
  }
}

class _AccessView extends State<AccessView> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String name = '';
  String email = '';
  String password = '';
  String error = '';

  void changeLoadingStatus() {
    setState(() => loading = !loading);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Access'),
          ],
        ),
      ),
      body: loading
          ? Loader()
          : Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                      // EMAIL
                      cursorColor: Colors.teal,
                      style: TextStyle(color: Colors.white),
                      decoration:
                          textInputDecoration.copyWith(hintText: 'name'),
                      validator: (val) =>
                          val.isEmpty ? 'Enter your name' : null,
                      onChanged: (val) {
                        setState(() => name = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      // EMAIL
                      cursorColor: Colors.teal,
                      style: TextStyle(color: Colors.white),
                      decoration:
                          textInputDecoration.copyWith(hintText: 'email'),
                      validator: (val) => val.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      // PASSWORD
                      cursorColor: Colors.teal,
                      style: TextStyle(color: Colors.white),
                      decoration:
                          textInputDecoration.copyWith(hintText: 'password'),
                      validator: (val) =>
                          val.length < 6 ? 'Enter 6 + letters password' : null,
                      obscureText: true,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        RaisedButton(
                          color: Colors.teal,
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            // LOGIN
                            if (_formKey.currentState.validate()) {
                              changeLoadingStatus();
                              dynamic result = await _auth
                                  .loginWithEmailAndPassword(email, password);
                              if (result == null) {
                                changeLoadingStatus();
                                setState(
                                    () => error = 'there has been a problem');
                              }
                            }
                          },
                        ),
                        RaisedButton(
                          color: Colors.teal,
                          child: Text(
                            'Sign up',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            // SIGN UP
                            if (_formKey.currentState.validate()) {
                              changeLoadingStatus();
                              dynamic result =
                                  await _auth.registerWithEmailAndPassword(
                                      name, email, password);
                              if (result == null) {
                                changeLoadingStatus();
                                setState(
                                    () => error = 'there has been a problem');
                              }
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
