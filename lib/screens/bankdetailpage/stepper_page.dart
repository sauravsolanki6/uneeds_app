import 'dart:io';

import 'package:UNGolds/constant/button_design.dart';
import 'package:UNGolds/constant/camerapage1.dart';
import 'package:UNGolds/constant/extension.dart';
import 'package:UNGolds/constant/progressdialog.dart';
import 'package:UNGolds/constant/snackbardesign.dart';
import 'package:UNGolds/network/createjson.dart';
import 'package:UNGolds/network/networkcall.dart';
import 'package:UNGolds/network/networkutility.dart';
import 'package:UNGolds/network/response/submit_kyc_response.dart';
import 'package:UNGolds/screens/bankdetailpage/kyc_detail_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../../constant/app_color.dart';
import '../../constant/camerabuttonpage.dart';
import '../../constant/printmessage.dart';
import '../../constant/show_confirmation_dialog.dart';
import '../../constant/textdesign.dart';
import '../../constant/utility.dart';

class KYCStepper extends StatefulWidget {
  String kycstatus, getback;

  KYCStepper(this.kycstatus, this.getback);

  @override
  State<KYCStepper> createState() => _KYCStepperState();
}

bool validateaggrement = true;

class _KYCStepperState extends State<KYCStepper> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    AppUtility.aadharfrontimagePath = "";
    AppUtility.aadharfrontimageName = "";
    AppUtility.aadharbackimagePath = "";
    AppUtility.aadharbackimageName = "";
    AppUtility.panimagePath = "";
    AppUtility.panimageName = "";
    AppUtility.passportimagePath = "";
    AppUtility.passportimageName = "";
    validateaadharfrontphoto = true;
    validateaadharbackphoto = true;
    validatepancard = true;
    validatepassportphoto = true;
  }

  int _index = 0;
  bool isCheck = false;
  bool isUploadDocument = true, isKYCForm = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          // primarySwatch: AppColor.greencolor,
          colorScheme:
              ColorScheme.fromSwatch().copyWith(primary: AppColor.greencolor)),
      child: Stepper(
          elevation: 0.0,
          type: StepperType.vertical,
          currentStep: _index,
          controlsBuilder: (context, details) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                _index <= 0
                    ? Container()
                    : Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.only(
                            left: 30, top: 10, bottom: 10, right: 30),
                        decoration: BoxDecoration(
                            color: AppColor.greycolor,
                            borderRadius: BorderRadius.circular(5)),
                        child: InkWell(
                          onTap: details.onStepCancel,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Previous',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                const SizedBox(
                  width: 5,
                ),
                _index <= 0
                    ? GestureDetector(
                        onTap: () {
                          if (_index <= 0) {
                            validateaadharfrontphoto = true;
                            validateaadharbackphoto = true;
                            validatepancard = true;
                            validatepassportphoto = true;
                            if (AppUtility.aadharfrontimageName.isEmpty &&
                                AppUtility.aadharbackimageName.isEmpty &&
                                AppUtility.panimageName.isEmpty &&
                                AppUtility.passportimageName.isEmpty) {
                              validateaadharfrontphoto = false;
                              validateaadharbackphoto = false;
                              validatepancard = false;
                              validatepassportphoto = false;
                              setState(() {});
                            } else if (AppUtility
                                .aadharfrontimageName.isEmpty) {
                              validateaadharfrontphoto = false;
                              setState(() {});
                            } else if (AppUtility.aadharbackimageName.isEmpty) {
                              validateaadharbackphoto = false;
                              setState(() {});
                            } else if (AppUtility.panimageName.isEmpty) {
                              validatepancard = false;
                              setState(() {});
                            } else if (AppUtility.passportimageName.isEmpty) {
                              validatepassportphoto = false;
                              setState(() {});
                            } else {
                              isKYCForm = true;
                              isUploadDocument = false;
                              setState(() {
                                _index += 1;
                              });
                            }
                          } else {
                            isUploadDocument = true;
                            isKYCForm = false;

                            if (isCheck == false) {
                              validateaggrement = false;
                              setState(() {});
                            } else {
                              validateaggrement = true;
                              setState(() {});
                              Showconfirmatondialog();
                            }
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              color: AppColor.theamecolor,
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 30, right: 30, top: 10, bottom: 10),
                            child: 'Next'.buttoText(),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          if (isCheck == false) {
                            validateaggrement = false;
                            setState(() {});
                          } else {
                            isUploadDocument = true;
                            isKYCForm = false;
                            validateaggrement = true;
                            setState(() {});
                            Showconfirmatondialog();
                          }
                        },
                        child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                color: AppColor.theamecolor,
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 30, top: 10, bottom: 10, right: 30),
                              child: 'Submit'.buttoText(),
                            )),
                      )
              ],
            );
          },
          onStepCancel: () {
            isUploadDocument = true;
            isKYCForm = false;
            if (_index > 0) {
              setState(() {
                _index -= 1;
              });
            } else {
              Navigator.pop(context);
            }
          },
          onStepContinue: () {
            if (_index <= 0) {
              validateaadharfrontphoto = true;
              validateaadharbackphoto = true;
              validatepancard = true;
              validatepassportphoto = true;
              if (AppUtility.aadharfrontimageName.isEmpty &&
                  AppUtility.aadharbackimageName.isEmpty &&
                  AppUtility.panimageName.isEmpty &&
                  AppUtility.passportimageName.isEmpty) {
                validateaadharfrontphoto = false;
                validateaadharbackphoto = false;
                validatepancard = false;
                validatepassportphoto = false;
                setState(() {});
              } else if (AppUtility.aadharfrontimageName.isEmpty) {
                validateaadharfrontphoto = false;
                setState(() {});
              } else if (AppUtility.aadharbackimageName.isEmpty) {
                validateaadharbackphoto = false;
                setState(() {});
              } else if (AppUtility.panimageName.isEmpty) {
                validatepancard = false;
                setState(() {});
              } else if (AppUtility.passportimageName.isEmpty) {
                validatepassportphoto = false;
                setState(() {});
              } else {
                isKYCForm = true;
                isUploadDocument = false;
                setState(() {
                  _index += 1;
                });
              }
            } else {
              isUploadDocument = true;
              isKYCForm = false;

              if (isCheck == false) {
                validateaggrement = false;
                setState(() {});
              } else {
                validateaggrement = true;
                setState(() {});
                Showconfirmatondialog();
              }
            }
          },
          steps: widget.kycstatus == "0"
              ? <Step>[
                  Step(
                    title: Text(
                      'Upload Document',
                      style: TextStyle(
                          color: isUploadDocument
                              ? AppColor.greencolor
                              : AppColor.greycolor,
                          fontSize: 16),
                    ),
                    isActive: isUploadDocument,
                    label: Text(
                      'Upload Document',
                      style: TextStyle(
                          color: isUploadDocument
                              ? AppColor.greencolor
                              : AppColor.greycolor,
                          fontSize: 12),
                    ),
                    content: Container(
                        alignment: Alignment.centerLeft,
                        child: stepUploadDocument()),
                  ),
                  Step(
                      title: Text(
                        'KYC Form',
                        style: TextStyle(
                            color: isKYCForm
                                ? AppColor.greencolor
                                : AppColor.greycolor,
                            fontSize: 16),
                      ),
                      isActive: isKYCForm,
                      label: Text(
                        'KYC Form',
                        style: TextStyle(
                            color: isKYCForm
                                ? AppColor.greencolor
                                : AppColor.greycolor,
                            fontSize: 12),
                      ),
                      content: stepKYCForm()),
                ]
              : <Step>[
                  Step(
                    title: Text(
                      'Upload Document',
                      style: TextStyle(
                          color: isUploadDocument
                              ? AppColor.greencolor
                              : AppColor.greycolor,
                          fontSize: 16),
                    ),
                    isActive: isUploadDocument,
                    label: Text(
                      'Upload Document',
                      style: TextStyle(
                          color: isUploadDocument
                              ? AppColor.greencolor
                              : AppColor.greycolor,
                          fontSize: 12),
                    ),
                    content: Container(
                        alignment: Alignment.centerLeft,
                        child: stepUploadDocument()),
                  ),
                  Step(
                      title: Text(
                        'KYC Form',
                        style: TextStyle(
                            color: isKYCForm
                                ? AppColor.greencolor
                                : AppColor.greycolor,
                            fontSize: 16),
                      ),
                      isActive: isKYCForm,
                      label: Text(
                        'KYC Form',
                        style: TextStyle(
                            color: isKYCForm
                                ? AppColor.greencolor
                                : AppColor.greycolor,
                            fontSize: 12),
                      ),
                      content: stepKYCForm()),
                ]),
    );
  }

  Showconfirmatondialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialogDesign(
            description: "Are you sure? You want to submit KYC Form ",
            nobuttonPressed: () {
              Navigator.pop(context);
            },
            yesbuttonPressed: () {
              Navigator.pop(context);
              NetworkCallForSubmitKYCForm();
            },
            title: "Confirmation",
          );
        });
  }

  Future<void> NetworkCallForSubmitKYCForm() async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading...");
      String createjson = CreateJson().createjsonforsubmitkycform(
          context,
          AppUtility.ID,
          AppUtility.aadharfrontimageName,
          AppUtility.aadharbackimageName,
          AppUtility.panimageName,
          AppUtility.passportimageName,
          isCheck ? "1" : "0");
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.submit_kyc,
          NetworkUtility.submit_kyc_api,
          createjson,
          context);
      if (list != null) {
        Navigator.pop(context);
        List<Submitkycresponse> response = List.from(list!);
        String status = response[0].status!;
        switch (status) {
          case "true":
            SnackBarDesign('KYC done successfully!', context,
                AppColor.sucesscolor, Colors.white);
            if (widget.getback == "1") {
              Navigator.pop(context);
            } else {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return KYCDetailPage("0");
                },
              ));
            }
            break;
          case "false":
            SnackBarDesign(response[0].message!, context, AppColor.errorcolor,
                Colors.white);
            break;
        }
      } else {
        Navigator.pop(context);
      }
    } catch (e) {
      PrintMessage.printmessage(e.toString(), 'NetworkCallForSubmitKYCForm',
          'Stepper For KYC', context);
    }
  }

  void _showAttachmentOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera),
                title: Text(
                  'Take a Photo',
                  style: TextStyle(color: AppColor.bordercolor),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromCameraForFrontSheet();
                },
              ),
              ListTile(
                leading: Icon(Icons.insert_drive_file),
                title: Text(
                  'Pick from File',
                  style: TextStyle(color: AppColor.bordercolor),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromGalleryForFrontSheet();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _pickImageFromCameraForFrontSheet() async {
    Future<String?> pickedImage = CameraButtonPageState(true).captureImage();
    if (await pickedImage != null) {
      aadharfrontphoto = (await pickedImage)!;
      AppUtility.aadharfrontimagePath = (await pickedImage)!;

      final ext = AppUtility.aadharfrontimagePath.split('.').last;
      String filename =
          DateTime.now().microsecondsSinceEpoch.toString() + '.' + ext;
      ProgressDialog.showProgressDialog(context, "Loading...");
      uploadfile(File(AppUtility.aadharfrontimagePath), filename, context);
      validateaadharfrontphoto = true;
      AppUtility.aadharfrontimageName = filename;
      setState(() {});
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

  void _pickImageFromGalleryForFrontSheet() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (await result != null) {
      File? img = File(result!.files.first.path!);
      img = await _cropImage(img);
      String pickedImage = img!.path!;
      aadharfrontphoto = (pickedImage)!;
      AppUtility.aadharfrontimagePath = pickedImage!;

      final ext = AppUtility.aadharfrontimagePath.split('.').last;
      String filename =
          DateTime.now().microsecondsSinceEpoch.toString() + '.' + ext;
      ProgressDialog.showProgressDialog(context, "Loading...");
      uploadfile(File(AppUtility.aadharfrontimagePath), filename, context);
      validateaadharfrontphoto = true;
      AppUtility.aadharfrontimageName = filename;

      setState(() {});
    }
  }

  void _showAttachmentOptionsForBackSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera),
                title: Text(
                  'Take a Photo',
                  style: TextStyle(color: AppColor.bordercolor),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromCameraForBackSheet();
                },
              ),
              ListTile(
                leading: Icon(Icons.insert_drive_file),
                title: Text(
                  'Pick from File',
                  style: TextStyle(color: AppColor.bordercolor),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromGallaryForBackSheet();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _pickImageFromCameraForBackSheet() async {
    Future<String?> pickedImage = CameraButtonPageState(true).captureImage();
    if (await pickedImage != null) {
      aadharbackphoto = (await pickedImage)!;
      AppUtility.aadharbackimagePath = (await pickedImage)!;

      final ext = AppUtility.aadharbackimagePath.split('.').last;
      String filename =
          DateTime.now().microsecondsSinceEpoch.toString() + '.' + ext;
      ProgressDialog.showProgressDialog(context, "Loading...");
      uploadfile(File(AppUtility.aadharbackimagePath), filename, context);
      validateaadharbackphoto = true;
      AppUtility.aadharbackimageName = filename;
      setState(() {});
    }
  }

  void _pickImageFromGallaryForBackSheet() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (await result != null) {
      File? img = File(result!.files.first.path!);
      img = await _cropImage(img);
      String pickedImage = img!.path!;
      aadharbackphoto = (await pickedImage)!;
      AppUtility.aadharbackimagePath = (await pickedImage)!;

      final ext = AppUtility.aadharbackimagePath.split('.').last;
      String filename =
          DateTime.now().microsecondsSinceEpoch.toString() + '.' + ext;
      ProgressDialog.showProgressDialog(context, "Loading...");
      uploadfile(File(AppUtility.aadharbackimagePath), filename, context);
      validateaadharbackphoto = true;
      AppUtility.aadharbackimageName = filename;
      setState(() {});
    }
  }

  void _showAttachmentOptionsForPancard(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera),
                title: Text(
                  'Take a Photo',
                  style: TextStyle(color: AppColor.bordercolor),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromCameraForpancard();
                },
              ),
              ListTile(
                leading: Icon(Icons.insert_drive_file),
                title: Text(
                  'Pick from File',
                  style: TextStyle(color: AppColor.bordercolor),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromGalleryForpancard();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _pickImageFromCameraForpancard() async {
    Future<String?> pickedImage = CameraButtonPageState(true).captureImage();
    if (await pickedImage != null) {
      pancardphoto = (await pickedImage)!;

      AppUtility.panimagePath = (await pickedImage)!;

      final ext = AppUtility.panimagePath.split('.').last;
      String filename =
          DateTime.now().microsecondsSinceEpoch.toString() + '.' + ext;
      ProgressDialog.showProgressDialog(context, "Loading...");
      uploadfile(File(AppUtility.panimagePath), filename, context);
      validatepancard = true;
      AppUtility.panimageName = filename;
      setState(() {});
    }
  }

  void _pickImageFromGalleryForpancard() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (await result != null) {
      File? img = File(result!.files.first.path!);
      img = await _cropImage(img);
      String pickedImage = img!.path!;
      pancardphoto = (await pickedImage)!;

      AppUtility.panimagePath = (await pickedImage)!;

      final ext = AppUtility.panimagePath.split('.').last;
      String filename =
          DateTime.now().microsecondsSinceEpoch.toString() + '.' + ext;
      ProgressDialog.showProgressDialog(context, "Loading...");
      uploadfile(File(AppUtility.panimagePath), filename, context);
      validatepancard = true;
      AppUtility.panimageName = filename;
      setState(() {});
    }
  }

  void _showAttachmentOptionsForPassport(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera),
                title: Text(
                  'Take a Photo',
                  style: TextStyle(color: AppColor.bordercolor),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromCameraForpassport();
                },
              ),
              ListTile(
                leading: Icon(Icons.insert_drive_file),
                title: Text(
                  'Pick from File',
                  style: TextStyle(color: AppColor.bordercolor),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromGalleryForpassport();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _pickImageFromCameraForpassport() async {
    Future<String?> pickedImage = CameraButtonPageState(true).captureImage();
    if (await pickedImage != null) {
      passportphoto = (await pickedImage)!;
      AppUtility.passportimagePath = (await pickedImage)!;

      final ext = AppUtility.passportimagePath.split('.').last;
      String filename =
          DateTime.now().microsecondsSinceEpoch.toString() + '.' + ext;
      ProgressDialog.showProgressDialog(context, "Loading...");
      uploadfile(File(AppUtility.passportimagePath), filename, context);
      validatepassportphoto = true;
      AppUtility.passportimageName = filename;
      setState(() {});
    }
  }

  void _pickImageFromGalleryForpassport() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (await result != null) {
      File? img = File(result!.files.first.path!);
      img = await _cropImage(img);
      String pickedImage = img!.path!;
      passportphoto = (await pickedImage)!;
      AppUtility.passportimagePath = (await pickedImage)!;

      final ext = AppUtility.passportimagePath.split('.').last;
      String filename =
          DateTime.now().microsecondsSinceEpoch.toString() + '.' + ext;
      ProgressDialog.showProgressDialog(context, "Loading...");
      uploadfile(File(AppUtility.passportimagePath), filename, context);
      validatepassportphoto = true;
      AppUtility.passportimageName = filename;
      setState(() {});
    }
  }

  bool validateaadharfrontphoto = true,
      validateaadharbackphoto = true,
      validatepancard = true,
      validatepassportphoto = true;
  String aadharfrontphoto = "",
      aadharbackphoto = "",
      pancardphoto = "",
      passportphoto = "";
  Widget _FirstCardWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Aadhaar Front',
          style: TextStyle(
              color: AppColor.lablecolor,
              fontWeight: FontWeight.w600,
              fontSize: 15),
        ),
        const SizedBox(
          height: 5,
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 0,
                  blurRadius: 1,
                  offset: Offset(1, 1),
                ),
              ],
              color: Colors.white,
            ),
            child: DottedBorder(
              color: AppColor.bordercolor,
              radius: Radius.circular(10),
              strokeWidth: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  aadharfrontphoto != ""
                      ? Container()
                      : IconButton(
                          onPressed: () {
                            _showAttachmentOptions(context);
                          },
                          icon: Icon(
                            CupertinoIcons.camera,
                            color: AppColor.bordercolor,
                          ),
                        ),
                  aadharfrontphoto != ""
                      ? Container()
                      : Text(
                          'Select file for upload',
                          style: TextStyle(color: AppColor.bordercolor),
                          textAlign: TextAlign.center,
                        ),
                  aadharfrontphoto != ""
                      ? _aadharfrontimageCardWidget(aadharfrontphoto)
                      : Container(),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        validateaadharfrontphoto
            ? Container()
            : const Text(
                'Please upload aadhaar front photo',
                style: TextDesign.errortext,
              )
      ],
    );
  }

  Widget _aadharfrontimageCardWidget(String imag) {
    return Stack(
      children: [
        Container(
          // width: 50,
          height: 110,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(image: FileImage(File(imag)))),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            onPressed: () {
              _showAttachmentOptions(context);
            },
            icon: Icon(
              CupertinoIcons.camera,
              color: AppColor.bordercolor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _SecondCardWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Aadhaar Back',
          style: TextStyle(
              color: AppColor.lablecolor,
              fontWeight: FontWeight.w600,
              fontSize: 15),
        ),
        const SizedBox(
          height: 3,
        ),
        DecoratedBox(
          decoration: const BoxDecoration(color: Colors.transparent),
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 0,
                  blurRadius: 1,
                  offset: Offset(1, 1),
                ),
              ],
              color: Colors.white,
            ),
            child: DottedBorder(
              color: AppColor.bordercolor,
              strokeWidth: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  aadharbackphoto != ""
                      ? Container()
                      : IconButton(
                          onPressed: () {
                            _showAttachmentOptionsForBackSheet(context);
                          },
                          icon: Icon(
                            CupertinoIcons.camera,
                            color: AppColor.bordercolor,
                          ),
                        ),
                  aadharbackphoto != ""
                      ? Container()
                      : Text(
                          'Select file for upload',
                          style: TextStyle(color: AppColor.bordercolor),
                          textAlign: TextAlign.center,
                        ),
                  aadharbackphoto != ""
                      ? _aadharbackimageCardWidget(aadharbackphoto)
                      : Container(),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        validateaadharbackphoto
            ? Container()
            : const Text(
                'Please upload aadhaar back photo',
                style: TextDesign.errortext,
              )
      ],
    );
  }

  Widget _aadharbackimageCardWidget(String imag) {
    return Stack(
      children: [
        Container(
          height: 110,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                  image: FileImage(File(imag)), fit: BoxFit.contain)),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            onPressed: () {
              _showAttachmentOptionsForBackSheet(context);
            },
            icon: Icon(
              CupertinoIcons.camera,
              color: AppColor.bordercolor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _ThirdCardWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pan Card',
          style: TextStyle(
              color: AppColor.lablecolor,
              fontWeight: FontWeight.w600,
              fontSize: 15),
        ),
        const SizedBox(
          height: 3,
        ),
        DecoratedBox(
          decoration: const BoxDecoration(color: Colors.transparent),
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 0,
                  blurRadius: 1,
                  offset: Offset(1, 1),
                ),
              ],
              color: Colors.white,
            ),
            child: DottedBorder(
              color: AppColor.bordercolor,
              strokeWidth: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  pancardphoto != ""
                      ? Container()
                      : IconButton(
                          onPressed: () {
                            _showAttachmentOptionsForPancard(context);
                          },
                          icon: Icon(
                            CupertinoIcons.camera,
                            color: AppColor.bordercolor,
                          ),
                        ),
                  pancardphoto != ""
                      ? Container()
                      : Text(
                          'Select file for upload',
                          style: TextStyle(color: AppColor.bordercolor),
                          textAlign: TextAlign.center,
                        ),
                  pancardphoto != ""
                      ? _pancardimageCardWidget(pancardphoto)
                      : Container(),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        validatepancard
            ? Container()
            : const Text(
                'Please upload pancard photo',
                style: TextDesign.errortext,
              )
      ],
    );
  }

  Widget _pancardimageCardWidget(String imag) {
    return Stack(
      children: [
        Container(
          height: 110,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                  image: FileImage(File(imag)), fit: BoxFit.contain)),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            onPressed: () {
              _showAttachmentOptionsForPancard(context);
            },
            icon: Icon(
              CupertinoIcons.camera,
              color: AppColor.bordercolor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _FourthCardWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Passport Size Photo',
          style: TextStyle(
              color: AppColor.lablecolor,
              fontWeight: FontWeight.w600,
              fontSize: 15),
        ),
        const SizedBox(
          height: 3,
        ),
        DecoratedBox(
          decoration: const BoxDecoration(
              // gradient: LinearGradient(colors: List.filled(length, fill)),
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(3))),
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 0,
                  blurRadius: 1,
                  offset: Offset(1, 1),
                ),
              ],
              color: Colors.white,
            ),
            child: DottedBorder(
              color: AppColor.bordercolor,
              strokeWidth: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  passportphoto != ""
                      ? Container()
                      : IconButton(
                          onPressed: () {
                            _showAttachmentOptionsForPassport(context);
                          },
                          icon: Icon(
                            CupertinoIcons.camera,
                            color: AppColor.bordercolor,
                          ),
                        ),
                  passportphoto != ""
                      ? Container()
                      : Text(
                          'Select file for upload',
                          style: TextStyle(color: AppColor.bordercolor),
                          textAlign: TextAlign.center,
                        ),
                  passportphoto != ""
                      ? _passportimageCardWidget(passportphoto)
                      : Container(),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        validatepassportphoto
            ? Container()
            : const Text(
                'Please upload passport photo',
                style: TextDesign.errortext,
              )
      ],
    );
  }

  Widget _passportimageCardWidget(String imag) {
    return Stack(
      children: [
        Container(
          height: 110,
          decoration: BoxDecoration(
              // shape: BoxShape.rectangle,
              border: Border.all(width: 0, color: Colors.white),
              image: DecorationImage(
                  image: FileImage(File(imag)), fit: BoxFit.contain)),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            onPressed: () {
              _showAttachmentOptionsForPassport(context);
            },
            icon: Icon(
              CupertinoIcons.camera,
              color: AppColor.bordercolor,
            ),
          ),
        ),
      ],
    );
  }

  Widget stepUploadDocument() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 0,
                  blurRadius: 1,
                  offset: Offset(1, 1),
                ),
              ],
              color: widget.kycstatus == "0"
                  ? Color.fromARGB(255, 255, 255, 255)
                  : Colors.red.withOpacity(0.7)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.kycstatus == "0"
                  ? 'Your KYC verification is pending. To enable gold purchases, please complete the verification process.'
                  : "We regret to inform you that your KYC verification has been rejected due to issues with the provided document.",
              style: TextStyle(
                  color: widget.kycstatus == "0"
                      ? AppColor.bordercolor
                      : Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        _FirstCardWidget(),
        SizedBox(
          height: 3,
        ),
        _SecondCardWidget(),
        SizedBox(
          height: 3,
        ),
        _ThirdCardWidget(),
        SizedBox(
          height: 3,
        ),
        _FourthCardWidget(),
        SizedBox(
          height: 3,
        ),
      ],
    );
  }

  Widget stepKYCForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.kycstatus == "1"
            ? Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 0,
                        blurRadius: 1,
                        offset: Offset(1, 1),
                      ),
                    ],
                    color: Colors.green.withOpacity(0.7)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "KYC Verified! You can now make secure gold purchases with confidence.",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              )
            : Container(),
        widget.kycstatus == "2"
            ? Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 0,
                        blurRadius: 1,
                        offset: Offset(1, 1),
                      ),
                    ],
                    color: Colors.white),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "We regret to inform you that your KYC verification has been rejected due to issues with the provided document.",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              )
            : Container(),
        widget.kycstatus == "3"
            ? Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 0,
                        blurRadius: 1,
                        offset: Offset(1, 1),
                      ),
                    ],
                    color: Color(0xffd4edda)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Your document has been successfully submitted. While we verify it, feel free to proceed with your gold purchase. ",
                    style: TextStyle(
                        color: AppColor.bordercolor,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              )
            : Container(),
        SizedBox(
          height: 5,
        ),
        const Text(
          'KYC Process for Gold Purchase on EMI',
          style: TextStyle(
              color: Color(0xff000000),
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 3,
        ),
        Text(
          "At Uneeds Gold (OPC) Pvt Ltd. we understand the importance of a seamless and efficient buying experience. To facilitate this, we've streamlined our KYC (Know Your Customer) process for gold purchases on EMI, ensuring a secure and convenient transaction for our valued customers.",
          style: TextStyle(
              color: AppColor.bordercolor,
              fontSize: 15,
              fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 3,
        ),
        const Text(
          'Process Overview',
          style: TextStyle(
              color: Color(0xff000000),
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 3,
        ),
        RichText(
            text: TextSpan(
                text: 'Submit Documents to Purchase: ',
                style: TextStyle(
                    color: AppColor.bordercolor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
                children: [
              TextSpan(
                  text:
                      'Customers can initiate their gold purchase by submitting necessary KYC documents during the buying process. No need to wait for KYC approval at this stage.',
                  style: TextStyle(
                      color: AppColor.bordercolor,
                      fontSize: 15,
                      fontWeight: FontWeight.normal))
            ])),
        const SizedBox(
          height: 4,
        ),
        RichText(
            text: TextSpan(
                text: 'Instant Purchase: ',
                style: TextStyle(
                    color: AppColor.bordercolor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
                children: [
              TextSpan(
                  text:
                      'Once documents are submitted, customers can proceed with their gold purchase immediately. We value your time and aim to provide a swift and hassle-free experience.',
                  style: TextStyle(
                      color: AppColor.bordercolor,
                      fontSize: 15,
                      fontWeight: FontWeight.normal))
            ])),
        const SizedBox(
          height: 4,
        ),
        RichText(
            text: TextSpan(
                text: 'KYC Approval and Gold Delivery: ',
                style: TextStyle(
                    color: AppColor.bordercolor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
                children: [
              TextSpan(
                  text:
                      'Post-purchase, our team will diligently review the submitted KYC documents. If approved, the purchased gold will be delivered after completing all EMI payments. We prioritize the security of your information and adhere to a true and accurate representation of customer details.',
                  style: TextStyle(
                      color: AppColor.bordercolor,
                      fontSize: 15,
                      fontWeight: FontWeight.normal))
            ])),
        const SizedBox(
          height: 4,
        ),
        RichText(
            text: TextSpan(
                text: 'Rejection and Re-submission: ',
                style: TextStyle(
                    color: AppColor.bordercolor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
                children: [
              TextSpan(
                  text:
                      'In the event of KYC rejection, customers will be notified promptly. They can then re-upload the required documents for reconsideration. We appreciate your cooperation in ensuring the accuracy of provided information.',
                  style: TextStyle(
                      color: AppColor.bordercolor,
                      fontSize: 15,
                      fontWeight: FontWeight.normal))
            ])),
        const SizedBox(
          height: 3,
        ),
        const Text(
          'Data Security:',
          style: TextStyle(
              color: Color(0xff000000),
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 3,
        ),
        Text(
            'Rest assured, Uneeds Gold (OPC) Pvt Ltd. places the utmost importance on data security. Your KYC details are securely stored in our database, following industry-standard protocols. This ensures a safe and reliable EMI process throughout the tenure of your purchase.',
            style: TextStyle(
                color: AppColor.bordercolor,
                fontSize: 15,
                fontWeight: FontWeight.w400)),
        const SizedBox(
          height: 3,
        ),
        Text(
            'We appreciate your trust in Uneeds Gold (OPC) Pvt Ltd. If you have any queries or require assistance during the process, our dedicated customer support team is ready to help.',
            style: TextStyle(
                color: AppColor.bordercolor,
                fontSize: 15,
                fontWeight: FontWeight.w400)),
        const SizedBox(
          height: 3,
        ),
        Text('Thank you for choosing us for your gold purchase on EMI.',
            style: TextStyle(
                color: AppColor.bordercolor,
                fontSize: 15,
                fontWeight: FontWeight.w400)),
        Divider(
          thickness: 2,
          color: Colors.grey.withOpacity(0.2),
        ),
        const SizedBox(
          height: 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
                value: isCheck,
                checkColor: const Color(0xff0C8A7B),
                activeColor: Colors.white,
                onChanged: (value) {
                  setState(() {
                    isCheck = value!;
                  });
                  if (isCheck == true) {
                    validateaggrement = true;
                    setState(() {});
                  }
                }).marginOnly(left: 5),
            Expanded(
              child: Container(
                  child: const Text(
                "By clicking 'Agree,' you confirm that you have read and accept our terms and conditions*",
                style: TextStyle(fontSize: 14, color: Color(0xff2488ad)),
              )).marginOnly(right: 30),
            ),
          ],
        ).marginOnly(top: 10),
        validateaggrement
            ? Container()
            : Text(
                'Please accept the user agreement!',
                style: TextDesign.errortext,
              ),
        Divider(
          thickness: 2,
          color: Colors.grey.withOpacity(0.2),
        ),
        const SizedBox(
          height: 4,
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    ).marginOnly(left: 20, right: 20);
  }

  Widget stepUploadedDocument() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(color: Color(0xff75d88d)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Your document has been successfully submitted. While we verify it, feel free to proceed with your gold purchase. ",
              style: TextStyle(
                  color: AppColor.bordercolor,
                  fontSize: 15,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        _UploadedFirstCardWidget("", ""),
        SizedBox(
          height: 3,
        ),
        _SecondCardWidget(),
        SizedBox(
          height: 3,
        ),
        _ThirdCardWidget(),
        SizedBox(
          height: 3,
        ),
        _FourthCardWidget(),
        SizedBox(
          height: 3,
        ),
      ],
    );
  }

  Widget _UploadedFirstCardWidget(String imagepath, String img) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Aadhaar Front',
          style: TextStyle(
              color: AppColor.lablecolor,
              fontWeight: FontWeight.w600,
              fontSize: 15),
        ),
        const SizedBox(
          height: 3,
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: Container(
            height: 120,
            child: DottedBorder(
              color: AppColor.bordercolor,
              strokeWidth: 1,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CachedNetworkImage(
                      imageUrl: imagepath + img,
                      errorWidget: (context, url, error) {
                        return Image.asset("assets/images/logo.png");
                      },
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: imageProvider,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  static uploadfile(File file, String filename, BuildContext context) async {
    print("File base name" + filename);
    final bytes = await File(file.path).readAsBytes();
    try {
      dio.FormData formData = dio.FormData.fromMap({
        'filename': await dio.MultipartFile.fromBytes(bytes, filename: filename)
      });
      try {
        final response1 = dio.Dio().post(
          NetworkUtility.base_api + '/api-update-kyc-image',
          data: formData,
          onSendProgress: (count, total) {
            print('count:$count,$total');
            if (count == total) {
              Navigator.pop(context);
            }
          },
        );
        print("file upload response" + response1.toString());
      } catch (e) {
        Navigator.pop(context);
        PrintMessage.printmessage(
            e.toString(), 'Upload file', 'Profile Onward', context);
      }
    } catch (e) {
      Navigator.pop(context);
      PrintMessage.printmessage(
          e.toString(), 'Upload file', 'Profile Onward', context);
    }
  }
}
