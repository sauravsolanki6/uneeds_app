import 'package:UNGolds/constant/button_design.dart';
import 'package:UNGolds/constant/extension.dart';
import 'package:UNGolds/constant/snackbardesign.dart';
import 'package:UNGolds/constant/textdesign.dart';
import 'package:UNGolds/network/response/otp_verify_response.dart';
import 'package:UNGolds/screens/login_page/sign_up_confirm.dart';
import 'package:UNGolds/screens/login_page/thank_your_for_referal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../constant/app_color.dart';
import '../../constant/printmessage.dart';
import '../../constant/progressdialog.dart';
import '../../constant/shared_pre.dart';
import '../../network/createjson.dart';
import '../../network/networkcall.dart';
import '../../network/networkutility.dart';
import 'confirm_password.dart';

late Future<bool> _checkConnection;
bool validateotp = true;
TextEditingController otpController = TextEditingController();

class OTPVerificationScreen extends StatefulWidget {
  String mobilenumber, redirectpage, isReferalName;
  int otp, tableverificationid;
  bool isreturn;
  OTPVerificationScreen(this.otp, this.mobilenumber, this.tableverificationid,
      this.redirectpage, this.isReferalName, this.isreturn);
  @override
  State createState() => OTPVerificationScreenState();
}

class OTPVerificationScreenState extends State<OTPVerificationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    otpController.clear();
    validateotp = true;
    super.dispose();
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
                  'OTP Verification'.introTitleText(context),
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
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Lottie.asset(
                  'assets/images/otpverify.json',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              // SizedBox(height: 30),

              Form(child: FormUI())
            ],
          ),
        ),
      ),
    );
  }

  Widget FormUI() {
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 0, bottom: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PinCodeTextField(
                  autoDisposeControllers: false,
                  controller: otpController,
                  cursorColor: AppColor.theamecolor,
                  length: 4,
                  onChanged: (value) {},
                  appContext: context,
                  keyboardType: TextInputType.number,
                  onCompleted: (value) {},
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 50,
                      selectedColor: Color(0xFF9c27b0),
                      activeColor: Color(0xFF9c27b0),
                      inactiveColor: Colors.grey),
                ),
                SizedBox(
                  height: 5,
                ),
                validateotp
                    ? Container()
                    : Text(
                        'Please enter valid otp',
                        style: TextDesign.errortext,
                      )
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Please Enter 4 Digit Code Send To Your Phone Number',
            style: TextStyle(
                color: AppColor.intoColor,
                fontWeight: FontWeight.w400,
                fontSize: 12),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 20,
          ),
          ButtonDesign(
              onPressed: () {
                FocusScope.of(context).unfocus();
                if (otpController.text.isEmpty) {
                  validateotp = false;
                  setState(() {});
                } else {
                  int optforverify = int.parse(otpController.text);
                  if (optforverify == widget.otp) {
                    Networkcallforotpverify();
                  } else {
                    validateotp = false;
                    setState(() {});
                  }
                }
              },
              child: 'Verify'.buttoText()),
          ButtonDesign(
              onPressed: () {
                otpController.clear();
                validateotp = true;
                setState(() {});
                FocusScope.of(context).unfocus();
                Networkcallforresendotp();
              },
              child: 'Resend OTP'.buttoText())
        ],
      ),
    );
  }

  Future<void> Networkcallforresendotp() async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading");
      String createjson = CreateJson().createjsonforresendotp(
          widget.otp, widget.mobilenumber, context, widget.tableverificationid);
      Networkcall networkcall = Networkcall();
      List<Object?>? signup = await networkcall.postMethod(
          NetworkUtility.otp_verify,
          NetworkUtility.resend_otp,
          createjson,
          context);
      if (signup != null) {
        Navigator.pop(context);
        List<Otpverifyresponse> signupresponse = List.from(signup!);
        String status = signupresponse[0].status.toString();
        switch (status) {
          case "true":
            SnackBarDesign("OTP send on register mobile number", context,
                AppColor.sucesscolor, Colors.white);
            break;
          case "false":
            SnackBarDesign(signupresponse[0].message!, context,
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
          e.toString(), 'Networkcallforotpverify', "OTP Verify", context);
    }
  }

  Future<void> Networkcallforotpverify() async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading");
      List<String> digits = otpController.text.split('');
      String createjson = CreateJson().createjsonforotpverify(
          widget.otp,
          int.parse(digits[0]),
          int.parse(digits[1]),
          int.parse(digits[2]),
          int.parse(digits[3]),
          widget.tableverificationid,
          widget.mobilenumber,
          context);
      Networkcall networkcall = Networkcall();
      List<Object?>? signup = await networkcall.postMethod(
          NetworkUtility.otp_verify,
          NetworkUtility.otp_verify_api,
          createjson,
          context);
      if (signup != null) {
        Navigator.pop(context);
        List<Otpverifyresponse> signupresponse = List.from(signup!);
        String status = signupresponse[0].status.toString();
        switch (status) {
          case "true":
            if (widget.redirectpage == "signup") {
              if (widget.isReferalName == "") {
                SharedPreference()
                    .setValueToSharedPrefernce("SignUpDone", "1", context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      settings: RouteSettings(name: 'confirm'),
                      builder: (context) => SignUpConfirm(widget.isreturn)),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Thankyouforreferal()),
                ).then((value) {
                  Navigator.pop(context);
                });
              }
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ConfirmPasswordScreen(widget.mobilenumber)),
              );
            }

            break;
          case "false":
            SnackBarDesign(signupresponse[0].message!, context,
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
          e.toString(), 'Networkcallforotpverify', "OTP Verify", context);
    }
  }
}
