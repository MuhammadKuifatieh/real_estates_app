import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import '../widgets/my_app_bar.dart';

class AddPostScreen extends StatefulWidget {
  static const routeName = '/add_post_screen';
  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  FilePickerResult filePickerResult;
  Future<FilePickerResult> getImage() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowCompression: true,
    );

    if (result != null)
      return result;
    else
      print('No image selected.');
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        context: context,
        title: 'Add New Post',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                setState(() async {
                  filePickerResult = await getImage();
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  image: (filePickerResult != null)
                      ? DecorationImage(
                          image: Image.file(
                                  File(filePickerResult.files.single.path))
                              .image,
                          fit: BoxFit.cover)
                      : null,
                  shape: BoxShape.circle,
                  border: Border.all(
                      width: 1, color: Theme.of(context).primaryColor),
                ),
                child: (filePickerResult == null)
                    ? Center(
                        child: Icon(Icons.add,
                            color: Theme.of(context).primaryColor))
                    : Container(),
              ),
            ),
            textFiled(label: "Location home"),
            textFiled(label: "build date"),
            SizedBox(
              height: 20,
            ),
            // ignore: deprecated_member_use
            FlatButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Text(
                  "Add Post",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  textFiled({String label}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }
}
