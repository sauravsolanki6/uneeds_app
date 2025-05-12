import 'dart:io';

import 'package:UNGolds/constant/button_design.dart';
import 'package:UNGolds/constant/drawer_design.dart';
import 'package:UNGolds/constant/extension.dart';
import 'package:UNGolds/constant/progressdialog.dart';
import 'package:UNGolds/network/response/submit_bank_response.dart';
import 'package:UNGolds/screens/login_page/forgotpassword_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:image_cropper/image_cropper.dart';
import '../../constant/app_color.dart';
import '../../constant/camerabuttonpage.dart';
import '../../constant/printmessage.dart';
import '../../constant/show_confirmation_dialog.dart';
import '../../constant/snackbardesign.dart';
import '../../constant/textdesign.dart';
import '../../constant/utility.dart';
import '../../network/createjson.dart';
import '../../network/networkcall.dart';
import '../../network/networkutility.dart';
import '../../network/response/account_type_response.dart';
import '../../network/response/get_state_response.dart';
import '../bottom_navigation_bar.dart';

TextEditingController banknamecontroller = TextEditingController();
TextEditingController accountnumbercontroller = TextEditingController();
TextEditingController ifsccontroller = TextEditingController();
TextEditingController upiidcontroller = TextEditingController();
TextEditingController branchnamecontroller = TextEditingController();
TextEditingController micrnumbercontroller = TextEditingController();
TextEditingController upiscannernamecontroller = TextEditingController();
bool validatebankname = true,
    validateaccountnumber = true,
    validateaccounttype = true,
    validateifsccode = true,
    validatemicrnumber = true;
String filename = "No file selected", errorforifsc = "";

class AddBankDetailPage extends StatefulWidget {
  State createState() => AddBankDetailPageState();
}

class AddBankDetailPageState extends State<AddBankDetailPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  Networkcallforaccounttype();
  }

  List<AccountType> accounttypelist = <AccountType>[
    AccountType(0, "Saving Account"),
    AccountType(1, "Salary Account"),
    AccountType(2, "Current Account"),
    AccountType(3, "Fixed Deposite Account"),
    AccountType(4, "Recurring Deposite Account"),
    AccountType(5, "NRI Account")
  ];

  String account_type_id = "";

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    AppUtility.bankimageName = "";
    AppUtility.bankimagePath = "";
    banknamecontroller.clear();
    accountnumbercontroller.clear();
    ifsccontroller.clear();
    upiidcontroller.clear();
    branchnamecontroller.clear();
    micrnumbercontroller.clear();
    upiscannernamecontroller.clear();
    filename = "";
    validatebankname = true;
    validateaccountnumber = true;
    validateaccounttype = true;
    validateifsccode = true;
    validatemicrnumber = true;
    validateupiscannerphoto = true;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      // endDrawer: CommonDrawer(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(CupertinoIcons.left_chevron)),
        elevation: 0,
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  'Add Bank Details'.introTitleText(context),
                ],
              ).marginOnly(top: 10),
            ),
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 25,
            ).marginOnly(right: 10, top: 10)
          ],
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          return true;
        },
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/bg.png'), // Replace 'assets/background_image.jpg' with your image path
                  fit: BoxFit.cover, //
                ),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 20),
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        firstWidegt(),
                        secondWidegt(),
                        thirdWidegt(),
                        fifthWidegt(),
                        sixWidegt(),
                        seventhWidegt(),
                        fourthWidegt(),
                        eighthWidegt(),
                        space(),
                        ninthWidget(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ).marginOnly(left: 20, right: 20),
            ),
          ),
        ),
      ),
    );
  }

  Widget space() {
    return SizedBox(
      height: 5,
    );
  }

  Widget firstWidegt() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Bank Name',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            ),
            SizedBox(
              width: 2,
            ),
            Text(
              '*',
              style: TextStyle(
                  color: AppColor.bordercolor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14),
            )
          ],
        ).marginOnly(top: 20),
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: TextField(
            controller: banknamecontroller,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp("[a-z||A-Z||' ']"))
            ],
            keyboardType: TextInputType.text,
            style: TextStyle(color: Colors.black),
            onChanged: (value) {
              validatebankname = true;
              setState(() {});
            },
            cursorColor: Color(0xff7E7E7E),
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none),
                contentPadding: EdgeInsets.all(8),
                hintText: 'Enter your bank name',
                counterText: "",
                errorText:
                    validatebankname ? null : 'Please enter your bank name',
                errorStyle: TextDesign.errortext,
                hintStyle: TextDesign.hinttext),
          ),
        ).marginOnly(top: 10),
      ],
    );
  }

  Widget secondWidegt() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Account Number',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            ),
            SizedBox(
              width: 2,
            ),
            Text(
              '*',
              style: TextStyle(
                  color: AppColor.bordercolor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14),
            )
          ],
        ).marginOnly(top: 20),
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: TextField(
            controller: accountnumbercontroller,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp("[1-9][0-9]{0,20}"))
            ],
            keyboardType: TextInputType.number,
            style: TextStyle(color: Colors.black),
            cursorColor: Color(0xff7E7E7E),
            //maxLength: 16,
            onChanged: (value) {
              validateaccountnumber = true;
              setState(() {});
            },
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none),
                contentPadding: EdgeInsets.all(8),
                hintText: 'Enter your account number',
                counterText: "",
                errorText: validateaccountnumber
                    ? null
                    : 'Please enter your account number',
                errorStyle: TextDesign.errortext,
                hintStyle: TextDesign.hinttext),
          ),
        ).marginOnly(top: 10),
      ],
    );
  }

  Widget thirdWidegt() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'IFSC Code',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            ),
            SizedBox(
              width: 2,
            ),
            Text(
              '*',
              style: TextStyle(
                  color: AppColor.bordercolor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14),
            )
          ],
        ).marginOnly(top: 20),
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: TextField(
            controller: ifsccontroller,
            maxLength: 11,
            textCapitalization: TextCapitalization.characters,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp("[A-Z||0-9]"))
            ],
            onChanged: (value) {
              validateifsccode = true;
              setState(() {});
            },
            style: TextStyle(color: Colors.black),
            cursorColor: Color(0xff7E7E7E),
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none),
                contentPadding: EdgeInsets.all(8),
                counterText: "",
                hintText: 'Enter your IFSC Code',
                errorText: validateifsccode ? null : errorforifsc,
                errorStyle: TextDesign.errortext,
                hintStyle: TextDesign.hinttext),
          ),
        ).marginOnly(top: 10),
      ],
    );
  }

  Widget fourthWidegt() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'UPI Id',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            ),
          ],
        ).marginOnly(top: 10),
        Container(
          decoration: BoxDecoration(
              color: context.theme.colorScheme.background,
              borderRadius: BorderRadius.circular(10)),
          // margin: EdgeInsets.only(left: 5),
          child: Container(
            margin: EdgeInsets.only(left: 5),
            child: TextField(
              controller: upiidcontroller,
              style: TextStyle(color: Colors.black),
              cursorColor: Color(0xff7E7E7E),
              decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.all(8),
                  hintText: 'Enter UPI Id',
                  hintStyle: TextDesign.hinttext),
            ),
          ),
        ).marginOnly(top: 10),
      ],
    );
  }

  Widget fifthWidegt() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Branch Name',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            ),
          ],
        ).marginOnly(top: 20),
        Container(
          decoration: BoxDecoration(
              color: context.theme.colorScheme.background,
              // boxShadow: [
              //       BoxShadow(
              //         color: Colors.black.withOpacity(0.2),
              //         spreadRadius: 0,
              //         blurRadius: 2,
              //         offset: Offset(0, 0),
              //       ),
              //     ],
              borderRadius: BorderRadius.circular(10)),
          // margin: EdgeInsets.only(left: 5),
          child: Container(
            margin: EdgeInsets.only(left: 5),
            child: TextField(
              controller: branchnamecontroller,
              style: TextStyle(color: Colors.black),
              cursorColor: Color(0xff7E7E7E),
              decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.all(8),
                  hintText: 'Enter your branch name',
                  // errorText:
                  //     validatebankname ? null : 'Please enter your branch name',
                  // errorStyle: TextDesign.errortext,
                  hintStyle: TextDesign.hinttext),
            ),
          ),
        ).marginOnly(top: 10),
      ],
    );
  }

  Widget sixWidegt() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Account Type',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            ),
            SizedBox(
              width: 2,
            ),
            Text(
              '*',
              style: TextStyle(
                  color: AppColor.bordercolor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14),
            )
          ],
        ).marginOnly(top: 20),
        Container(
          height: 48,
          decoration: BoxDecoration(
              color: context.theme.colorScheme.background,
              // boxShadow: [
              //         BoxShadow(
              //           color: Colors.black.withOpacity(0.2),
              //           spreadRadius: 0,
              //           blurRadius: 2,
              //           offset: Offset(0, 0),
              //         ),
              //       ],
              borderRadius: BorderRadius.circular(8),
              shape: BoxShape.rectangle),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
              value: account_type_id,
              isDense: true,
              isExpanded: true,
              menuMaxHeight: 350,
              items: [
                const DropdownMenuItem(
                    child: Text(
                      "Select Account Type",
                      style: TextStyle(
                          color: Color.fromARGB(255, 117, 117, 117),
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    value: ""),
                ...accounttypelist.map<DropdownMenuItem<String>>((e) {
                  return DropdownMenuItem(
                      child: Text(
                        e.accountname.toString(),
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      value: e.id.toString());
                }).toList()
              ],
              onChanged: (newValue) {
                setState(
                  () {
                    account_type_id = newValue!;
                    validateaccounttype = true;
                  },
                );
              },
            )),
          ),
        ).marginOnly(top: 10),
        validateaccounttype
            ? Container()
            : Text(
                'Please select account type',
                style: TextDesign.errortext,
              )
      ],
    );
  }

  Widget seventhWidegt() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'MICR Number',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            ),
          ],
        ).marginOnly(top: 20),
        TextField(
          controller: micrnumbercontroller,
          onChanged: (value) {
            validatemicrnumber = true;
            if (value != "") {
              if (value.length == 9) {
                validatemicrnumber = true;
              } else {
                validatemicrnumber = false;
              }
            } else {}
            setState(() {});
          },
          keyboardType: TextInputType.number,
          inputFormatters: [
            // FilteringTextInputFormatter.allow(RegExp(r'^(?!0{9})[0-9]{0,9}$'))
            // FilteringTextInputFormatter.allow(RegExp(r'^(?!0{9})\d{0,9}$')),

            MICRCodeInputFormatter(),
            LengthLimitingTextInputFormatter(9),
          ],
          maxLength: 9,
          style: TextStyle(color: Colors.black),
          cursorColor: Color(0xff7E7E7E),
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none),
              contentPadding: EdgeInsets.all(8),
              hintText: 'Enter your MICR number',
              counterText: "",
              errorText:
                  validatemicrnumber ? null : 'MICR number must be 9 digit',
              errorStyle: TextDesign.errortext,
              hintStyle: TextDesign.hinttext),
        ).marginOnly(top: 10),
      ],
    );
  }

  Widget eighthWidegt() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'UPI Scanner Photo',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            ),
          ],
        ).marginOnly(top: 20),
        Container(
          decoration: BoxDecoration(
              color: context.theme.colorScheme.background,
              borderRadius: BorderRadius.circular(10)),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              margin: EdgeInsets.only(left: 5),
              width: MediaQuery.of(context).size.width * 0.5,
              child: Text(
                filename,
                overflow: TextOverflow.ellipsis,
                style: TextDesign.hinttext,
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
              //height: 50,
              // width: 100,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1, color: AppColor.theamecolor),
                  borderRadius: BorderRadius.circular(5)),
              child: InkWell(
                onTap: () {
                  _showAttachmentOptions(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Select',
                        style: TextStyle(
                            color: AppColor.theamecolor,
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
            )
          ]),
        ).marginOnly(top: 10),
      ],
    );
  }

  String upiscnnerphoto = "";
  bool validateupiscannerphoto = false;
  void _pickImageFromCamera() async {
    Future<String?> pickedImage = CameraButtonPageState(true).captureImage();
    if (await pickedImage != null) {
      upiscnnerphoto = (await pickedImage)!;
      AppUtility.bankimagePath = (await pickedImage)!;

      final ext = AppUtility.bankimagePath.split('.').last;
      String filename1 =
          DateTime.now().microsecondsSinceEpoch.toString() + '.' + ext;
      ProgressDialog.showProgressDialog(context, "Loading...");
      uploadfile(File(AppUtility.bankimagePath), filename1, context);
      validateupiscannerphoto = true;
      AppUtility.bankimageName = filename1;
      filename = filename1;
      setState(() {});
    }
  }

  void _pickImageFromGallery() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['jpg', 'png']);

    if (await result != null) {
      File? img = File(result!.files.first.path!);
      img = await _cropImage(img);
      String pickedImage = img!.path!;
      upiscnnerphoto = (await pickedImage)!;
      AppUtility.bankimagePath = (await pickedImage)!;

      final ext = AppUtility.bankimagePath.split('.').last;
      String filename1 =
          DateTime.now().microsecondsSinceEpoch.toString() + '.' + ext;
      ProgressDialog.showProgressDialog(context, "Loading...");
      uploadfile(File(AppUtility.bankimagePath), filename1, context);
      validateupiscannerphoto = true;
      AppUtility.bankimageName = filename1;
      filename = filename1;
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
                  _pickImageFromCamera();
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
                  _pickImageFromGallery();
                },
              ),
            ],
          ),
        );
      },
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
          NetworkUtility.base_api + '/api-insert-bank-images',
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

  Widget ninthWidget() {
    return ButtonDesign(
        onPressed: () {
          validatebankname = true;
          validateaccountnumber = true;
          validateifsccode = true;
          validateaccounttype = true;
          errorforifsc = "";
          if (banknamecontroller.text.isEmpty &&
              accountnumbercontroller.text.isEmpty &&
              ifsccontroller.text.isEmpty &&
              account_type_id == "") {
            errorforifsc = "Please enter your IFSC code";
            validatebankname = false;
            validateaccountnumber = false;
            validateifsccode = false;
            validateaccounttype = false;
            setState(() {});
          } else if (accountnumbercontroller.text.isEmpty &&
              ifsccontroller.text.isEmpty &&
              account_type_id == "") {
            errorforifsc = "Please enter your IFSC code";
            validateaccountnumber = false;
            validateifsccode = false;
            validateaccounttype = false;
            setState(() {});
          } else if (ifsccontroller.text.isEmpty && account_type_id == "") {
            errorforifsc = "Please enter your IFSC code";
            validateifsccode = false;
            validateaccounttype = false;
            setState(() {});
          } else if (banknamecontroller.text.isEmpty) {
            validatebankname = false;
            setState(() {});
          } else if (accountnumbercontroller.text.isEmpty) {
            validateaccountnumber = false;
            setState(() {});
          } else if (ifsccontroller.text.isEmpty) {
            errorforifsc = "Please enter your IFSC code";
            validateifsccode = false;
            setState(() {});
          } else if (validateifsc(ifsccontroller.text) == false) {
            errorforifsc = "Please enter valid IFSC code";
            validateifsccode = false;
            setState(() {});
          } else if (account_type_id == "") {
            validateaccounttype = false;
            setState(() {});
          } else {
            setState(() {});
            Showconfirmatondialog();
          }
        },
        child: 'Submit'.buttoText());
  }

  bool validateifsc(String ifsc) {
    String pattern = r'^[A-Z]{4}0[A-Z0-9]{6}$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(ifsc)) {
      return false;
    } else {
      return true;
    }
  }

  Showconfirmatondialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialogDesign(
            description: "Are you sure? You want to submit bank details? ",
            nobuttonPressed: () {
              Navigator.pop(context);
            },
            yesbuttonPressed: () {
              Navigator.pop(context);
              NetworkCallForSubmitBankDetails();
            },
            title: "Confirmation",
          );
        });
  }

  Future<void> NetworkCallForSubmitBankDetails() async {
    print(AppUtility.bankimageName);
    try {
      ProgressDialog.showProgressDialog(context, "Loading...");
      String createjson = CreateJson().createjsonforsubmitbankdetails(
        context,
        AppUtility.ID,
        banknamecontroller.text,
        accountnumbercontroller.text,
        account_type_id,
        branchnamecontroller.text,
        ifsccontroller.text,
        micrnumbercontroller.text,
        AppUtility.bankimageName,
        "",
        upiidcontroller.text,
      );
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.insert_bank_detail,
          NetworkUtility.insert_bank_detail_api,
          createjson,
          context);
      if (list != null) {
        Navigator.pop(context);
        List<Submitbankdetailsresponse> response = List.from(list!);
        String status = response[0].status!;
        switch (status) {
          case "true":
            SnackBarDesign('Bank details submited successfully!', context,
                AppColor.sucesscolor, Colors.white);
            Navigator.pop(context);

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
}

class MICRCodeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Ensure the new value is at most 9 digits and not all zeros
    final String newText = newValue.text;

    // Check if the input is more than 9 digits or all zeros
    if (newText.length > 9 || RegExp(r'^0{9}$').hasMatch(newText)) {
      return oldValue; // Keep the old value if the new one is invalid
    }

    return newValue;
  }
}
