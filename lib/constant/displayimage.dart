import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

class DisplayImagePage extends StatelessWidget {
  final String imagePath;

  const DisplayImagePage({Key? key, required this.imagePath}) : super(key: key);

  Future<File?> _cropImage(File imagefile) async {
    CroppedFile? cropimage = await ImageCropper().cropImage(
        sourcePath: imagefile.path,
        uiSettings: [
          AndroidUiSettings(
            // toolbarTitle: 'Crop Image',
            // toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,

            hideBottomControls: false, // Hide bottom controls during crop
          )
        ],
        aspectRatio: CropAspectRatio(ratioX: 5, ratioY: 3));
    if (cropimage == null) return null;
    return File(cropimage.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent.withOpacity(0.1),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.file(
              File(imagePath),
              fit: BoxFit.contain,
            )),
      ),
      floatingActionButton: Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.send),
          )),
    );
  }
}
