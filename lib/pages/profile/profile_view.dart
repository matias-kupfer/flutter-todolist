import 'package:flutter/material.dart';
import 'package:todolist/models/userdata.dart';
import 'package:todolist/pages/profile/upload_image_view.dart';
import 'package:todolist/services/auth.dart';
import 'package:todolist/shared/loader.dart';
import 'package:provider/provider.dart';
import '../../services/firestore.dart';

class ProfileView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileView();
  }
}

class _ProfileView extends State<ProfileView> {
  AuthService _auth = AuthService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final uid = Provider.of<String>(context);
    return StreamBuilder(
        stream: FirestoreService(uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Scaffold(
                backgroundColor: Colors.black,
                appBar: AppBar(
                  backgroundColor: Colors.white10,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        userData.name,
                        style: TextStyle(color: Colors.white),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.exit_to_app,
                          color: Colors.teal,
                        ),
                        onPressed: () async {
                          _auth.signOut();
                        },
                      ),
                    ],
                  ),
                ),
                body: UploadImageView());
          } else {
            return Loader();
          }
        });
  }
}
/*
Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
crossAxisAlignment: CrossAxisAlignment.center,
children: <Widget>[
Text(
userData.tasks.length.toString(),
style: TextStyle(color: Colors.white, fontSize: 100),
),
Text(
'Tasks',
style: TextStyle(
color: Colors.white,
fontSize: 40,
fontWeight: FontWeight.w100),
)
],
),
)*/
