import 'package:UNGolds/constant/button_design.dart';
import 'package:UNGolds/constant/drawer_design.dart';
import 'package:UNGolds/constant/extension.dart';
import 'package:UNGolds/screens/bankdetailpage/kyc_detail_page.dart';
import 'package:UNGolds/screens/profile_page/addnomineedetails.dart';
import 'package:UNGolds/screens/profile_page/update_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../constant/app_color.dart';
import '../../constant/app_icon.dart';
import '../../constant/login_drawer.dart';
import '../../constant/printmessage.dart';
import '../../constant/progressdialog.dart';
import '../../constant/shared_pre.dart';
import '../../constant/snackbardesign.dart';
import '../../constant/utility.dart';
import '../../network/createjson.dart';
import '../../network/networkcall.dart';
import '../../network/networkutility.dart';
import '../../network/response/get_profile_response.dart';

final fnameController = TextEditingController();
final lnameController = TextEditingController();
final mobileController = TextEditingController();

final emailController = TextEditingController();
final talukaController = TextEditingController();
final pincodeController = TextEditingController();
final addressController = TextEditingController();
final countryController = TextEditingController();
final stateController = TextEditingController();
final cityController = TextEditingController();
final bdayController = TextEditingController();
final anniversaryController = TextEditingController();
final aadhaarController = TextEditingController();
final pancardController = TextEditingController();
final gstnocontroller = TextEditingController();
final nomineenamecontroller = TextEditingController();
final nomineecontactcontroller = TextEditingController();
final nomineeagecontroller = TextEditingController();
final nomineerelationcontroller = TextEditingController();
final nomineeaddresscontroller = TextEditingController();
String old_image = "", old_image_path = "", kycstatus = "";
String memberfromController = "";
bool adddetails = false;

class ProfileDetails extends StatefulWidget {
  @override
  State createState() => ProfileDetailsState();
}

class ProfileDetailsState extends State<ProfileDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NetworkcallForgetprofiledetails();
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
            mobileController.text = profileresponse[0].data![0].mobile!;
            AppUtility.NAME = profileresponse[0].data![0].firstName! +
                " " +
                profileresponse[0].data![0].lastName!;
            setState(() {});
            SharedPreference().savevalueonlogin(
                AppUtility.ID,
                profileresponse[0].data![0].firstName! +
                    " " +
                    profileresponse[0].data![0].lastName!,
                profileresponse[0].data![0].mobile!,
                profileresponse[0].data![0].password!,
                context);
            memberfromController = DateFormat('dd-MM-yyyy')
                .format(profileresponse[0].data![0].createdOn!);
            if (profileresponse[0].data![0].image == null) {
              old_image = "";
              old_image_path = "";
            } else {
              old_image = profileresponse[0].data![0].image!;
              old_image_path = profileresponse[0].data![0].image_path!;
            }
            if (profileresponse[0].data![0].sname == null) {
            } else {
              stateController.text = profileresponse[0].data![0].sname!;
            }
            if (profileresponse[0].data![0].country == null) {
            } else {
              countryController.text = profileresponse[0].data![0].country!;
            }
            if (profileresponse[0].data![0].cname == null) {
            } else {
              cityController.text = profileresponse[0].data![0].cname!;
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
              bdayController.text = profileresponse[0].data![0].birthDate!;
            }
            if (profileresponse[0].data![0].annivarsary == null) {
            } else {
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
              gstnocontroller.text = profileresponse[0].data![0].gstNo!;
            }
            if (profileresponse[0].data![0].nomineeName == null ||
                profileresponse[0].data![0].nomineeName == "") {
              adddetails = true;
            } else {
              adddetails = false;
              nomineenamecontroller.text =
                  profileresponse[0].data![0].nomineeName!;
            }
            if (profileresponse[0].data![0].nomineeContact == null) {
            } else {
              nomineecontactcontroller.text =
                  profileresponse[0].data![0].nomineeContact!;
            }
            if (profileresponse[0].data![0].nomineeAge == null) {
            } else {
              nomineeagecontroller.text =
                  profileresponse[0].data![0].nomineeAge!;
            }
            if (profileresponse[0].data![0].relationWithCustomer == null) {
            } else {
              nomineerelationcontroller.text =
                  profileresponse[0].data![0].relationWithCustomer!;
            }
            if (profileresponse[0].data![0].nomineeAddress == null) {
            } else {
              nomineeaddresscontroller.text =
                  profileresponse[0].data![0].nomineeAddress!;
            }
            if (profileresponse[0].data![0].kyc == null) {
              kycstatus = "No Status";
            } else if (profileresponse[0].data![0].kyc == "1") {
              kycstatus = "KYC Done";
            } else if (profileresponse[0].data![0].kyc == "0") {
              kycstatus = "KYC Pending";
            } else if (profileresponse[0].data![0].kyc == "2") {
              kycstatus = "KYC Rejected";
            } else if (profileresponse[0].data![0].kyc == "3") {
              kycstatus = "Document Submitted";
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
          e.toString(), 'Networkcallforgetprofile', "Profile details", context);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    adddetails = false;
    nomineenamecontroller.clear();
    nomineeagecontroller.clear();
    nomineecontactcontroller.clear();
    nomineerelationcontroller.clear();
    nomineeaddresscontroller.clear();
    fnameController.clear();
    lnameController.clear();
    mobileController.clear();
    emailController.clear();
    talukaController.clear();
    pincodeController.clear();
    addressController.clear();
    countryController.clear();
    stateController.clear();
    cityController.clear();
    bdayController.clear();
    anniversaryController.clear();
    aadhaarController.clear();
    pancardController.clear();
    gstnocontroller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            endDrawer: AppUtility.ID != "" ? CommonDrawer() : LoginDrawer(),
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
                        'My Profile'.introTitleText(context),
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
              child: SafeArea(
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/bg.png'), // Replace 'assets/background_image.jpg' with your image path
                      fit: BoxFit.cover, //
                    ),
                  ),
                  child: Column(children: [
                    //SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            old_image == ""
                                ? Center(
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundImage: AppIcon.userImage(),
                                    ).marginOnly(top: 5),
                                  )
                                : Center(
                                    child: CircleAvatar(
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
                                    ),
                                  ),
                            Text(
                              'Member From : ' + memberfromController,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 58, 58, 59),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        // IconButton(
                        //     onPressed: () {
                        //       Navigator.push(context, MaterialPageRoute(
                        //         builder: (context) {
                        //           return UpdateProfile(AppUtility.ID);
                        //         },
                        //       )).then((value) {
                        //         NetworkcallForgetprofiledetails();
                        //       });
                        //     },
                        //     icon: const Icon(
                        //       CupertinoIcons.pen,
                        //       color: Colors.black,
                        //     )),
                      ],
                    ),

                    Container(
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 15, bottom: 15),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: 'First Name'.TegSubText_new(),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: context.theme.colorScheme.background,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 0,
                                        blurRadius: 1,
                                        offset: const Offset(1, 1),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  child: TextField(
                                    controller: fnameController,
                                    readOnly: true,
                                    enabled: true,
                                    style: const TextStyle(color: Colors.black),
                                    cursorColor: const Color(0xff7E7E7E),
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      contentPadding: EdgeInsets.all(8),
                                    ),
                                  ),
                                ),
                              ).marginOnly(top: 10, right: 10),
                            ],
                          ).marginOnly(left: 10),
                          const SizedBox(
                            height: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: 'Last Name'.TegSubText_new(),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: context.theme.colorScheme.background,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 0,
                                        blurRadius: 1,
                                        offset: const Offset(1, 1),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  child: TextField(
                                    controller: lnameController,
                                    readOnly: true,
                                    enabled: true,
                                    style: const TextStyle(color: Colors.black),
                                    cursorColor: const Color(0xff7E7E7E),
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      contentPadding: EdgeInsets.all(8),
                                      hintText: 'Enter your last name',
                                    ),
                                  ),
                                ),
                              ).marginOnly(top: 10, right: 10),
                            ],
                          ).marginOnly(left: 10),
                          const SizedBox(
                            height: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: 'Email Address'.TegSubText_new(),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: context.theme.colorScheme.background,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 0,
                                        blurRadius: 1,
                                        offset: const Offset(1, 1),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  child: TextField(
                                    controller: emailController,
                                    readOnly: true,
                                    enabled: true,
                                    style: const TextStyle(color: Colors.black),
                                    cursorColor: const Color(0xff7E7E7E),
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      contentPadding: EdgeInsets.all(8),
                                    ),
                                  ),
                                ),
                              ).marginOnly(top: 10, right: 10),
                            ],
                          ).marginOnly(left: 10),
                          const SizedBox(
                            height: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: 'Mobile Number'.TegSubText_new(),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: context.theme.colorScheme.background,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 0,
                                        blurRadius: 1,
                                        offset: const Offset(1, 1),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  child: TextField(
                                    controller: mobileController,
                                    readOnly: true,
                                    enabled: true,
                                    style: const TextStyle(color: Colors.black),
                                    cursorColor: const Color(0xff7E7E7E),
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      contentPadding: EdgeInsets.all(8),
                                    ),
                                  ),
                                ),
                              ).marginOnly(top: 10, right: 10),
                            ],
                          ).marginOnly(left: 10),
                          const SizedBox(
                            height: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: 'Country'.TegSubText_new(),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: context.theme.colorScheme.background,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 0,
                                        blurRadius: 1,
                                        offset: const Offset(1, 1),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  child: TextField(
                                    controller: countryController,
                                    enabled: true,
                                    readOnly: true,
                                    style: const TextStyle(color: Colors.black),
                                    cursorColor: const Color(0xff7E7E7E),
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      contentPadding: EdgeInsets.all(8),
                                    ),
                                  ),
                                ),
                              ).marginOnly(top: 10, right: 10),
                            ],
                          ).marginOnly(left: 10),
                          const SizedBox(
                            height: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: 'State'.TegSubText_new(),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: context.theme.colorScheme.background,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 0,
                                        blurRadius: 1,
                                        offset: const Offset(1, 1),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  child: TextField(
                                    controller: stateController,
                                    enabled: true,
                                    readOnly: true,
                                    style: const TextStyle(color: Colors.black),
                                    cursorColor: const Color(0xff7E7E7E),
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      contentPadding: EdgeInsets.all(8),
                                    ),
                                  ),
                                ),
                              ).marginOnly(top: 10, right: 10),
                            ],
                          ).marginOnly(left: 10),
                          const SizedBox(
                            height: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: 'City'.TegSubText_new(),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: context.theme.colorScheme.background,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 0,
                                        blurRadius: 1,
                                        offset: const Offset(1, 1),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  child: TextField(
                                    controller: cityController,
                                    enabled: true,
                                    readOnly: true,
                                    style: const TextStyle(color: Colors.black),
                                    cursorColor: const Color(0xff7E7E7E),
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      contentPadding: EdgeInsets.all(8),
                                    ),
                                  ),
                                ),
                              ).marginOnly(top: 10, right: 10),
                            ],
                          ).marginOnly(left: 10),
                          const SizedBox(
                            height: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: 'Taluka'.TegSubText_new(),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: context.theme.colorScheme.background,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 0,
                                        blurRadius: 1,
                                        offset: const Offset(1, 1),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  child: TextField(
                                    controller: talukaController,
                                    enabled: true,
                                    readOnly: true,
                                    style: const TextStyle(color: Colors.black),
                                    cursorColor: const Color(0xff7E7E7E),
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      contentPadding: EdgeInsets.all(8),
                                    ),
                                  ),
                                ),
                              ).marginOnly(top: 10, right: 10),
                            ],
                          ).marginOnly(left: 10),
                          const SizedBox(
                            height: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: 'Pin Code'.TegSubText_new(),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: context.theme.colorScheme.background,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 0,
                                        blurRadius: 1,
                                        offset: const Offset(1, 1),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  child: TextField(
                                    controller: pincodeController,
                                    style: const TextStyle(color: Colors.black),
                                    keyboardType: TextInputType.number,
                                    readOnly: true,
                                    enabled: true,
                                    cursorColor: const Color(0xff7E7E7E),
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      contentPadding: EdgeInsets.all(8),
                                    ),
                                  ),
                                ),
                              ).marginOnly(top: 10, right: 10),
                            ],
                          ).marginOnly(left: 10),
                          const SizedBox(
                            height: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: 'Address'.TegSubText_new(),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: context.theme.colorScheme.background,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 0,
                                        blurRadius: 1,
                                        offset: const Offset(1, 1),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  child: TextField(
                                    controller: addressController,
                                    readOnly: true,
                                    enabled: true,
                                    style: const TextStyle(color: Colors.black),
                                    cursorColor: const Color(0xff7E7E7E),
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      contentPadding: EdgeInsets.all(8),
                                    ),
                                  ),
                                ),
                              ).marginOnly(top: 10, right: 10),
                            ],
                          ).marginOnly(left: 10),
                          const SizedBox(
                            height: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: 'Birth Date'.TegSubText_new(),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: context.theme.colorScheme.background,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 0,
                                        blurRadius: 1,
                                        offset: const Offset(1, 1),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  child: TextField(
                                    controller: bdayController,
                                    readOnly: true,
                                    enabled: true,
                                    style: const TextStyle(color: Colors.black),
                                    cursorColor: const Color(0xff7E7E7E),
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      contentPadding: EdgeInsets.all(8),
                                    ),
                                  ),
                                ),
                              ).marginOnly(top: 10, right: 10),
                            ],
                          ).marginOnly(left: 10),
                          const SizedBox(
                            height: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: 'Anniversary Date'.TegSubText_new(),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: context.theme.colorScheme.background,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 0,
                                        blurRadius: 1,
                                        offset: const Offset(1, 1),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  child: TextField(
                                    controller: anniversaryController,
                                    readOnly: true,
                                    enabled: true,
                                    style: const TextStyle(color: Colors.black),
                                    cursorColor: const Color(0xff7E7E7E),
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      contentPadding: EdgeInsets.all(8),
                                    ),
                                  ),
                                ),
                              ).marginOnly(top: 10, right: 10),
                            ],
                          ).marginOnly(left: 10),
                          const SizedBox(
                            height: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: 'Aadhaar Card Number'.TegSubText_new(),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: context.theme.colorScheme.background,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 0,
                                        blurRadius: 1,
                                        offset: const Offset(1, 1),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  child: TextField(
                                    controller: aadhaarController,
                                    readOnly: true,
                                    enabled: true,
                                    style: const TextStyle(color: Colors.black),
                                    cursorColor: const Color(0xff7E7E7E),
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      contentPadding: EdgeInsets.all(8),
                                    ),
                                  ),
                                ),
                              ).marginOnly(top: 10, right: 10),
                            ],
                          ).marginOnly(left: 10),
                          const SizedBox(
                            height: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: 'Pan Card Number'.TegSubText_new(),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: context.theme.colorScheme.background,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 0,
                                        blurRadius: 1,
                                        offset: const Offset(1, 1),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  child: TextField(
                                    controller: pancardController,
                                    readOnly: true,
                                    enabled: true,
                                    style: const TextStyle(color: Colors.black),
                                    cursorColor: const Color(0xff7E7E7E),
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      contentPadding: EdgeInsets.all(8),
                                    ),
                                  ),
                                ),
                              ).marginOnly(top: 10, right: 10),
                            ],
                          ).marginOnly(left: 10),
                          const SizedBox(
                            height: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: 'GST Number'.TegSubText_new(),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: context.theme.colorScheme.background,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 0,
                                        blurRadius: 1,
                                        offset: const Offset(1, 1),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  child: TextField(
                                    controller: gstnocontroller,
                                    readOnly: true,
                                    enabled: true,
                                    style: const TextStyle(color: Colors.black),
                                    cursorColor: const Color(0xff7E7E7E),
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      contentPadding: EdgeInsets.all(8),
                                    ),
                                  ),
                                ),
                              ).marginOnly(top: 10, right: 10),
                            ],
                          ).marginOnly(left: 10),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 5, right: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: "KYC Status".TegSubText_new(),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.amber,
                                      border: Border.all(color: Colors.amber)),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return KYCDetailPage("1");
                                        },
                                      ));
                                    },
                                    child: Text(kycstatus,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white)),
                                  ),
                                )
                              ],
                            ).marginOnly(left: 10, top: 10),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Nominee Details',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 58, 58, 59),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17),
                                ),
                                adddetails
                                    ? Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Colors.amber,
                                            border: Border.all(
                                                color: Colors.amber)),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                              builder: (context) {
                                                return AddNomineeDetails();
                                              },
                                            )).then(
                                              (value) {
                                                NetworkcallForgetprofiledetails();
                                              },
                                            );
                                          },
                                          child: Text('Add Nominee Details',
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white)),
                                        ),
                                      )
                                    : Container()
                              ],
                            ),
                          ).marginOnly(left: 10),
                          const SizedBox(
                            height: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: 'Nominee Name'.TegSubText_new(),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: context.theme.colorScheme.background,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 0,
                                        blurRadius: 1,
                                        offset: const Offset(1, 1),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  child: TextField(
                                    controller: nomineenamecontroller,
                                    readOnly: true,
                                    enabled: true,
                                    style: const TextStyle(color: Colors.black),
                                    cursorColor: const Color(0xff7E7E7E),
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      contentPadding: EdgeInsets.all(8),
                                    ),
                                  ),
                                ),
                              ).marginOnly(top: 10, right: 10),
                            ],
                          ).marginOnly(left: 10),
                          const SizedBox(
                            height: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: 'Nominee Contact'.TegSubText_new(),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: context.theme.colorScheme.background,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 0,
                                        blurRadius: 1,
                                        offset: const Offset(1, 1),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  child: TextField(
                                    controller: nomineecontactcontroller,
                                    readOnly: true,
                                    enabled: true,
                                    style: const TextStyle(color: Colors.black),
                                    cursorColor: const Color(0xff7E7E7E),
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      contentPadding: EdgeInsets.all(8),
                                    ),
                                  ),
                                ),
                              ).marginOnly(top: 10, right: 10),
                            ],
                          ).marginOnly(left: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: 'Nominee Age'.TegSubText_new(),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: context.theme.colorScheme.background,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 0,
                                        blurRadius: 1,
                                        offset: const Offset(1, 1),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  child: TextField(
                                    controller: nomineeagecontroller,
                                    readOnly: true,
                                    enabled: true,
                                    style: const TextStyle(color: Colors.black),
                                    cursorColor: const Color(0xff7E7E7E),
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      contentPadding: EdgeInsets.all(8),
                                    ),
                                  ),
                                ),
                              ).marginOnly(top: 10, right: 10),
                            ],
                          ).marginOnly(left: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child:
                                    'Relation With Customer'.TegSubText_new(),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: context.theme.colorScheme.background,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 0,
                                        blurRadius: 1,
                                        offset: const Offset(1, 1),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  child: TextField(
                                    controller: nomineerelationcontroller,
                                    readOnly: true,
                                    enabled: true,
                                    style: const TextStyle(color: Colors.black),
                                    cursorColor: const Color(0xff7E7E7E),
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      contentPadding: EdgeInsets.all(8),
                                    ),
                                  ),
                                ),
                              ).marginOnly(top: 10, right: 10),
                            ],
                          ).marginOnly(left: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: 'Nominee Address'.TegSubText_new(),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: context.theme.colorScheme.background,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 0,
                                        blurRadius: 1,
                                        offset: const Offset(1, 1),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  child: TextField(
                                    controller: nomineeaddresscontroller,
                                    readOnly: true,
                                    enabled: true,
                                    style: const TextStyle(color: Colors.black),
                                    cursorColor: const Color(0xff7E7E7E),
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      contentPadding: EdgeInsets.all(8),
                                    ),
                                  ),
                                ),
                              ).marginOnly(top: 10, right: 10),
                            ],
                          ).marginOnly(left: 10),
                        ],
                      ),
                    )
                  ]),
                ),
              ),
            )));
  }
}
