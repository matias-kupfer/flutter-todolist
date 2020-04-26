import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:todolist/models/userdata.dart';
import 'package:todolist/services/firestore.dart';
import 'package:provider/provider.dart';

class Uploader extends StatefulWidget {
  File file;
  final UserData userData;

  Uploader({Key key, this.file, this.userData}) : super(key: key);

  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://todolist-2d548.appspot.com');

  StorageUploadTask _uploadTask;

  Future<void> _startUpload(String uid, UserData userData) async {
    String filePath = 'images/$uid.png';

    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
    });
    StorageTaskSnapshot storageTaskSnapshot = await _uploadTask.onComplete;
    userData.imageUrl = await storageTaskSnapshot.ref.getDownloadURL();
    FirestoreService(uid).updateUser(userData);
  }

  @override
  Widget build(BuildContext context) {
    final uid = Provider.of<String>(context);
    if (_uploadTask != null) {
      /// Manage the task state and event subscription with a StreamBuilder
      return StreamBuilder<StorageTaskEvent>(
          stream: _uploadTask.events,
          builder: (_, snapshot) {
            var event = snapshot?.data?.snapshot;

            double progressPercent = event != null
                ? event.bytesTransferred / event.totalByteCount
                : 0;

            return Column(
              children: [
                if (_uploadTask.isComplete) Text('🎉🎉🎉'),

                if (_uploadTask.isPaused)
                  FlatButton(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                    ),
                    onPressed: _uploadTask.resume,
                  ),

                if (_uploadTask.isInProgress)
                  FlatButton(
                    child: Icon(
                      Icons.pause,
                      color: Colors.white,
                    ),
                    onPressed: _uploadTask.pause,
                  ),

                // Progress bar
                LinearProgressIndicator(value: progressPercent),
                Text('${(progressPercent * 100).toStringAsFixed(2)} % '),
              ],
            );
          });
    } else {
      // Allows user to decide when to start the upload
      return FlatButton.icon(
        label: Text('Upload', style: TextStyle(color: Colors.white)),
        icon: Icon(
          Icons.cloud_upload,
          color: Colors.teal,
        ),
        onPressed: () => _startUpload(uid, widget.userData),
      );
    }
  }
}
