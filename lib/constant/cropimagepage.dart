import 'dart:io';

import 'package:UNGolds/constant/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CropImagePage extends StatefulWidget {
  File croppedImage;
  CropImagePage(this.croppedImage);
  State createState() => CropImagePageState();
}

class CropImagePageState extends State<CropImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          leading: IconButton(
            icon: Icon(
              CupertinoIcons.clear,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      extendBodyBehindAppBar: true,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20, right: 20),
        child: Align(
          alignment: Alignment.bottomRight,
          child: CircleAvatar(
              backgroundColor: AppColor.intoColor,
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 30,
                  ))),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.croppedImage != null
                ? Container(
                    width: 200,
                    height: 500,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: FileImage(widget.croppedImage!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Text('No image selected'),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
