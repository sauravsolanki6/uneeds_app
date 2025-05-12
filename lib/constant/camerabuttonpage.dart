import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'printmessage.dart';

bool _isUploading = false;

class CameraButtonPage extends StatefulWidget {
  CameraButtonPage();

  @override
  CameraButtonPageState createState() => CameraButtonPageState(false);
}

class CameraButtonPageState extends State<CameraButtonPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late File? _capturedImage;
  bool cropImage;
  CameraButtonPageState(this.cropImage);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
  }

  Future<String?> captureImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    try {
      if (pickedImage != null) {
        File? img = File(pickedImage.path);
        img = cropImage ? await _cropImage(img) : img;
        if (img != null) {
          return img.path;
        } else {
          return pickedImage.path;
        }
      } else {
        return pickedImage?.path;
      }
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), '_captureImage', 'Camera Button Page', context);
      return pickedImage?.path;
    }
  }

  Future<File?> _cropImage(File imagefile) async {
    CroppedFile? cropimage = await ImageCropper().cropImage(
      sourcePath: imagefile.path,
      // aspectRatio: CropAspectRatio(ratioX: 5, ratioY: 3)
    );
    if (cropimage == null) return null;
    return File(cropimage.path);
  }

  @override
  void dispose() {
    try {
      _tabController.dispose();
      super.dispose();
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), 'dispose', 'Camera Button Page', context);
    }
  }

  int _currentIndex = 0;

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.photo_camera),
          label: 'Photo',
        ),
      ],
    );
  }

  Widget getBody() {
    return _buildCameraView(captureImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
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
      body: getBody(),
      // bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildCameraView(Function() captureFunction) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(
              Icons.camera_alt,
              size: 48,
              color: Colors.grey[400],
            ),
            onPressed: captureFunction,
          ),
          SizedBox(height: 16),
          Text(
            'Tap to Capture',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[400],
            ),
          ),
          if (_isUploading)
            Align(
                alignment: Alignment.center,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: CircularProgressIndicator(
                      strokeWidth: 5,
                    ))),
        ],
      ),
    );
  }
}
