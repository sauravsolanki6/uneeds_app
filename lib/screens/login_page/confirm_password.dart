import 'dart:async';

import 'package:UNGolds/constant/app_color.dart';
import 'package:UNGolds/constant/extension.dart';
import 'package:UNGolds/screens/login_page/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../constant/textdesign.dart';

//Not in use
final _confirmPasswordController = TextEditingController();
final _passwordController = TextEditingController();
bool _showPassword = false,
    _showconfirmpassword = false,
    validatenewpassword = true,
    validateconfirmpassword = true;
String errornewpassword = "", errorconfirmpassword = "";
late Future<bool> _checkConnection;

class ConfirmPasswordScreen extends StatefulWidget {
  String mobilenumber;
  ConfirmPasswordScreen(this.mobilenumber);

  @override
  State createState() => ConfirmPasswordScreenState();
}

class ConfirmPasswordScreenState extends State<ConfirmPasswordScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _checkConnection = CheckInternetConnection().hasNetwork();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _passwordController.clear();
    _confirmPasswordController.clear();
    _showPassword = false;
    _showconfirmpassword = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.cardColor,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.1),
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(CupertinoIcons.left_chevron)),
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  'Confirm Password'.introTitleText(context),
                ],
              ).marginOnly(top: 10),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 15.0, right: 15.0, top: 0, bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Lottie.asset(
                  'assets/images/confirm.json',
                ),
              ),
              Form(child: FormUI())
            ],
          ),
        ),
      ),
    );
  }

  Widget FormUI() {
    return Container(
      //  padding: EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  'New Password'.TegText(context),
                ],
              ).marginOnly(top: 30, bottom: 5),
              Container(
                decoration: BoxDecoration(
                    color: context.theme.colorScheme.background,
                    borderRadius: BorderRadius.circular(10)),
                //  margin: EdgeInsets.only(left: 15),
                child: Container(
                  margin: EdgeInsets.only(left: 15),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: !_showPassword,
                    style: TextStyle(color: Colors.black),
                    cursorColor: Color(0xff7E7E7E),
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorStyle: TextDesign.errortext,
                      errorText: validatenewpassword
                          ? null
                          : 'Please enter new password',
                      hintText: 'Enter your new password',
                      hintStyle: TextDesign.hinttext,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          _togglevisibility();
                        },
                        child: Icon(
                          _showPassword
                              ? CupertinoIcons.eye
                              : CupertinoIcons.eye_slash,
                          color: AppColor.intoColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  'Confirm Password'.TegText(context),
                ],
              ).marginOnly(top: 15, bottom: 5),
              Container(
                decoration: BoxDecoration(
                    color: context.theme.colorScheme.background,
                    borderRadius: BorderRadius.circular(10)),
                //  margin: EdgeInsets.only(left: 15),
                child: Container(
                  margin: EdgeInsets.only(left: 15),
                  child: TextField(
                    controller: _confirmPasswordController,
                    style: TextStyle(color: Colors.black),
                    cursorColor: Color(0xff7E7E7E),
                    obscureText: !_showconfirmpassword,
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorStyle: TextDesign.errortext,
                      errorText: validateconfirmpassword
                          ? null
                          : 'Please enter confirm password',
                      hintText: 'Enter your confirm password',
                      hintStyle: TextDesign.hinttext,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          _confirmpasswordtogglevisibility();
                        },
                        child: Icon(
                          _showconfirmpassword
                              ? CupertinoIcons.eye
                              : CupertinoIcons.eye_slash,
                          color: AppColor.intoColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                  color: AppColor.theamecolor,
                ),
                child: InkWell(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    String _ConfirmPassword = _confirmPasswordController.text;
                    String _Password = _passwordController.text;
                    String? validation =
                        _validateInputs(_ConfirmPassword, _Password);

                    if (validation == "abc") {
                    } else {
                      //ShowConfirmationDialog(context);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Continue',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
              )
            ],
          ).marginOnly(top: 15),
        ],
      ),
    );
  }

  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _confirmpasswordtogglevisibility() {
    setState(() {
      _showconfirmpassword = !_showconfirmpassword;
    });
  }

  String? _validateInputs(String ConfirmPassword, String Password) {
    if (Password.isEmpty && ConfirmPassword.isEmpty) {
      validatenewpassword = false;
      validateconfirmpassword = false;
      errornewpassword = "Please enter new password";
      errorconfirmpassword = "Please enter confirm password";
      setState(() {});
      return 'abc';
    } else if (Password.isEmpty) {
      validatenewpassword = false;
      validateconfirmpassword = true;
      errornewpassword = "Please enter new password";
      setState(() {});
      return 'abc';
    } else if (ConfirmPassword.isEmpty) {
      validatenewpassword = true;
      validateconfirmpassword = false;
      errorconfirmpassword = "Please enter confirm password";
      setState(() {});
      return 'abc';
    } else if (ConfirmPassword != Password) {
      validatenewpassword = false;
      validateconfirmpassword = false;
      errornewpassword = "New password and confirm password must be same";
      errorconfirmpassword = "New password and confirm password must be same";
      setState(() {});
      return 'abc';
    } else {
      validatenewpassword = true;
      validateconfirmpassword = true;
      errornewpassword = "";
      errorconfirmpassword = "";
      setState(() {});
      return null;
    }
  }

  // ShowConfirmationDialog(BuildContext context1) {
  //   showDialog(
  //     context: context1,
  //     builder: (context1) {
  //       return AlertDialogDesign(
  //           yesbuttonPressed: () {
  //             Navigator.pop(context1);

  //             NetworkCallForUpdatepassword();
  //           },
  //           nobuttonPressed: () {
  //             Navigator.pop(context1);
  //           },
  //           title: AppUtility.confirmationTitle,
  //           description: 'Are you sure? You want to create new password?');
  //     },
  //   );
  // }

  // NetworkCallForUpdatepassword() async {
  //   try {
  //     ProgressDialog.showProgressDialog(context, "Loading...");
  //     String createjson = CreateJson().createJsonForUpdatepassword(
  //         widget.mobilenumber, _confirmPasswordController.text);
  //     if (await _checkConnection) {
  //       NetworkResponse networkResponse = NetworkResponse();
  //       List<Object?>? list = await networkResponse.postMethod(
  //           NetworkUtility.update_password,
  //           NetworkUtility.update_password_api,
  //           createjson);
  //       if (list != null) {
  //         List<Updatepasswordresponse> response = List.from(list!);
  //         String status = response[0].status!;
  //         switch (status) {
  //           case "true":
  //             Navigator.pop(context);
  //             SnackBarDesign(
  //                 response[0].errorContent!,
  //                 context,
  //                 ColorFile().sucessmessagebcColor,
  //                 ColorFile().sucessmessagetxColor);
  //             Navigator.push(
  //               context,
  //               MaterialPageRoute(builder: (context) => DonePageScreen()),
  //             );
  //             break;
  //           case "false":
  //             Navigator.pop(context);
  //             SnackBarDesign(
  //                 response[0].errorContent!,
  //                 context,
  //                 ColorFile().errormessagebcColor,
  //                 ColorFile().errormessagetxColor);
  //             break;
  //         }
  //       } else {
  //         Navigator.pop(context);
  //       }
  //     }
  //   } catch (e) {
  //     PrintMessage.printmessage(
  //         e.toString(), 'NetworkCallForGetOTP', 'Forgot password screen');
  //   }
  // }
}
