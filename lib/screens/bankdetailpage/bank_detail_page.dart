import 'dart:io';

import 'package:UNGolds/constant/button_design.dart';
import 'package:UNGolds/constant/drawer_design.dart';
import 'package:UNGolds/constant/extension.dart';
import 'package:UNGolds/constant/progressdialog.dart';
import 'package:UNGolds/network/response/submit_bank_response.dart';
import 'package:UNGolds/screens/bankdetailpage/detail_image.dart';
import 'package:UNGolds/screens/homepage/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
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
import '../../network/response/bank_details_response.dart';
import '../../network/response/get_state_response.dart';
import '../bottom_navigation_bar.dart';

TextEditingController banknamecontroller = TextEditingController();
TextEditingController accountnumbercontroller = TextEditingController();
TextEditingController ifsccontroller = TextEditingController();
TextEditingController upiidcontroller = TextEditingController();
TextEditingController branchnamecontroller = TextEditingController();
TextEditingController micrnumbercontroller = TextEditingController();
TextEditingController accounttypecontroller = TextEditingController();
TextEditingController filenamecontroller = TextEditingController();
bool validatebankname = true,
    validateaccountnumber = true,
    validateaccounttype = true,
    validateifsccode = true;
String filename = "No file selected";

class BankDetailPage extends StatefulWidget {
  int index;
  List<BankdetailresponseDatum> accountdetails;
  BankDetailPage(this.index, this.accountdetails);
  State createState() => BankDetailPageState();
}

class BankDetailPageState extends State<BankDetailPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    banknamecontroller.text = widget.accountdetails[widget.index].bankName!;
    accountnumbercontroller.text =
        widget.accountdetails[widget.index].accountNumber!;
    ifsccontroller.text = widget.accountdetails[widget.index].ifscCode!;
    String accounttypecode = widget.accountdetails[widget.index].accountType!;
    if (accounttypecode == "0") {
      accounttypecontroller.text = "Saving Account";
    } else if (accounttypecode == "1") {
      accounttypecontroller.text = "Salary Account";
    } else if (accounttypecode == "2") {
      accounttypecontroller.text = "Current Account";
    } else if (accounttypecode == "3") {
      accounttypecontroller.text = "Fixed Deposite Account";
    } else if (accounttypecode == "4") {
      accounttypecontroller.text = "Recurring Deposite Account";
    } else if (accounttypecode == "5") {
      accounttypecontroller.text = "NRI Account";
    }
    if (widget.accountdetails[widget.index].upiId == null) {
      upiidcontroller.text = "No upi id";
    } else {
      upiidcontroller.text = widget.accountdetails[widget.index].upiId!;
    }
    if (widget.accountdetails[widget.index].branchName == null) {
      branchnamecontroller.text = "No branch name";
    } else {
      branchnamecontroller.text =
          widget.accountdetails[widget.index].branchName!;
    }
    if (widget.accountdetails[widget.index].micrNumber == null) {
      micrnumbercontroller.text = "No MICR number";
    } else {
      micrnumbercontroller.text =
          widget.accountdetails[widget.index].micrNumber!;
    }
    if (widget.accountdetails[widget.index].scanerPhoto == null ||
        widget.accountdetails[widget.index].scanerPhoto == "") {
      filename = "No file added";
      filenamecontroller.text = "No scanner photo added";
    } else {
      filename = widget.accountdetails[widget.index].scanerPhoto!;
    }
    // filename =
    //     "aqwszxcderfcvgtyhbnjuikmloplkjhfdsrdfsdfhdgfjsdhgfjhzsdgzfhgdjgfzhjsdfhzsdghf";
    setState(() {});
  }

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
    accounttypecontroller.clear();
    filename = "";
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
                  'Bank Details'.introTitleText(context),
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
                  color: Colors.red, fontWeight: FontWeight.w400, fontSize: 14),
            )
          ],
        ).marginOnly(top: 20),
        Container(
          decoration: BoxDecoration(
              color: context.theme.colorScheme.background,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 0,
                  blurRadius: 1,
                  offset: Offset(0, 0),
                ),
              ],
              borderRadius: BorderRadius.circular(10)),
          // margin: EdgeInsets.only(left: 5),
          child: Container(
            margin: EdgeInsets.only(left: 5),
            child: TextField(
              readOnly: true,
              enabled: true,
              controller: banknamecontroller,
              style: TextStyle(color: Colors.black),
              cursorColor: Color(0xff7E7E7E),
              decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.all(8),
                  hintText: 'Enter your bank name',
                  errorText:
                      validatebankname ? null : 'Please enter your bank name',
                  errorStyle: TextDesign.errortext,
                  hintStyle: TextDesign.hinttext),
            ),
          ),
        ).marginOnly(
          top: 10,
        ),
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
                  color: Colors.red, fontWeight: FontWeight.w400, fontSize: 14),
            )
          ],
        ).marginOnly(top: 20),
        Container(
          decoration: BoxDecoration(
              color: context.theme.colorScheme.background,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 0,
                  blurRadius: 1,
                  offset: Offset(0, 0),
                ),
              ],
              borderRadius: BorderRadius.circular(10)),
          // margin: EdgeInsets.only(left: 5),
          child: Container(
            margin: EdgeInsets.only(left: 5),
            child: TextField(
              controller: accountnumbercontroller,
              readOnly: true,
              enabled: true,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("[0-9]"))
              ],
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.black),
              cursorColor: Color(0xff7E7E7E),
              decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.all(8),
                  hintText: 'Enter your account number',
                  errorText: validateaccountnumber
                      ? null
                      : 'Please enter your account number',
                  errorStyle: TextDesign.errortext,
                  hintStyle: TextDesign.hinttext),
            ),
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
                  color: Colors.red, fontWeight: FontWeight.w400, fontSize: 14),
            )
          ],
        ).marginOnly(top: 20),
        Container(
          decoration: BoxDecoration(
              color: context.theme.colorScheme.background,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 0,
                  blurRadius: 1,
                  offset: Offset(0, 0),
                ),
              ],
              borderRadius: BorderRadius.circular(10)),
          // margin: EdgeInsets.only(left: 5),
          child: Container(
            margin: EdgeInsets.only(left: 5),
            child: TextField(
              readOnly: true,
              enabled: true,
              controller: ifsccontroller,
              style: TextStyle(color: Colors.black),
              cursorColor: Color(0xff7E7E7E),
              decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.all(8),
                  hintText: 'Enter your IFSC Code',
                  errorText:
                      validateifsccode ? null : 'Please enter your IFSC code',
                  errorStyle: TextDesign.errortext,
                  hintStyle: TextDesign.hinttext),
            ),
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
        ).marginOnly(top: 20),
        Container(
          decoration: BoxDecoration(
              color: context.theme.colorScheme.background,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 0,
                  blurRadius: 1,
                  offset: Offset(0, 0),
                ),
              ],
              borderRadius: BorderRadius.circular(10)),
          // margin: EdgeInsets.only(left: 5),
          child: Container(
            margin: EdgeInsets.only(left: 5),
            child: TextField(
              readOnly: true,
              enabled: true,
              controller: upiidcontroller,
              style: TextStyle(color: Colors.black),
              cursorColor: Color(0xff7E7E7E),
              decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.all(8),
                  hintText: 'Enter UPI id',
                  errorText: validatebankname ? null : 'Please enter UPI id',
                  errorStyle: TextDesign.errortext,
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
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 0,
                  blurRadius: 1,
                  offset: Offset(0, 0),
                ),
              ],
              borderRadius: BorderRadius.circular(10)),
          // margin: EdgeInsets.only(left: 5),
          child: Container(
            margin: EdgeInsets.only(left: 5),
            child: TextField(
              readOnly: true,
              enabled: true,
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
                  color: Colors.red, fontWeight: FontWeight.w400, fontSize: 14),
            )
          ],
        ).marginOnly(top: 20),
        Container(
          decoration: BoxDecoration(
              color: context.theme.colorScheme.background,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 0,
                  blurRadius: 1,
                  offset: Offset(0, 0),
                ),
              ],
              borderRadius: BorderRadius.circular(10)),
          // margin: EdgeInsets.only(left: 5),
          child: Container(
            margin: EdgeInsets.only(left: 5),
            child: TextField(
              readOnly: true,
              enabled: true,
              controller: accounttypecontroller,
              style: TextStyle(color: Colors.black),
              cursorColor: Color(0xff7E7E7E),
              decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.all(8),
                  hintText: 'Enter your account type',
                  errorText: validateifsccode
                      ? null
                      : 'Please enter your account type',
                  errorStyle: TextDesign.errortext,
                  hintStyle: TextDesign.hinttext),
            ),
          ),
        ).marginOnly(top: 10),
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
        Container(
          decoration: BoxDecoration(
              color: context.theme.colorScheme.background,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 0,
                  blurRadius: 1,
                  offset: Offset(0, 0),
                ),
              ],
              borderRadius: BorderRadius.circular(10)),
          // margin: EdgeInsets.only(left: 5),
          child: Container(
            margin: EdgeInsets.only(left: 5),
            child: TextField(
              readOnly: true,
              enabled: true,
              controller: micrnumbercontroller,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("[0-9]"))
              ],
              style: TextStyle(color: Colors.black),
              cursorColor: Color(0xff7E7E7E),
              decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.all(8),
                  hintText: 'Enter your MICR number',
                  errorText:
                      validatebankname ? null : 'Please enter your MICR number',
                  errorStyle: TextDesign.errortext,
                  hintStyle: TextDesign.hinttext),
            ),
          ),
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
        filename == "No file added"
            ? Container(
                decoration: BoxDecoration(
                    color: context.theme.colorScheme.background,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 0,
                        blurRadius: 1,
                        offset: Offset(0, 0),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10)),
                // margin: EdgeInsets.only(left: 5),
                child: Container(
                  margin: EdgeInsets.only(left: 5),
                  child: TextField(
                    readOnly: true,
                    enabled: true,
                    controller: filenamecontroller,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                    ],
                    style: TextStyle(color: Colors.black),
                    cursorColor: Color(0xff7E7E7E),
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.all(8),
                    ),
                  ),
                ),
              ).marginOnly(top: 10)
            : Container(
                decoration: BoxDecoration(
                    color: context.theme.colorScheme.background,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 0,
                        blurRadius: 1,
                        offset: Offset(0, 0),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            filename,
                            overflow: TextOverflow.ellipsis,
                            style: TextDesign.hinttext,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: AppColor.theamecolor),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return DetailScreen(NetworkUtility.base_api +
                                    widget.accountdetails[widget.index]
                                        .imagePath!);
                              },
                            ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Show File',
                                  style: TextStyle(
                                      color: AppColor.theamecolor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
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
}
