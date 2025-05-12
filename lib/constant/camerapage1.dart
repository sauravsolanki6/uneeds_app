import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';

import 'displayimage.dart';

class CaptureImagePage extends StatefulWidget {
  @override
  _CaptureImagePageState createState() => _CaptureImagePageState();
}

class _CaptureImagePageState extends State<CaptureImagePage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool _isFrontCamera = false;
  late List<CameraDescription> _cameras;
  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    //final firstCamera = cameras.first;
    final frontCamera = _cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front);
    _controller = CameraController(
      frontCamera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _toggleCamera() async {
    if (_isFrontCamera) {
      final backCamera = _cameras.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.back);
      await _controller.dispose();
      _controller = CameraController(
        backCamera,
        ResolutionPreset.medium,
      );
    } else {
      final frontCamera = _cameras.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.front);
      await _controller.dispose();
      _controller = CameraController(
        frontCamera,
        ResolutionPreset.medium,
      );
    }

    setState(() {
      _isFrontCamera = !_isFrontCamera;
      _initializeControllerFuture = _controller.initialize();
    });
  }

  Future<void> _captureImage() async {
    try {
      await _initializeControllerFuture;

      final imageDirectory = await getTemporaryDirectory();

      final imagePath = await _controller.takePicture();
      File? image = await _cropImage(File(imagePath.path));
      if (image != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DisplayImagePage(imagePath: image.path),
          ),
        );
      }
    } catch (e) {
      print('Error capturing image: $e');
    }
  }

  Future<File?> _cropImage(File imagefile) async {
    CroppedFile? cropimage = await ImageCropper().cropImage(
        sourcePath: imagefile.path,
        uiSettings: [
          AndroidUiSettings(
            // toolbarTitle: 'Crop Image',
            // toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.black,
            // initAspectRatio: CropAspectRatioPreset.original,
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
    if (_controller.value.isInitialized) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: _toggleCamera,
              icon: Icon(Icons.switch_camera),
            ),
          ],
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: CameraPreview(_controller)),
        floatingActionButton: Align(
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton(
            onPressed: _captureImage,
            child: Icon(Icons.camera_alt),
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
