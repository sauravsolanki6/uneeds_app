import 'package:UNGolds/constant/button_design.dart';
import 'package:UNGolds/constant/extension.dart';
import 'package:UNGolds/constant/snackbardesign.dart';
import 'package:UNGolds/constant/textdesign.dart';
import 'package:UNGolds/network/response/forgot_password_response.dart';
import 'package:UNGolds/screens/login_page/login_page.dart';
import 'package:UNGolds/screens/login_page/otp_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../constant/app_color.dart';
import '../../constant/printmessage.dart';
import '../../constant/progressdialog.dart';
import '../../constant/show_confirmation_dialog.dart';
import '../../network/createjson.dart';
import '../../network/networkcall.dart';
import '../../network/networkutility.dart';

bool val = true, validatemobile = true;
final mobileController = TextEditingController();

class ForgotPassword extends StatefulWidget {
  State createState() => ForgotPasswordState();
}

class ForgotPasswordState extends State<ForgotPassword> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    mobileController.clear();
    validatemobile = true;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // appBar: AppBar(
      //   backgroundColor: Colors.white.withOpacity(0.1),
      //   iconTheme: IconThemeData(color: Colors.black),
      //   leading: IconButton(
      //       onPressed: () {
      //         Navigator.pop(context);
      //       },
      //       icon: Icon(CupertinoIcons.left_chevron)),
      //   elevation: 0.0,
      //   title: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       GestureDetector(
      //         onTap: () {},
      //         child: Row(
      //           children: [
      //             'Forgot Password'.introTitleText(context),
      //           ],
      //         ).marginOnly(top: 10),
      //       ),
      //     ],
      //   ),
      // ),

      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/bg.png'), // Replace 'assets/background_image.jpg' with your image path
                fit: BoxFit.cover, //
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Center(
                          child: Lottie.asset('assets/images/forgot.json',
                              width: 250),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 15, left: 15, right: 15, bottom: 15),
                      margin: EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.1),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Forgot Your Password?',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: AppColor.bordercolor),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Enter your register number, we will send you confirmation code',
                            style: TextStyle(
                                color: AppColor.bordercolor,
                                fontWeight: FontWeight.w400,
                                fontSize: 12),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              'Mobile Number *'.TegText(context),
                            ],
                          ).marginOnly(top: 10, bottom: 5),
                          TextField(
                            controller: mobileController,
                            cursorColor: Color(0xff7E7E7E),
                            style: TextStyle(color: Colors.black),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                            ],
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.all(8),
                                errorText: validatemobile
                                    ? null
                                    : 'Please enter register mobile number',
                                errorStyle: TextDesign.errortext,
                                hintText: 'Enter register mobile number',
                                hintStyle: TextDesign.hinttext),
                          ),
                          ButtonDesign(
                              onPressed: () {
                                if (mobileController.text.trim().isEmpty) {
                                  validatemobile = false;
                                  setState(() {});
                                } else {
                                  validatemobile = true;
                                  setState(() {});
                                  Showconfirmatondialog();
                                }
                              },
                              child: 'Forgot Password'.buttoText())
                        ],
                      ),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Showconfirmatondialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialogDesign(
            description: "Are you sure? You required login details? ",
            nobuttonPressed: () {
              Navigator.pop(context);
            },
            yesbuttonPressed: () {
              Navigator.pop(context);
              Networkcallforforgotpassword();
            },
            title: "Confirmation",
          );
        });
  }

  Future<void> Networkcallforforgotpassword() async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading");
      String createjson = CreateJson()
          .createjsonforforgotpassword(mobileController.text, context);
      Networkcall networkcall = Networkcall();
      List<Object?>? signup = await networkcall.postMethod(
          NetworkUtility.forgot_password,
          NetworkUtility.forgot_password_api,
          createjson,
          context);
      if (signup != null) {
        Navigator.pop(context);
        List<Forgotpasswordresponse> loginresponse = List.from(signup!);
        String status = loginresponse[0].status.toString();
        switch (status) {
          case "true":
            FocusScope.of(context).unfocus();
            SnackBarDesign(
                "Your username & password has been send on your register mobile number successfully",
                context,
                AppColor.greencolor,
                Colors.white);
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return LoginPage(false);
              },
            ));

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
          e.toString(), 'Networkcallforlogin', "OTP Verify", context);
    }
  }
}
