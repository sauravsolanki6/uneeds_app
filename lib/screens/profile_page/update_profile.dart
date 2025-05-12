import 'dart:io' as iofile;
import 'dart:io';

import 'package:UNGolds/constant/button_design.dart';
import 'package:UNGolds/constant/extension.dart';
import 'package:UNGolds/constant/snackbardesign.dart';
import 'package:UNGolds/constant/utility.dart';
import 'package:UNGolds/network/response/get_city_response.dart';
import 'package:UNGolds/network/response/get_profile_response.dart';
import 'package:UNGolds/network/response/get_state_response.dart';
import 'package:UNGolds/network/response/update_profile_response.dart';
import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import '../../constant/app_color.dart';
import '../../constant/app_icon.dart';
import '../../constant/camerabuttonpage.dart';
import '../../constant/printmessage.dart';
import '../../constant/progressdialog.dart';
import '../../constant/show_confirmation_dialog.dart';
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
    validateaddress = true,
    validateaadhar = true,
    validatepanno = true,
    validatedate = true;
// validategst = true;
String errorforgst = "", errorforpan = "", errorforaadhaar = "";
final fnameController = TextEditingController();
final lnameController = TextEditingController();
final emailController = TextEditingController();
final talukaController = TextEditingController();
final pincodeController = TextEditingController();
final addressController = TextEditingController();
final bdayController = TextEditingController();
final anniversaryController = TextEditingController();
final aadhaarController = TextEditingController();
final pancardController = TextEditingController();
final gstnoController = TextEditingController();
List<String> images = [];
String old_image = "", old_image_path = "", bdaydate = "", anniversarydate = "";

class UpdateProfile extends StatefulWidget {
  String id;
  UpdateProfile(this.id);
  @override
  State createState() => UpdateProfileState();
}

class UpdateProfileState extends State<UpdateProfile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    statelist.clear;
    citylist.clear();
    NetworkcallForgetprofiledetails();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    fnameController.clear();
    lnameController.clear();
    emailController.clear();
    talukaController.clear();
    pincodeController.clear();
    addressController.clear();
    bdayController.clear();
    anniversaryController.clear();
    aadhaarController.clear();
    pancardController.clear();
    gstnoController.clear();
    country_id = "";
    state_id = "";
    city_id = "";
    pre_state_id = "";
    pre_city_id = "";
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
            if (profileresponse[0].data![0].state == null) {
            } else {
              pre_state_id = profileresponse[0].data![0].state!;
            }
            if (profileresponse[0].data![0].district == null) {
            } else {
              pre_city_id = profileresponse[0].data![0].district!;
            }
            if (profileresponse[0].data![0].taluka == null) {
            } else {
              talukaController.text = profileresponse[0].data![0].taluka!;
            }
            if (profileresponse[0].data![0].pincode == null) {
            } else {
              pincodeController.text = profileresponse[0].data![0].pincode!;
            }
            if (profileresponse[0].data![0].address == null) {
            } else {
              addressController.text = profileresponse[0].data![0].address!;
            }
            if (profileresponse[0].data![0].birthDate == null) {
            } else {
              bdaydate = profileresponse[0].data![0].birthDate!;
              bdayController.text = profileresponse[0].data![0].birthDate!;
            }
            if (profileresponse[0].data![0].annivarsary == null) {
            } else {
              anniversarydate = profileresponse[0].data![0].annivarsary!;
              anniversaryController.text =
                  profileresponse[0].data![0].annivarsary!;
            }
            if (profileresponse[0].data![0].aadharNo == null) {
            } else {
              aadhaarController.text = profileresponse[0].data![0].aadharNo!;
            }
            if (profileresponse[0].data![0].panNo == null) {
            } else {
              pancardController.text = profileresponse[0].data![0].panNo!;
            }
            if (profileresponse[0].data![0].gstNo == null) {
            } else {
              gstnoController.text = profileresponse[0].data![0].gstNo!;
            }
            NetworkcallForgetstate();
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

  List<String> countrylist = ['India'];
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
            for (int i = 0; i < statelist.length; i++) {
              if (pre_state_id == statelist[i].id) {
                state_id = pre_state_id;
                NetworkcallForgetcity(state_id);
                break;
              }
            }
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

  String country_id = "",
      state_id = "",
      city_id = "",
      pre_state_id = "",
      pre_city_id = "";
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
            for (int i = 0; i < citylist.length; i++) {
              if (pre_city_id == citylist[i].id) {
                city_id = pre_city_id;
                break;
              }
            }
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
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
                  'Update Profile'.introTitleText(context),
                ],
              ).marginOnly(top: 10),
            ),
            const CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 25,
            ).marginOnly(right: 10, top: 10)
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [
                AppColor.intoColor.withOpacity(0.4),
                AppColor.theamecolor.withOpacity(0.4)
              ], // Adjust the colors as needed
            ),
          ),
          child: BackdropFilter(
            filter: const ColorFilter.mode(Colors.white, BlendMode.softLight),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Stack(
                  children: [
                    Center(
                        child: AppUtility.imagePath == ""
                            ? old_image == ""
                                ? CircleAvatar(
                                    radius: 50,
                                    backgroundImage: AppIcon.userImage(),
                                  ).marginOnly(top: 5)
                                : CircleAvatar(
                                    radius: 50,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: AppColor.buttoncolor),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                NetworkUtility.base_api +
                                                    old_image_path),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                  )
                            : CircleAvatar(
                                radius: 50,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: FileImage(
                                            File(AppUtility.imagePath)),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                              )),
                    Positioned(
                      top: 55,
                      right: 140,
                      child: CircleAvatar(
                        backgroundColor: AppColor.buttoncolor,
                        child: IconButton(
                            onPressed: () async {
                              _showAttachmentOptions(context);
                            },
                            icon: const Icon(
                              CupertinoIcons.camera_fill,
                              color: Colors.white,
                            )),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                const Text(
                  'Welcome to Uneeds Gold! Personalize and ',
                  style: TextStyle(
                      color: Color.fromARGB(255, 58, 58, 59),
                      fontSize: 10,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
                const Text(
                  'manage your account for top-notch service ',
                  style: TextStyle(
                      color: Color.fromARGB(255, 58, 58, 59),
                      fontSize: 10,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 15, right: 15),
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.black.withOpacity(0.2),
                    //     spreadRadius: 0,
                    //     blurRadius: 2,
                    //     offset: Offset(0, 0),
                    //   ),
                    // ],
                  ),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: 'First Name *'.TegSubText_new(),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: context.theme.colorScheme.background,
                                borderRadius: BorderRadius.circular(10)),
                            // margin: EdgeInsets.only(left: 5),
                            child: Container(
                              margin: const EdgeInsets.only(left: 5),
                              child: TextField(
                                controller: fnameController,
                                style: const TextStyle(color: Colors.black),
                                cursorColor: const Color(0xff7E7E7E),
                                decoration: InputDecoration(
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    hintText: 'Enter your first name',
                                    errorText: validatefname
                                        ? null
                                        : 'Please enter first name',
                                    errorStyle: TextDesign.errortext,
                                    hintStyle: TextDesign.hinttext),
                              ),
                            ),
                          ).marginOnly(top: 5, right: 0),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: 'Last Name *'.TegSubText_new(),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: context.theme.colorScheme.background,
                                borderRadius: BorderRadius.circular(10)),
                            // margin: EdgeInsets.only(left: 5),
                            child: Container(
                              margin: const EdgeInsets.only(left: 5),
                              child: TextField(
                                controller: lnameController,
                                style: const TextStyle(color: Colors.black),
                                cursorColor: const Color(0xff7E7E7E),
                                decoration: InputDecoration(
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    hintText: 'Enter your last name',
                                    errorText: validatelname
                                        ? null
                                        : 'Please enter last name',
                                    errorStyle: TextDesign.errortext,
                                    hintStyle: TextDesign.hinttext),
                              ),
                            ),
                          ).marginOnly(top: 5, right: 0),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: 'Email Address *'.TegSubText_new(),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: context.theme.colorScheme.background,
                                borderRadius: BorderRadius.circular(10)),
                            // margin: EdgeInsets.only(left: 5),
                            child: Container(
                              margin: const EdgeInsets.only(left: 5),
                              child: TextField(
                                controller: emailController,
                                readOnly: true,
                                enabled: true,
                                style: const TextStyle(color: Colors.black),
                                cursorColor: const Color(0xff7E7E7E),
                                decoration: InputDecoration(
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    hintText: 'Enter your email address',
                                    errorText: validateemail
                                        ? null
                                        : 'Please enter email address',
                                    errorStyle: TextDesign.errortext,
                                    hintStyle: TextDesign.hinttext),
                              ),
                            ),
                          ).marginOnly(top: 5, right: 0),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: 'Country *'.TegSubText_new(),
                          ),
                          Container(
                            height: 48,
                            // margin: EdgeInsets.only(left: 5),
                            decoration: BoxDecoration(
                              color: context.theme.colorScheme.background,
                              borderRadius: BorderRadius.circular(10),
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                  color: AppColor.bordercolor.withOpacity(0.2)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                value: country_id,
                                isDense: true,
                                isExpanded: true,
                                menuMaxHeight: 350,
                                items: [
                                  const DropdownMenuItem(
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
                          ).marginOnly(top: 5, right: 0),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: 'State *'.TegSubText_new(),
                          ),
                          Container(
                            height: 48,
                            // margin: EdgeInsets.only(left: 5),
                            decoration: BoxDecoration(
                              color: context.theme.colorScheme.background,
                              borderRadius: BorderRadius.circular(10),
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                  color: AppColor.bordercolor.withOpacity(0.2)),
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
                                  setState(() {
                                    state_id = newValue!;
                                    city_id = "";
                                    validatestate = true;
                                    citylist.clear();
                                    NetworkcallForgetcity(state_id);
                                  });
                                },
                              )),
                            ),
                          ).marginOnly(top: 5, right: 0),
                          validatestate
                              ? Container()
                              : const Text(
                                  'Please select state',
                                  style: TextDesign.errortext,
                                )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: 'City *'.TegSubText_new(),
                          ),
                          Container(
                            height: 48,
                            // margin: EdgeInsets.only(left: 5),
                            decoration: BoxDecoration(
                              color: context.theme.colorScheme.background,
                              borderRadius: BorderRadius.circular(10),
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                  color: AppColor.bordercolor.withOpacity(0.2)),
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
                          ).marginOnly(top: 5, right: 0),
                          validatedist
                              ? Container()
                              : const Text(
                                  'Please select city',
                                  style: TextDesign.errortext,
                                )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: 'Taluka *'.TegSubText_new(),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: context.theme.colorScheme.background,
                                borderRadius: BorderRadius.circular(10)),
                            // margin: EdgeInsets.only(left: 5),
                            child: Container(
                              margin: const EdgeInsets.only(left: 5),
                              child: TextField(
                                controller: talukaController,
                                style: const TextStyle(color: Colors.black),
                                cursorColor: const Color(0xff7E7E7E),
                                decoration: InputDecoration(
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    hintText: 'Enter Your Taluka',
                                    errorText: validatetaluka
                                        ? null
                                        : 'Please enter taluka',
                                    errorStyle: TextDesign.errortext,
                                    hintStyle: TextDesign.hinttext),
                              ),
                            ),
                          ).marginOnly(top: 5, right: 0),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: 'Pin Code *'.TegSubText_new(),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: context.theme.colorScheme.background,
                                borderRadius: BorderRadius.circular(10)),
                            // margin: EdgeInsets.only(left: 5),
                            child: Container(
                              margin: const EdgeInsets.only(left: 5, right: 5),
                              child: TextField(
                                controller: pincodeController,
                                style: const TextStyle(color: Colors.black),
                                keyboardType: TextInputType.number,
                                maxLength: 6,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[0-9]"))
                                ],
                                cursorColor: const Color(0xff7E7E7E),
                                decoration: InputDecoration(
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    hintText: 'Enter Your Pincode',
                                    counterText: "",
                                    errorText: validatepincode
                                        ? null
                                        : 'Please enter pincode',
                                    errorStyle: TextDesign.errortext,
                                    hintStyle: TextDesign.hinttext),
                              ),
                            ),
                          ).marginOnly(top: 5, right: 0),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: 'Address *'.TegSubText_new(),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: context.theme.colorScheme.background,
                                borderRadius: BorderRadius.circular(10)),
                            // margin: EdgeInsets.only(left: 5),
                            child: Container(
                              margin: const EdgeInsets.only(left: 5),
                              child: TextField(
                                controller: addressController,
                                style: const TextStyle(color: Colors.black),
                                cursorColor: const Color(0xff7E7E7E),
                                decoration: InputDecoration(
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    hintText: 'Enter Your Address',
                                    errorText: validateaddress
                                        ? null
                                        : 'Please enter address',
                                    errorStyle: TextDesign.errortext,
                                    hintStyle: TextDesign.hinttext),
                              ),
                            ),
                          ).marginOnly(top: 5, right: 0),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: 'Birth Date *'.TegSubText_new(),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: context.theme.colorScheme.background,
                                borderRadius: BorderRadius.circular(10)),
                            // margin: EdgeInsets.only(left: 5),
                            child: Container(
                              margin: const EdgeInsets.only(left: 5),
                              child: TextField(
                                controller: bdayController,
                                readOnly: true,
                                enabled: true,
                                style: const TextStyle(color: Colors.black),
                                cursorColor: const Color(0xff7E7E7E),
                                decoration: InputDecoration(
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    hintText: 'Enter Your Birth Date',
                                    errorText: validatedate
                                        ? null
                                        : 'Please enter birth date',
                                    errorStyle: TextDesign.errortext,
                                    hintStyle: TextDesign.hinttext,
                                    suffixIcon: IconButton(
                                        onPressed: () async {
                                          validatedate = true;
                                          setState(() {});
                                          DateTime? pickedDate =
                                              await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(1950),
                                                  lastDate: DateTime.now());

                                          if (pickedDate != null) {
                                            String day =
                                                pickedDate.day.toString();
                                            String month =
                                                pickedDate.month.toString();
                                            String year =
                                                pickedDate.year.toString();
                                            String date =
                                                day + '/' + month + '/' + year;
                                            bdaydate =
                                                day + '-' + month + '-' + year;
                                            bdayController.text = date;
                                          }
                                        },
                                        icon: const Icon(
                                            Icons.calendar_month_outlined))),
                              ),
                            ),
                          ).marginOnly(top: 5, right: 0),
                        ],
                      ).marginOnly(),
                      const SizedBox(
                        height: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: 'Anniversary Date '.TegSubText_new(),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: context.theme.colorScheme.background,
                                borderRadius: BorderRadius.circular(10)),
                            // margin: EdgeInsets.only(left: 5),
                            child: Container(
                              margin: const EdgeInsets.only(left: 5),
                              child: TextField(
                                controller: anniversaryController,
                                readOnly: true,
                                enabled: true,
                                style: const TextStyle(color: Colors.black),
                                cursorColor: const Color(0xff7E7E7E),
                                decoration: InputDecoration(
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    hintText: 'Enter Your Anniversary Date',
                                    hintStyle: TextDesign.hinttext,
                                    suffixIcon: IconButton(
                                        onPressed: () async {
                                          setState(() {});
                                          DateTime? pickedDate =
                                              await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(1950),
                                                  lastDate: DateTime.now());

                                          if (pickedDate != null) {
                                            String day =
                                                pickedDate.day.toString();
                                            String month =
                                                pickedDate.month.toString();
                                            String year =
                                                pickedDate.year.toString();
                                            String date =
                                                day + '/' + month + '/' + year;
                                            anniversarydate =
                                                day + '-' + month + '-' + year;
                                            anniversaryController.text = date;
                                          }
                                        },
                                        icon: const Icon(
                                            Icons.calendar_month_outlined))),
                              ),
                            ),
                          ).marginOnly(top: 5, right: 0),
                        ],
                      ).marginOnly(),
                      const SizedBox(
                        height: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: 'Aadhaar Card Number *'.TegSubText_new(),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: context.theme.colorScheme.background,
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                              margin: const EdgeInsets.only(left: 5, right: 5),
                              child: TextField(
                                controller: aadhaarController,
                                keyboardType: TextInputType.number,
                                maxLength: 12,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[0-9]"))
                                ],
                                style: const TextStyle(color: Colors.black),
                                cursorColor: const Color(0xff7E7E7E),
                                decoration: InputDecoration(
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    counterText: "",
                                    hintText: 'Enter Your Aadhaar Card Number',
                                    errorText:
                                        validateaadhar ? null : errorforaadhaar,
                                    errorStyle: TextDesign.errortext,
                                    hintStyle: TextDesign.hinttext),
                              ),
                            ),
                          ).marginOnly(top: 5, right: 0),
                        ],
                      ).marginOnly(),
                      const SizedBox(
                        height: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: 'Pan Card Number *'.TegSubText_new(),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: context.theme.colorScheme.background,
                                borderRadius: BorderRadius.circular(10)),
                            // margin: EdgeInsets.only(left: 5),
                            child: Container(
                              margin: const EdgeInsets.only(left: 5),
                              child: TextField(
                                controller: pancardController,
                                style: const TextStyle(color: Colors.black),
                                cursorColor: const Color(0xff7E7E7E),
                                decoration: InputDecoration(
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    hintText: 'Enter Your Pan Card Number',
                                    errorText:
                                        validatepanno ? null : errorforpan,
                                    errorStyle: TextDesign.errortext,
                                    hintStyle: TextDesign.hinttext),
                              ),
                            ),
                          ).marginOnly(top: 5, right: 0, bottom: 5),
                        ],
                      ).marginOnly(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: 'GST Number '.TegSubText_new(),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: context.theme.colorScheme.background,
                                borderRadius: BorderRadius.circular(10)),
                            // margin: EdgeInsets.only(left: 5),
                            child: Container(
                              margin: const EdgeInsets.only(left: 5),
                              child: TextField(
                                controller: gstnoController,
                                style: const TextStyle(color: Colors.black),
                                cursorColor: const Color(0xff7E7E7E),
                                decoration: InputDecoration(
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    hintText: 'Enter Your Gst  Number',
                                    //   errorText: validategst ? null : errorforgst,
                                    errorStyle: TextDesign.errortext,
                                    hintStyle: TextDesign.hinttext),
                              ),
                            ),
                          ).marginOnly(top: 5, right: 0),
                        ],
                      ).marginOnly(),
                      ButtonDesign(
                          onPressed: () {
                            validatefname = true;
                            validatelname = true;
                            validatestate = true;
                            validatedist = true;
                            validatetaluka = true;
                            validatepincode = true;
                            validateaddress = true;
                            validatedate = true;
                            validateaadhar = true;
                            validatepanno = true;
                            // validategst = true;
                            if (fnameController.text.isEmpty) {
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
                            } else if (bdayController.text.isEmpty) {
                              validatedate = false;
                              setState(() {});
                            } else if (aadhaarController.text.isEmpty) {
                              validateaadhar = false;
                              errorforaadhaar =
                                  'Please enter aadhaar card number';
                              setState(() {});
                            } else if (isValidAadharNumber(
                                    aadhaarController.text) ==
                                false) {
                              errorforaadhaar =
                                  "Please enter valid aadhaar card number";
                              validateaadhar = false;
                              setState(() {});
                            } else if (pancardController.text.isEmpty) {
                              errorforpan = 'Please enter pan card number';
                              validatepanno = false;
                              setState(() {});
                            } else if (validatepan(pancardController.text) ==
                                false) {
                              errorforpan = "Please enter valid PAN number";
                              validatepanno = false;
                              setState(() {});
                              // } else if (gstnoController.text.isEmpty) {
                              //   validategst = false;
                              //   setState(() {});
                              //   errorforgst = "Please enter GST number";
                              // } else if (validategdt(gstnoController.text) ==
                              //     false) {
                              //   errorforgst = "Please enter valid GST number";
                              //   validategst = false;
                              //   setState(() {});
                            } else {
                              setState(() {});
                              showConfirmationDialog(context);
                            }
                          },
                          child: 'Update'.buttoText())
                    ],
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    ));
  }

  showConfirmationDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialogDesign(
            description: "Are you sure? Do you want to update profile?",
            nobuttonPressed: () {
              Navigator.pop(context);
            },
            yesbuttonPressed: () {
              Navigator.pop(context);
              NetworkcallForUpdateProfile();
            },
            title: "Confirmation",
          );
        });
  }

  bool validategdt(String gst) {
    String pattern =
        r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(gst)) {
      return false;
    } else {
      return true;
    }
  }

  bool isValidAadharNumber(String gst) {
    String pattern = r'^[2-9]{1}[0-9]{3}[0-9]{4}[0-9]{4}$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(gst)) {
      return false;
    } else {
      return true;
    }
  }

  bool validatepan(String gst) {
    String pattern = r'[A-Z]{5}[0-9]{4}[A-Z]{1}';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(gst)) {
      return false;
    } else {
      return true;
    }
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
      ProgressDialog.showProgressDialog(context, "Loading...");
      String image = "";
      if (images.isEmpty) {
        image = "";
      } else {
        image = images[0];
      }
      String createjson = CreateJson().cretejsonforupdateprofile(
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
          context,
          bdaydate,
          anniversarydate,
          aadhaarController.text,
          pancardController.text,
          gstnoController.text);
      Networkcall networkcall = Networkcall();
      List<Object?>? signup = await networkcall.postMethod(
          NetworkUtility.update_profile,
          NetworkUtility.update_profile_api,
          createjson,
          context);
      if (signup != null) {
        Navigator.pop(context);
        List<Updateprofileresponse> profileresponse = List.from(signup!);
        String status = profileresponse[0].status.toString();
        switch (status) {
          case "true":
            SnackBarDesign("Profile update successfully!", context,
                AppColor.sucesscolor, Colors.white);
            Navigator.pop(context);
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

  void _showAttachmentOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera),
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
                leading: const Icon(Icons.insert_drive_file),
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

  void _pickImageFromCamera() async {
    Future<String?> pickedImage = CameraButtonPageState(true).captureImage();
    if (await pickedImage != null) {
      AppUtility.imagePath = (await pickedImage)!;

      final ext = AppUtility.imagePath.split('.').last;

      String filename1 =
          DateTime.now().microsecondsSinceEpoch.toString() + '.' + ext;
      ProgressDialog.showProgressDialog(context, "Loading...");
      uploadfile(File(AppUtility.imagePath), filename1, context);

      //  AppUtility.imagePath = filename1;

      setState(() {});
    }
  }

  void _pickImageFromGallery() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['png', 'jpg', 'jpeg']);

    if (await result != null) {
      File? img = File(result!.files.first.path!);
      img = await _cropImage(img);
      String pickedImage = img!.path!;

      AppUtility.imagePath = (await pickedImage)!;

      final ext = AppUtility.imagePath.split('.').last;
      String filename1 =
          DateTime.now().microsecondsSinceEpoch.toString() + '.' + ext;
      ProgressDialog.showProgressDialog(context, "Loading...");
      uploadfile(File(AppUtility.imagePath), filename1, context);

      //AppUtility.imagePath = filename1;
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
}
