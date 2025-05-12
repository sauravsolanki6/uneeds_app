import 'package:UNGolds/bottomnavigationwithoutlogin.dart';
import 'package:UNGolds/constant/button_design.dart';
import 'package:UNGolds/constant/shared_pre.dart';
import 'package:UNGolds/constant/snackbardesign.dart';
import 'package:UNGolds/constant/utility.dart';
import 'package:UNGolds/network/response/login_response.dart';
import 'package:UNGolds/screens/Splashscreen/Splash_Screen.dart';
import 'package:UNGolds/screens/login_page/forgotpassword_page.dart';
import 'package:UNGolds/screens/profile_page/profile_onward.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../constant/extension.dart';
import '../../constant/app_color.dart';
import '../../constant/printmessage.dart';
import '../../constant/progressdialog.dart';
import '../../constant/textdesign.dart';
import '../../dbhelper.dart';
import '../../network/createjson.dart';
import '../../network/networkcall.dart';
import '../../network/networkutility.dart';
import '../bottom_navigation_bar.dart';
import '../sign_up/sign_up.dart';

bool validatemobile = true, validatepassword = true, _showPassword = false;

class LoginPage extends StatefulWidget {
  bool isreturn;
  LoginPage(this.isreturn);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    validatemobile = true;
    validatepassword = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          true, // Set to false if you want to handle resizing manually
      body: SafeArea(
          child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/bg.png'), // Replace 'assets/background_image.jpg' with your image path
            fit: BoxFit.cover, //
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Lottie.asset('assets/images/login2.json',
                      width: 350,
                      height: MediaQuery.of(context).size.height / 3),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 8),
                margin: EdgeInsets.only(left: 25, right: 25),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(
                            color: Color.fromARGB(255, 59, 59, 59),
                            fontWeight: FontWeight.w700,
                            fontSize: 24),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      'Mobile Number *'.TegText(context),
                    ],
                  ).marginOnly(left: 22, top: 10),
                  TextField(
                    controller: loginmobileController,
                    style: TextStyle(color: Colors.black),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                    ],
                    maxLength: 10, // Limit the length to 10 characters
                    cursorColor: Color(0xff7E7E7E),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none),
                      hintText: 'Enter your mobile number',
                      // labelText: 'Mobile Number',
                      contentPadding: EdgeInsets.all(8),
                      errorText:
                          validatemobile ? null : 'Please enter mobile number',
                      errorStyle: TextDesign.errortext,
                    ),
                  ).marginOnly(top: 5, left: 20, right: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      'Password *'.TegText(context),
                    ],
                  ).marginOnly(left: 22, top: 10),
                  TextField(
                    controller: loginpasswordController,
                    style: TextStyle(color: Colors.black),
                    obscureText: !_showPassword,
                    cursorColor: Color(0xff7E7E7E),
                    onChanged: (value) {
                      validatepassword = true;
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.all(8),
                      errorStyle: TextDesign.errortext,
                      errorText:
                          validatepassword ? null : 'Please enter password',
                      hintText: 'Enter your password',
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
                  ).marginOnly(top: 5, left: 20, right: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return ForgotPassword();
                            },
                          ));
                        },
                        child: Container(
                            child: Text(
                          'Forgot password ?',
                          style: TextStyle(
                              color: AppColor.bordercolor,
                              fontWeight: FontWeight.w600,
                              fontSize: 10),
                          textAlign: TextAlign.center,
                        )).marginOnly(right: 20),
                      )
                    ],
                  ).marginOnly(top: 10),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 20),
                    child: ButtonDesign(
                        onPressed: () {
                          if (loginmobileController.text.isEmpty &&
                              loginpasswordController.text.isEmpty) {
                            validatemobile = false;
                            validatepassword = false;
                            setState(() {});
                          } else if (loginmobileController.text.isEmpty) {
                            validatemobile = false;
                            validatepassword = true;
                            setState(() {});
                          } else if (loginpasswordController.text.isEmpty) {
                            validatemobile = true;
                            validatepassword = false;
                            setState(() {});
                          } else {
                            Networkcallforlogin();
                          }
                        },
                        child: 'Login'.buttoText()),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 20),
                    child: ButtonDesign(
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return BottomNavigationWithoutLogin();
                            },
                          ));
                        },
                        child: 'SKIP'.buttoText()),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            settings: RouteSettings(name: 'signup'),
                            builder: (context) {
                              return SignUp("", "", widget.isreturn);
                            },
                          ));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        'Don’t have an account yet?  '.TegSubText(),
                        Text(
                          'Register Now',
                          style: TextStyle(
                              color: AppColor.bordercolor,
                              fontWeight: FontWeight.w600,
                              fontSize: 10),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ]),
              ),
            ],
          ),
        ),
      )),
    );
  }

  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  TextEditingController loginmobileController = TextEditingController();
  TextEditingController loginpasswordController = TextEditingController();

  Future<void> Networkcallforlogin() async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading");
      String createjson = CreateJson().createjsonforlogin(
          loginmobileController.text, loginpasswordController.text, context);
      Networkcall networkcall = Networkcall();
      List<Object?>? signup = await networkcall.postMethod(
          NetworkUtility.login, NetworkUtility.login_api, createjson, context);
      if (signup != null) {
        Navigator.pop(context);
        List<Loginresponse> loginresponse = List.from(signup!);
        String status = loginresponse[0].status.toString();
        switch (status) {
          case "true":
            if (loginresponse[0].data != null) {
              AppUtility.ID = loginresponse[0].data!.id!;
              AppUtility.NAME = loginresponse[0].data!.firstName! +
                  ' ' +
                  loginresponse[0].data!.lastName!;
              AppUtility.MobileNumber = loginresponse[0].data!.mobile!;
              updateSecondValue(loginresponse[0].data!.mobile!);
              SharedPreference().savevalueonlogin(
                  AppUtility.ID,
                  AppUtility.NAME,
                  AppUtility.MobileNumber,
                  loginpasswordController.text,
                  context);
              setState(() {});
              SnackBarDesign("Login successfully!", context,
                  AppColor.sucesscolor, Colors.white);
              if (loginresponse[0].data!.attepmt == "0") {
                if (widget.isreturn) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return OnWardProfile(
                            loginresponse[0].data!.id!, widget.isreturn);
                      },
                    ),
                    (Route<dynamic> route) {
                      return route.settings.name == 'checkout' || route.isFirst;
                    },
                  );
                } else {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return OnWardProfile(
                          loginresponse[0].data!.id!, widget.isreturn);
                    },
                  ));
                }
              } else {
                widget.isreturn
                    ? Navigator.pop(context)
                    : Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return BottomNavigationBarPage();
                        },
                      ));
              }
            } else {
              //Empty data
              SnackBarDesign(loginresponse[0].message!, context,
                  AppColor.errorcolor, Colors.white);
            }
            break;
          case "false":
            SnackBarDesign(loginresponse[0].message!, context,
                AppColor.errorcolor, Colors.white);
            break;
        }
      } else {
        SnackBarDesign("Something went wrong!", context, AppColor.errorcolor,
            Colors.white);
        Navigator.pop(context);
      }
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), 'Networkcallforlogin', "Login Netwo", context);
    }
  }
}
