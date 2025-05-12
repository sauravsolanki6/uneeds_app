import 'package:UNGolds/constant/button_design.dart';
import 'package:UNGolds/constant/drawer_design.dart';
import 'package:UNGolds/constant/printmessage.dart';
import 'package:UNGolds/constant/progressdialog.dart';
import 'package:UNGolds/constant/snackbardesign.dart';
import 'package:UNGolds/constant/utility.dart';
import 'package:UNGolds/network/createjson.dart';
import 'package:UNGolds/network/networkcall.dart';
import 'package:UNGolds/network/networkutility.dart';
import 'package:UNGolds/network/response/change_password_response.dart';
import 'package:UNGolds/screens/login_page/forgotpassword_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../constant/app_assets.dart';
import '../../constant/extension.dart';
import '../../constant/app_color.dart';
import '../../constant/show_confirmation_dialog.dart';
import '../../constant/textdesign.dart';

bool _showPassword = false,
    _showconfirmpassword = false,
    _showCurrentpassword = false,
    validatenewpassword = true,
    validateconfirmpassword = true,
    validatecurrentpassword = true;
String errornewpassword = "",
    errorconfirmpassword = "Please enter confirm password",
    errorcurrentpassword = "";

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  bool _submitClicked = false;
  void _handleSubmit() {
    setState(() {
      _submitClicked = true;
    });

    // Perform validation or other actions here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: CommonDrawer(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
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
                  'Change Password'.introTitleText(context),
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
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/images/bg.png'), // Replace 'assets/background_image.jpg' with your image path
              fit: BoxFit.cover, //
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Center(
                    child: SvgPicture.asset(
                      AppAssets.changepass,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                margin: EdgeInsets.only(left: 25, right: 25),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        'Current Password *'.TegText(context),
                      ],
                    ).marginOnly(left: 15, top: 10),
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: TextField(
                        obscureText: !_showCurrentpassword,
                        controller: currentPassword,
                        cursorColor: Color(0xff7E7E7E),
                        style: TextStyle(color: Colors.black),
                        onChanged: (value) {
                          if (value.length > 0) {
                            if (value == AppUtility.Password) {
                              validatecurrentpassword = true;
                              setState(() {});
                            } else {
                              validatecurrentpassword = false;
                              errorcurrentpassword =
                                  "Password did not matched with old password";
                              setState(() {});
                            }
                          } else {
                            validatecurrentpassword = true;
                            setState(() {});
                          }
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none),
                          contentPadding: EdgeInsets.all(8),
                          hintText: 'Enter current password',
                          errorStyle: TextDesign.errortext,
                          errorText: validatecurrentpassword
                              ? null
                              : errorcurrentpassword,
                          hintStyle: TextStyle(color: Color(0xff7E7E7E)),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              _currentpasswordstogglevisibility();
                            },
                            child: Icon(
                              _showCurrentpassword
                                  ? CupertinoIcons.eye_slash
                                  : CupertinoIcons.eye,
                              color: AppColor.intoColor,
                            ),
                          ),
                        ),
                      ),
                    ).marginOnly(top: 10, right: 20, bottom: 10),
                    Row(
                      children: [
                        'New Password *'.TegText(context),
                      ],
                    ).marginOnly(left: 15, top: 20),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      margin: EdgeInsets.only(left: 15),
                      child: TextField(
                        controller: newPassword,
                        obscureText: !_showPassword,
                        style: TextStyle(color: Colors.black),
                        cursorColor: Color(0xff7E7E7E),
                        onChanged: (value) {
                          validatenewpassword = true;
                          validateconfirmpassword = true;
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none),
                          contentPadding: EdgeInsets.all(8),
                          hintText: 'Enter new password',
                          errorStyle: TextDesign.errortext,
                          errorText:
                              validatenewpassword ? null : errornewpassword,
                          hintStyle: TextStyle(color: Color(0xff7E7E7E)),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              _togglevisibility();
                            },
                            child: Icon(
                              _showPassword
                                  ? CupertinoIcons.eye_slash
                                  : CupertinoIcons.eye,
                              color: AppColor.intoColor,
                            ),
                          ),
                        ),
                      ),
                    ).marginOnly(top: 10, right: 20, bottom: 10),
                    Row(
                      children: [
                        'Confirm New Password *'.TegText(context),
                      ],
                    ).marginOnly(left: 15, top: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: EdgeInsets.only(left: 15),
                      child: TextField(
                        controller: confirmNewPassword,
                        obscureText: !_showconfirmpassword,
                        cursorColor: Color(0xff7E7E7E),
                        onChanged: (value) {
                          validateconfirmpassword = true;
                          validatenewpassword = true;
                          setState(() {});
                        },
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none),
                          contentPadding: EdgeInsets.all(8),
                          hintText: 'Enter confirm password',
                          errorStyle: TextDesign.errortext,
                          errorText: validateconfirmpassword
                              ? null
                              : errorconfirmpassword,
                          hintStyle: TextStyle(color: Color(0xff7E7E7E)),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              _confirmpasswordtogglevisibility();
                            },
                            child: Icon(
                              _showconfirmpassword
                                  ? CupertinoIcons.eye_slash
                                  : CupertinoIcons.eye,
                              color: AppColor.intoColor,
                            ),
                          ),
                        ),
                      ),
                    ).marginOnly(top: 10, right: 20, bottom: 10),
                    Container(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: ButtonDesign(
                          onPressed: () {
                            _handleSubmit();
                            FocusScope.of(context).unfocus();
                            String _ConfirmPassword = confirmNewPassword.text;
                            String _Password = newPassword.text;
                            String _currentpassword = currentPassword.text;
                            String? validation = _validateInputs(
                                _ConfirmPassword, _Password, _currentpassword);
                            if (validation == null) {
                              Showconfirmatondialog();
                            }
                          },
                          child: 'Update Password'.buttoText()),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmNewPassword = TextEditingController();
  void _currentpasswordstogglevisibility() {
    setState(() {
      _showCurrentpassword = !_showCurrentpassword;
    });
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

  String? _validateInputs(
      String ConfirmPassword, String Password, String currentpassword) {
    validatenewpassword = true;
    validateconfirmpassword = true;
    validatecurrentpassword = true;
    errornewpassword = "Please enter new password";
    errorconfirmpassword = "Please enter confirm password";
    errorcurrentpassword = "Please enter current password";
    if (Password.isEmpty &&
        ConfirmPassword.isEmpty &&
        currentpassword.isEmpty) {
      validatenewpassword = false;
      validateconfirmpassword = false;
      validatecurrentpassword = false;
      errornewpassword = "Please enter new password";
      errorconfirmpassword = "Please enter confirm password";
      errorcurrentpassword = "Please enter current password";
      setState(() {});
      return 'abc';
    } else if (currentpassword.isEmpty) {
      validatecurrentpassword = false;
      setState(() {});
      return 'abc';
    } else if (Password.isEmpty) {
      validatenewpassword = false;
      setState(() {});
      return 'abc';
    } else if (ConfirmPassword.isEmpty) {
      validateconfirmpassword = false;
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
      errornewpassword = "";
      errorconfirmpassword = "";
      setState(() {});
      return null;
    }
  }

  Showconfirmatondialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialogDesign(
            description: "Are you sure? You want to change password? ",
            nobuttonPressed: () {
              Navigator.pop(context);
            },
            yesbuttonPressed: () {
              Navigator.pop(context);
              Networkcallforchangepassword();
            },
            title: "Confirmation",
          );
        });
  }

  Future<void> Networkcallforchangepassword() async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading...");
      String createjson = CreateJson().createjsonforchangepassword(
          context, AppUtility.ID, confirmNewPassword.text);
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.change_password,
          NetworkUtility.change_password_api,
          createjson,
          context);
      if (list != null) {
        Navigator.pop(context);
        List<Changepasswordresponse> response = List.from(list!);
        String status = response[0].status!;
        switch (status) {
          case "true":
            SnackBarDesign('Password changed successfully!', context,
                AppColor.sucesscolor, Colors.white);
            Navigator.pop(context);
            break;
          case "false":
            SnackBarDesign('Unable to change password', context,
                AppColor.errorcolor, Colors.white);
            break;
        }
      } else {
        Navigator.pop(context);
        SnackBarDesign('Something went wrong!', context, AppColor.errorcolor,
            Colors.white);
      }
    } catch (e) {
      PrintMessage.printmessage(e.toString(), 'Networkcallforchangepassword',
          'Change Password', context);
    }
  }
}
