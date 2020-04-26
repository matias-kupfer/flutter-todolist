import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todolist/models/userdata.dart';
import 'package:todolist/services/firestore.dart';
import 'package:todolist/shared/loader.dart';
import 'package:provider/provider.dart';

import 'Uploader.dart';

class UploadImageView extends StatefulWidget {
  @override
  _UploadImageViewState createState() => _UploadImageViewState();
}

class _UploadImageViewState extends State<UploadImageView> {
  File _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);
    setState(() {
      _imageFile = selected;
    });
  }

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: _imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      androidUiSettings: AndroidUiSettings(
        toolbarColor: Colors.black,
        statusBarColor: Colors.black,
        toolbarWidgetColor: Colors.white,
        backgroundColor: Colors.black,
        activeControlsWidgetColor: Colors.teal,
      ),
    );

    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  void _clear() {
    setState(() => _imageFile = null);
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
              body: _imageFile != null
                  ? ListView(
                      children: <Widget>[
                        Image.file(_imageFile),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            FlatButton(
                              child: Icon(
                                Icons.crop,
                                color: Colors.white,
                              ),
                              onPressed: _cropImage,
                            ),
                            FlatButton(
                              child: Icon(
                                Icons.refresh,
                                color: Colors.white,
                              ),
                              onPressed: _clear,
                            ),
                          ],
                        ),
                        Uploader(file: _imageFile, userData: userData),
                      ],
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            userData.tasks.length.toString(),
                            style:
                                TextStyle(color: Colors.white, fontSize: 100),
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
                    ),
              bottomNavigationBar: BottomAppBar(
                color: Colors.white10,
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.photo_camera),
                      color: Colors.white,
                      onPressed: () => _pickImage(ImageSource.camera),
                    ),
                    IconButton(
                      icon: Icon(Icons.photo_library),
                      color: Colors.teal,
                      onPressed: () => _pickImage(ImageSource.gallery),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Loader();
          }
        });
  }
}
