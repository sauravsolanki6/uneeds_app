import 'dart:io' as iofile;
import 'dart:io';

import 'package:UNGolds/constant/button_design.dart';
import 'package:UNGolds/constant/extension.dart';
import 'package:UNGolds/constant/snackbardesign.dart';
import 'package:UNGolds/constant/utility.dart';
import 'package:UNGolds/network/response/get_city_response.dart';
import 'package:UNGolds/network/response/get_profile_response.dart';
import 'package:UNGolds/network/response/get_state_response.dart';
import 'package:UNGolds/network/response/update_onward_profile_response.dart';
import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../constant/app_color.dart';
import '../../constant/app_icon.dart';
import '../../constant/camerabuttonpage.dart';
import '../../constant/printmessage.dart';
import '../../constant/progressdialog.dart';
import '../../constant/textdesign.dart';
import '../../network/createjson.dart';
import '../../network/networkcall.dart';
import '../../network/networkutility.dart';
import '../bottom_navigation_bar.dart';

String fname = "", lname = "", email = "";
bool validatefname = true,
    validatelname = true,
    validateemail = true,
    validatestate = true,
    validatedist = true,
    validatetaluka = true,
    validatepincode = true,
    validateaddress = true;
String errorforpincode = "Please enter pincode";
final fnameController = TextEditingController();
final lnameController = TextEditingController();
final emailController = TextEditingController();
final talukaController = TextEditingController();
final pincodeController = TextEditingController();
final addressController = TextEditingController();
List<String> images = [];
String old_image = "", old_image_path = "";

class OnWardProfile extends StatefulWidget {
  bool isreturn;
  String id;
  OnWardProfile(this.id, this.isreturn);
  @override
  State createState() => OnWardProfileState();
}

class OnWardProfileState extends State<OnWardProfile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NetworkcallForgetprofiledetails();
    NetworkcallForgetstate();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    clearallfields();
  }

  clearallfields() {
    validatefname = true;
    validatelname = true;
    validatepincode = true;
    validateaddress = true;
    validatetaluka = true;
    validatestate = true;
    validatedist = true;
    fnameController.clear();
    lnameController.clear();
    emailController.clear();
    talukaController.clear();
    pincodeController.clear();
    addressController.clear();
    state_id = "";
    city_id = "";
  }

  Future<void> NetworkcallForgetprofiledetails() async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading");
      String createjson =
          CreateJson().createjsonforwithID(AppUtility.ID, context);
      Networkcall networkcall = Networkcall();
      List<Object?>? signup = await networkcall.postMethod(
          NetworkUtility.get_onward_profile,
          NetworkUtility.get_onward_profile_api,
          createjson,
          context);
      if (signup != null) {
        Navigator.pop(context);
        List<Getprofileresponse> profileresponse = List.from(signup!);
        String status = profileresponse[0].status.toString();
        switch (status) {
          case "true":
            fnameController.text = profileresponse[0].data![0].firstName!;
            lnameController.text = profileresponse[0].data![0].lastName!;
            emailController.text = profileresponse[0].data![0].email!;
            if (profileresponse[0].data![0].image == null) {
              old_image = "";
              old_image_path = "";
            } else {
              old_image = profileresponse[0].data![0].image!;
              old_image_path = profileresponse[0].data![0].image_path!;
            }
            setState(() {});
            break;
          case "false":
            SnackBarDesign(profileresponse[0].message!, context,
                AppColor.errorcolor, Colors.white);
            break;
        }
      } else {
        SnackBarDesign(
            "Something went wrong", context, AppColor.errorcolor, Colors.white);
        Navigator.pop(context);
      }
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), 'Networkcallforprofile', "Profile onward", context);
    }
  }

  List<GetstateresponseDatum> statelist = [];
  Future<void> NetworkcallForgetstate() async {
    try {
      city_id = "";
      state_id = "";
      citylist.clear();
      statelist.clear();
      ProgressDialog.showProgressDialog(context, "Loading");
      Networkcall networkcall = Networkcall();
      List<Object?>? signup = await networkcall.getMethod(
          NetworkUtility.get_state, NetworkUtility.get_state_api, context);
      if (signup != null) {
        Navigator.pop(context);
        List<Getstateresponse> stateresponse = List.from(signup!);
        String status = stateresponse[0].status.toString();
        switch (status) {
          case "true":
            statelist = stateresponse[0].data!;
            setState(() {});
            break;
          case "false":
            SnackBarDesign(stateresponse[0].message!, context,
                AppColor.errorcolor, Colors.white);
            break;
        }
      } else {
        Navigator.pop(context);
        SnackBarDesign('Something went wrong!', context, AppColor.errorcolor,
            Colors.white);
      }
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), 'Networkcallforlogin', "OTP Verify", context);
    }
  }

  String country_id = "", state_id = "", city_id = "";
  List<GetcityresponseDatum> citylist = [];
  Future<void> NetworkcallForgetcity(String stateid) async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading");
      String createjson = CreateJson().createjsonforCity(stateid, context);
      Networkcall networkcall = Networkcall();
      List<Object?>? signup = await networkcall.postMethod(
          NetworkUtility.get_state_city,
          NetworkUtility.get_state_city_api,
          createjson,
          context);
      if (signup != null) {
        Navigator.pop(context);
        List<Getcityresponse> cityresponse = List.from(signup!);
        String status = cityresponse[0].status.toString();
        switch (status) {
          case "true":
            citylist = cityresponse[0].data!;
            setState(() {});
            break;
          case "false":
            SnackBarDesign(cityresponse[0].message!, context,
                AppColor.errorcolor, Colors.white);
            break;
        }
      } else {
        Navigator.pop(context);
        SnackBarDesign('Something went wrong!', context, AppColor.errorcolor,
            Colors.white);
      }
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), 'Networkcallforcity', "Profile Onward", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      // endDrawer: CommonDrawer(),
      backgroundColor: context.theme.cardColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        toolbarHeight: 70,
        backgroundColor: context.theme.cardColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  'Update Profile'.introTitleText(context),
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
      body: SingleChildScrollView(
        // physics: BouncingScrollPhysics(),
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
                    margin: EdgeInsets.only(top: 10, bottom: 20),
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Stack(
                          children: [
                            Center(
                                child: AppUtility.imagePath == ""
                                    ? old_image == ""
                                        ? CircleAvatar(
                                            radius: 60,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color:
                                                        AppColor.buttoncolor),
                                              ),
                                            ),
                                            backgroundImage:
                                                AppIcon.userImage(),
                                          ).marginOnly(top: 5)
                                        : CircleAvatar(
                                            radius: 60,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color:
                                                        AppColor.buttoncolor),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        NetworkUtility
                                                                .base_api +
                                                            old_image_path),
                                                    fit: BoxFit.fill),
                                              ),
                                            ),
                                          )
                                    : CircleAvatar(
                                        radius: 60,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: AppColor.buttoncolor),
                                            image: DecorationImage(
                                                image: FileImage(
                                                    File(AppUtility.imagePath)),
                                                fit: BoxFit.fill),
                                          ),
                                        ),
                                      )),
                            Positioned(
                              top: 80,
                              right: 100,
                              child: CircleAvatar(
                                backgroundColor: AppColor.buttoncolor,
                                maxRadius: Checkbox.width,
                                child: IconButton(
                                    onPressed: () async {
                                      _showAttachmentOptionsForBackSheet(
                                          context);
                                    },
                                    icon: const Icon(
                                      CupertinoIcons.camera_fill,
                                      size: Checkbox.width,
                                      color: Colors.white,
                                    )),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text('First Name *',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14)),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: context.theme.colorScheme.background,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.only(left: 5),
                              child: Container(
                                margin: EdgeInsets.only(left: 5),
                                child: TextField(
                                  controller: fnameController,
                                  readOnly: true,
                                  enabled: true,
                                  style: TextStyle(color: Colors.black),
                                  cursorColor: Color(0xff7E7E7E),
                                  decoration: InputDecoration(
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      hintText: 'Enter your first name',
                                      // errorText:
                                      // validatefname ? null : 'Please enter first name',
                                      errorStyle: TextDesign.errortext,
                                      hintStyle: TextDesign.hinttext),
                                ),
                              ),
                            ).marginOnly(top: 10, right: 20),
                            SizedBox(
                              height: 2,
                            ),
                            validatefname
                                ? Container()
                                : Text(
                                    'Please enter first name',
                                    style: TextDesign.errortext,
                                  ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text('Last Name *',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14)),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: context.theme.colorScheme.background,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.only(left: 5),
                              child: Container(
                                margin: EdgeInsets.only(left: 5),
                                child: TextField(
                                  controller: lnameController,
                                  readOnly: true,
                                  enabled: true,
                                  style: TextStyle(color: Colors.black),
                                  cursorColor: Color(0xff7E7E7E),
                                  decoration: InputDecoration(
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      hintText: 'Enter your last name',
                                      // errorText:
                                      //     validatelname ? null : 'Please enter last name',
                                      errorStyle: TextDesign.errortext,
                                      hintStyle: TextDesign.hinttext),
                                ),
                              ),
                            ).marginOnly(top: 10, right: 20),
                            SizedBox(
                              height: 2,
                            ),
                            validatelname
                                ? Container()
                                : Text(
                                    'Please enter last name',
                                    style: TextDesign.errortext,
                                  ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text('Email Address *',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14)),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: context.theme.colorScheme.background,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.only(left: 5),
                              child: Container(
                                margin: EdgeInsets.only(left: 5),
                                child: TextField(
                                  controller: emailController,
                                  readOnly: true,
                                  enabled: true,
                                  style: TextStyle(color: Colors.black),
                                  cursorColor: Color(0xff7E7E7E),
                                  decoration: InputDecoration(
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      hintText: 'Enter your email address',
                                      // errorText: validateemail
                                      //     ? null
                                      //     : 'Please enter email address',
                                      errorStyle: TextDesign.errortext,
                                      hintStyle: TextDesign.hinttext),
                                ),
                              ),
                            ).marginOnly(top: 10, right: 20),
                            SizedBox(
                              height: 2,
                            ),
                            validateemail
                                ? Container()
                                : Text(
                                    'Please enter email address',
                                    style: TextDesign.errortext,
                                  ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text('Country *',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14)),
                            ),
                            Container(
                              height: 48,
                              margin: EdgeInsets.only(left: 5),
                              decoration: BoxDecoration(
                                color: context.theme.colorScheme.background,
                                borderRadius: BorderRadius.circular(5),
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                    color:
                                        AppColor.bordercolor.withOpacity(0.2)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                  value: country_id,
                                  isDense: true,
                                  isExpanded: true,
                                  menuMaxHeight: 350,
                                  items: const [
                                    DropdownMenuItem(
                                        child: Text(
                                          "India",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 117, 117, 117),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        value: ""),
                                  ],
                                  onChanged: (newValue) {},
                                )),
                              ),
                            ).marginOnly(top: 5, right: 20),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text('State *',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14)),
                            ),
                            Container(
                              height: 48,
                              margin: EdgeInsets.only(left: 5),
                              decoration: BoxDecoration(
                                color: context.theme.colorScheme.background,
                                borderRadius: BorderRadius.circular(5),
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                    color:
                                        AppColor.bordercolor.withOpacity(0.2)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                  value: state_id,
                                  isDense: true,
                                  isExpanded: true,
                                  menuMaxHeight: 350,
                                  items: [
                                    const DropdownMenuItem(
                                        child: Text(
                                          "Select State",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 117, 117, 117),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        value: ""),
                                    ...statelist
                                        .map<DropdownMenuItem<String>>((e) {
                                      return DropdownMenuItem(
                                          child: Text(
                                            e.name.toString(),
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
                                        state_id = newValue!;
                                        city_id = "";
                                        validatestate = true;
                                        citylist.clear();
                                        NetworkcallForgetcity(state_id);
                                      },
                                    );
                                  },
                                )),
                              ),
                            ).marginOnly(top: 10, right: 20),
                            SizedBox(
                              height: 2,
                            ),
                            validatestate
                                ? Container()
                                : Text(
                                    'Please select state',
                                    style: TextDesign.errortext,
                                  )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text('City *',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14)),
                            ),
                            Container(
                              height: 48,
                              margin: EdgeInsets.only(left: 5),
                              decoration: BoxDecoration(
                                color: context.theme.colorScheme.background,
                                borderRadius: BorderRadius.circular(5),
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                    color:
                                        AppColor.bordercolor.withOpacity(0.2)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: city_id,
                                    isDense: true,
                                    isExpanded: true,
                                    menuMaxHeight: 350,
                                    items: [
                                      const DropdownMenuItem(
                                          child: Text(
                                            "Select City",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 117, 117, 117),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          value: ""),
                                      ...citylist
                                          .map<DropdownMenuItem<String>>((e) {
                                        return DropdownMenuItem(
                                            child: Text(
                                              e.name.toString(),
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
                                          city_id = newValue!;
                                          validatedist = true;
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ).marginOnly(top: 10, right: 20),
                            SizedBox(
                              height: 2,
                            ),
                            validatedist
                                ? Container()
                                : Text(
                                    'Please select city',
                                    style: TextDesign.errortext,
                                  )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text('Taluka *',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14)),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: context.theme.colorScheme.background,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.only(left: 5),
                              child: Container(
                                margin: EdgeInsets.only(left: 5),
                                child: TextField(
                                  controller: talukaController,
                                  onChanged: (value) {
                                    validatetaluka = true;
                                    setState(() {});
                                  },
                                  style: TextStyle(color: Colors.black),
                                  cursorColor: Color(0xff7E7E7E),
                                  decoration: InputDecoration(
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      hintText: 'Enter Your Taluka',
                                      // errorText:
                                      //     validatetaluka ? null : 'Please enter taluka',
                                      errorStyle: TextDesign.errortext,
                                      hintStyle: TextDesign.hinttext),
                                ),
                              ),
                            ).marginOnly(top: 10, right: 20),
                            SizedBox(
                              height: 2,
                            ),
                            validatetaluka
                                ? Container()
                                : Text(
                                    'Please enter taluka',
                                    style: TextDesign.errortext,
                                  ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text('Pin Code *',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14)),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: context.theme.colorScheme.background,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.only(left: 5),
                              child: Container(
                                margin: EdgeInsets.only(left: 5),
                                child: TextField(
                                  controller: pincodeController,
                                  onChanged: (value) {
                                    validatepincode = false;
                                    if (value.length != 6) {
                                      errorforpincode =
                                          'Pincode must be exactly 6 digits long';
                                    } else if (value == '000000') {
                                      errorforpincode =
                                          'Pincode cannot be all zeros';
                                    } else if (!RegExp(r'^[1-9][0-9]{5}$')
                                        .hasMatch(value)) {
                                      errorforpincode = 'Invalid pincode';
                                    } else {
                                      validatepincode = true;
                                    }
                                    setState(() {});
                                  },
                                  style: TextStyle(color: Colors.black),
                                  keyboardType: TextInputType.number,
                                  // maxLength: 6,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp("[0-9]")),
                                    LengthLimitingTextInputFormatter(6),
                                  ],
                                  cursorColor: Color(0xff7E7E7E),
                                  decoration: InputDecoration(
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      hintText: 'Enter Your Pincode',
                                      // errorText:
                                      //     validatepincode ? null : 'Please enter pincode',
                                      errorStyle: TextDesign.errortext,
                                      hintStyle: TextDesign.hinttext),
                                ),
                              ),
                            ).marginOnly(top: 10, right: 20),
                            SizedBox(
                              height: 2,
                            ),
                            validatepincode
                                ? Container()
                                : Text(
                                    errorforpincode,
                                    style: TextDesign.errortext,
                                  ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text('Address *',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14)),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: context.theme.colorScheme.background,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.only(left: 5),
                              child: Container(
                                margin: EdgeInsets.only(left: 5),
                                child: TextField(
                                  controller: addressController,
                                  onChanged: (value) {
                                    validateaddress = true;
                                    setState(() {});
                                  },
                                  style: TextStyle(color: Colors.black),
                                  cursorColor: Color(0xff7E7E7E),
                                  decoration: InputDecoration(
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      hintText: 'Enter Your Address',
                                      // errorText:
                                      //     validateaddress ? null : 'Please enter address',
                                      errorStyle: TextDesign.errortext,
                                      hintStyle: TextDesign.hinttext),
                                ),
                              ),
                            ).marginOnly(top: 10, right: 20),
                            SizedBox(
                              height: 2,
                            ),
                            validateaddress
                                ? Container()
                                : Text(
                                    'Please enter address',
                                    style: TextDesign.errortext,
                                  ),
                          ],
                        ),
                        ButtonDesign(
                            onPressed: () {
                              validatefname = true;
                              validatelname = true;
                              validatepincode = true;
                              validateaddress = true;
                              validatetaluka = true;
                              validatestate = true;
                              validatedist = true;

                              if (fnameController.text.isEmpty &&
                                  lnameController.text.isEmpty &&
                                  state_id == '' &&
                                  city_id == "" &&
                                  talukaController.text.isEmpty &&
                                  pincodeController.text.isEmpty &&
                                  addressController.text.isEmpty) {
                                validatefname = false;
                                validatelname = false;
                                validatepincode = false;
                                validatetaluka = false;
                                validateaddress = false;
                                validatestate = false;
                                validatedist = false;
                                setState(() {});
                              } else if (lnameController.text.isEmpty &&
                                  state_id == '' &&
                                  city_id == "" &&
                                  talukaController.text.isEmpty &&
                                  pincodeController.text.isEmpty &&
                                  addressController.text.isEmpty) {
                                validatelname = false;
                                validatestate = false;
                                validatedist = false;
                                validatetaluka = false;
                                validatepincode = false;
                                validateaddress = false;

                                setState(() {});
                              } else if (state_id == '' &&
                                  city_id == "" &&
                                  talukaController.text.isEmpty &&
                                  pincodeController.text.isEmpty &&
                                  addressController.text.isEmpty) {
                                validatestate = false;
                                validatedist = false;
                                validatetaluka = false;
                                validatepincode = false;
                                validateaddress = false;
                                setState(() {});
                              } else if (city_id == "" &&
                                  talukaController.text.isEmpty &&
                                  pincodeController.text.isEmpty &&
                                  addressController.text.isEmpty) {
                                validatedist = false;
                                validatetaluka = false;
                                validatepincode = false;
                                validateaddress = false;
                                setState(() {});
                              } else if (talukaController.text.isEmpty &&
                                  pincodeController.text.isEmpty &&
                                  addressController.text.isEmpty) {
                                validatetaluka = false;
                                validatepincode = false;
                                validateaddress = false;
                                setState(() {});
                              } else if (pincodeController.text.isEmpty &&
                                  addressController.text.isEmpty) {
                                validatepincode = false;
                                validateaddress = false;
                                setState(() {});
                              } else if (fnameController.text.isEmpty) {
                                validatefname = false;

                                setState(() {});
                              } else if (lnameController.text.isEmpty) {
                                validatelname = false;

                                setState(() {});
                              } else if (state_id == "") {
                                validatestate = false;
                                setState(() {});
                              } else if (city_id == "") {
                                validatedist = false;

                                setState(() {});
                              } else if (talukaController.text.isEmpty) {
                                validatetaluka = false;

                                setState(() {});
                              } else if (pincodeController.text.isEmpty) {
                                validatepincode = false;

                                setState(() {});
                              } else if (addressController.text.isEmpty) {
                                validateaddress = false;

                                setState(() {});
                              } else {
                                setState(() {});
                                NetworkcallForUpdateProfile();
                              }
                            },
                            child: 'Update'.buttoText()),
                      ],
                    )),
              ],
            ).marginOnly(left: 20, right: 20),
          ),
        ),
      ),
    ));
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
          NetworkUtility.base_api + '/api-update-profile-image',
          data: formData,
          onSendProgress: (count, total) {
            print('count:$count,$total');
            if (count == total) {
              images.clear();
              images.add(filename);

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

  String? validatefields() {
    if (fnameController.text.isEmpty &&
        lnameController.text.isEmpty &&
        pincodeController.text.isEmpty &&
        talukaController.text.isEmpty &&
        addressController.text.isEmpty &&
        state_id == '' &&
        city_id == "") {
      validatefname = false;
      validatelname = false;
      validatepincode = false;
      validatetaluka = false;
      validateaddress = false;
      validatestate = false;
      validatedist = false;
      setState(() {});
      return "abc";
    } else if (lnameController.text.isEmpty &&
        pincodeController.text.isEmpty &&
        talukaController.text.isEmpty &&
        addressController.text.isEmpty &&
        state_id == '' &&
        city_id == "") {
      validatelname = false;
      validatepincode = false;
      validatetaluka = false;
      validateaddress = false;
      validatestate = false;
      validatedist = false;
      setState(() {});
      return "abc";
    } else if (pincodeController.text.isEmpty &&
        talukaController.text.isEmpty &&
        addressController.text.isEmpty &&
        state_id == '' &&
        city_id == "") {
      validatepincode = false;
      validatetaluka = false;
      validateaddress = false;
      validatestate = false;
      validatedist = false;
      setState(() {});
      return "abc";
    } else if (talukaController.text.isEmpty &&
        addressController.text.isEmpty &&
        state_id == '' &&
        city_id == "") {
      validatetaluka = false;
      validateaddress = false;
      validatestate = false;
      validatedist = false;
      setState(() {});
      return "abc";
    } else if (addressController.text.isEmpty &&
        state_id == '' &&
        city_id == "") {
      validateaddress = false;
      validatestate = false;
      validatedist = false;
      setState(() {});
      return "abc";
    } else if (state_id == '' && city_id == "") {
      validatestate = false;
      validatedist = false;
      setState(() {});
      return "abc";
    } else if (fnameController.text.isEmpty) {
      validatefname = false;
      validatelname = true;
      validatepincode = true;
      validateaddress = true;
      validatetaluka = true;
      validatedist = true;
      validatestate = true;
      setState(() {});
      return "abc";
    } else if (lnameController.text.isEmpty) {
      validatefname = true;
      validatelname = false;
      validatepincode = true;
      validateaddress = true;
      validatetaluka = true;
      validatedist = true;
      validatestate = true;
      setState(() {});
      return "abc";
    } else if (state_id == "") {
      validatefname = true;
      validatelname = true;
      validatepincode = true;
      validateaddress = true;
      validatetaluka = true;
      validatedist = true;
      validatestate = false;
      setState(() {});
      return "abc";
    } else if (city_id == "") {
      validatefname = true;
      validatelname = true;
      validatepincode = true;
      validateaddress = true;
      validatetaluka = true;
      validatedist = false;
      validatestate = true;
      setState(() {});
      return "abc";
    } else if (talukaController.text.isEmpty) {
      validatefname = true;
      validatelname = true;
      validatepincode = true;
      validateaddress = true;
      validatetaluka = false;
      validatedist = true;
      validatestate = true;
      setState(() {});
      return "abc";
    } else if (pincodeController.text.isEmpty) {
      validatefname = true;
      validatelname = true;
      validatepincode = false;
      validateaddress = true;
      validatetaluka = true;
      validatedist = true;
      validatestate = true;
      setState(() {});
      return "abc";
    } else if (addressController.text.isEmpty) {
      validatefname = true;
      validatelname = true;
      validatepincode = true;
      validateaddress = false;
      validatetaluka = true;
      validatedist = true;
      validatestate = true;
      setState(() {});
      return "abc";
    } else {
      validatefname = true;
      validatelname = true;
      validatepincode = true;
      validateaddress = true;
      validatetaluka = true;
      validatestate = true;
      validatedist = true;
      setState(() {});
      return null;
    }
  }

  Future<void> NetworkcallForUpdateProfile() async {
    try {
      String image = "";
      if (images.isEmpty) {
        image = "";
      } else {
        image = images[0];
      }
      ProgressDialog.showProgressDialog(context, "title");
      String createjson = CreateJson().cretejsonforupdateonwardprofile(
          AppUtility.ID,
          fnameController.text,
          lnameController.text,
          "India",
          city_id,
          state_id,
          image,
          pincodeController.text,
          addressController.text,
          talukaController.text,
          old_image,
          context);
      Networkcall networkcall = Networkcall();
      List<Object?>? signup = await networkcall.postMethod(
          NetworkUtility.update_onward_profile,
          NetworkUtility.update_onward_profile_api,
          createjson,
          context);
      if (signup != null) {
        Navigator.pop(context);
        List<Updateonwardprofileresponse> profileresponse = List.from(signup!);
        String status = profileresponse[0].status.toString();
        switch (status) {
          case "true":
            SnackBarDesign("Profile update successfully!", context,
                AppColor.sucesscolor, Colors.white);
            widget.isreturn
                ? Navigator.popUntil(
                    context,
                    (Route<dynamic> route) {
                      return route.settings.name == 'checkout' || route.isFirst;
                    },
                  )
                : Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return BottomNavigationBarPage(); // Replace this with your home page widget
                      },
                    ),
                    (Route<dynamic> route) =>
                        false, // This condition ensures all previous routes are removed
                  );

            break;
          case "false":
            SnackBarDesign(profileresponse[0].message!, context,
                AppColor.errorcolor, Colors.white);
            break;
        }
      } else {
        SnackBarDesign(
            "Something went wrong", context, AppColor.errorcolor, Colors.white);
        Navigator.pop(context);
      }
    } catch (e) {
      PrintMessage.printmessage(e.toString(), 'NetworkcallForUpdateProfile',
          'Profile OnWard', context);
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
    Future<String?> pickedImage = CameraButtonPageState(false).captureImage();
    if (await pickedImage != null) {
      // Navigator.pop(context);
      AppUtility.imagePath = (await pickedImage)!;
      final ext = AppUtility.imagePath.split('.').last;
      ProgressDialog.showProgressDialog(context, "Loading...");
      uploadfile(
          iofile.File(AppUtility.imagePath),
          DateTime.now().microsecondsSinceEpoch.toString() + '.' + ext,
          context);
      setState(() {});
    }
  }

  void _pickImageFromGallaryForBackSheet() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (await result != null) {
      File? img = File(result!.files.first.path!);

      String pickedImage = img!.path!;

      AppUtility.imagePath = (await pickedImage)!;

      final ext = AppUtility.imagePath.split('.').last;
      String filename =
          DateTime.now().microsecondsSinceEpoch.toString() + '.' + ext;
      ProgressDialog.showProgressDialog(context, "Loading...");
      uploadfile(
          iofile.File(AppUtility.imagePath),
          DateTime.now().microsecondsSinceEpoch.toString() + '.' + ext,
          context);
      setState(() {});
    }
  }
}
