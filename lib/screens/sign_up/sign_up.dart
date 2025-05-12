import 'package:UNGolds/constant/button_design.dart';
import 'package:UNGolds/constant/printmessage.dart';
import 'package:UNGolds/constant/progressdialog.dart';
import 'package:UNGolds/constant/show_confirmation_dialog.dart';
import 'package:UNGolds/constant/snackbardesign.dart';
import 'package:UNGolds/constant/textdesign.dart';
import 'package:UNGolds/network/createjson.dart';
import 'package:UNGolds/network/networkcall.dart';
import 'package:UNGolds/network/networkutility.dart';
import 'package:UNGolds/network/response/sign_up_response.dart';
import 'package:UNGolds/network/response/unique_field_response.dart';
import 'package:UNGolds/screens/login_page/otp_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constant/extension.dart';
import '../../constant/app_color.dart';
import '../login_page/login_page.dart';

bool validatefirstname = true,
    validatelastname = true,
    validatemail = true,
    validatemobile = true,
    validatepassword = true,
    validateaccept = true,
    validatereferal = true,
    _showPassword = false;
// String  erroremail = "Please enter email address",
//     errornumber = "Please enter mobile number",
//     errorreferal = "";
String? erroremail, errornumber, errorreferal;

final referalnameController = TextEditingController();

class SignUp extends StatefulWidget {
  String referralCode, referalName;
  bool isreturn;
  SignUp(this.referralCode, this.referalName, this.isreturn);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    referalController.text = widget.referralCode;
    referalnameController.text = widget.referalName;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    validatefirstname = true;
    validatelastname = true;
    validatemail = true;
    validatemobile = true;
    validatepassword = true;
    validateaccept = true;
    firstNameController.clear();
    lastController.clear();
    mailController.clear();
    mobilenumberController.clear();
    passwordController.clear();
    referalController.clear();
  }

  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
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
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Lottie.asset('assets/images/signup.json',
                        width: 250,
                        height: MediaQuery.of(context).size.height / 3),
                  ],
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 15, right: 15, bottom: 50, top: 50),
                  padding:
                      EdgeInsets.only(left: 5, right: 5, bottom: 15, top: 20),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Register Now',
                            style: TextStyle(
                                color: Color.fromARGB(255, 59, 59, 59),
                                fontWeight: FontWeight.w700,
                                fontSize: 24),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          'First Name *'.TegText(context),
                        ],
                      ).marginOnly(left: 22, top: 5),
                      TextField(
                        controller: firstNameController,
                        cursorColor: Color(0xff7E7E7E),
                        style: TextStyle(color: Colors.black),
                        onChanged: (value) {
                          validatefirstname = true;
                          setState(() {});
                        },
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            contentPadding: EdgeInsets.all(8),
                            errorText: validatefirstname
                                ? null
                                : "Please enter first name",
                            errorStyle: TextDesign.errortext,
                            hintText: 'Enter your first name',
                            hintStyle: TextDesign.hinttext),
                      ).marginOnly(top: 10, left: 20, right: 20),
                      Row(
                        children: [
                          'Last Name *'.TegText(context),
                        ],
                      ).marginOnly(left: 22, top: 10),
                      TextField(
                        controller: lastController,
                        cursorColor: Color(0xff7E7E7E),
                        style: TextStyle(color: Colors.black),
                        onChanged: (value) {
                          validatelastname = true;
                          setState(() {});
                        },
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            contentPadding: EdgeInsets.all(8),
                            errorText: validatelastname
                                ? null
                                : "Please enter last name",
                            errorStyle: TextDesign.errortext,
                            hintText: 'Enter your last name',
                            hintStyle: TextDesign.hinttext),
                      ).marginOnly(top: 10, left: 20, right: 20),
                      Row(
                        children: [
                          'Email *'.TegText(context),
                        ],
                      ).marginOnly(left: 22, top: 10),
                      TextField(
                        controller: mailController,
                        cursorColor: Color(0xff7E7E7E),
                        style: TextStyle(color: Colors.black),
                        onChanged: (value) {
                          if (mailController.text.isNotEmpty) {
                            if (mailController.text.isEmail == false) {
                              validatemail = false;
                              erroremail = "Please enter valid email address";
                              setState(() {});
                            } else {
                              validatemail = true;
                              setState(() {});
                            }
                          } else {
                            validatemail = true;
                            setState(() {});
                          }
                        },
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            contentPadding: EdgeInsets.all(8),
                            errorText: validatemail ? null : erroremail,
                            errorStyle: TextDesign.errortext,
                            hintText: 'Enter your email',
                            hintStyle: TextDesign.hinttext),
                        onSubmitted: (value) {
                          if (mailController.text.isEmpty ||
                              mailController.text.isEmail == false) {
                            validatemail = false;
                            erroremail = "Please enter valid email address";
                            setState(() {});
                          } else {
                            validatemail = true;

                            setState(() {});
                            NetworkcallforuniqueField(2, mailController.text,
                                NetworkUtility.unique_email_api);
                          }
                        },
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus?.requestFocus();
                        },
                      ).marginOnly(top: 10, left: 20, right: 20),
                      Row(
                        children: [
                          'Mobile Number *'.TegText(context),
                        ],
                      ).marginOnly(left: 22, top: 10),
                      TextField(
                        controller: mobilenumberController,
                        keyboardType: TextInputType.number,
                        //  maxLength: 10,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                        ],
                        cursorColor: Color(0xff7E7E7E),
                        style: TextStyle(color: Colors.black),
                        onChanged: (value) {
                          validatemobile = true;
                          setState(() {});
                        },
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            contentPadding: EdgeInsets.all(8),
                            errorText: validatemobile ? null : errornumber,
                            errorStyle: TextDesign.errortext,
                            hintText: 'Enter your mobile number',
                            hintStyle: TextDesign.hinttext),
                        onSubmitted: (value) {
                          if (mobilenumberController.text.isEmpty ||
                              mobilenumberController.text.isPhoneNumber ==
                                  false) {
                            validatemobile = false;
                            setState(() {});
                          } else {
                            validatemobile = true;
                            setState(() {});
                            NetworkcallforuniqueField(
                                1,
                                mobilenumberController.text,
                                NetworkUtility.unique_mobile_api);
                          }
                        },
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus?.requestFocus();
                        },
                      ).marginOnly(top: 10, left: 20, right: 20),
                      Row(
                        children: [
                          'Password *'.TegText(context),
                        ],
                      ).marginOnly(left: 22, top: 10),
                      TextField(
                        controller: passwordController,
                        obscureText: !_showPassword,
                        cursorColor: Color(0xff7E7E7E),
                        style: TextStyle(color: Colors.black),
                        onChanged: (value) {
                          validatepassword = true;
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          contentPadding: EdgeInsets.all(8),
                          hintText: 'Enter your password',
                          errorText:
                              validatepassword ? null : "Please enter password",
                          errorStyle: TextDesign.errortext,
                          hintStyle: TextDesign.hinttext,
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
                      ).marginOnly(top: 10, left: 20, right: 20),
                      widget.referalName == ""
                          ? Container()
                          : Row(
                              children: [
                                'Referral Name'.TegText(context),
                              ],
                            ).marginOnly(left: 22, top: 10),
                      widget.referalName == ""
                          ? Container()
                          : TextField(
                              controller: referalnameController,
                              cursorColor: Color(0xff7E7E7E),
                              keyboardType: TextInputType.number,
                              readOnly: true,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  enabled: true,
                                  hintText: 'Enter referral name',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  contentPadding: EdgeInsets.all(8),
                                  hintStyle: TextDesign.hinttext),
                              onTapOutside: (event) {
                                FocusManager.instance.primaryFocus
                                    ?.requestFocus();
                              },
                            ).marginOnly(top: 10, left: 20, right: 20),
                      Row(
                        children: [
                          'Referral code'.TegText(context),
                        ],
                      ).marginOnly(left: 22, top: 10),
                      TextField(
                        controller: referalController,
                        cursorColor: Color(0xff7E7E7E),
                        keyboardType: TextInputType.number,
                        readOnly: widget.referralCode == "" ? false : true,
                        style: TextStyle(color: Colors.black),
                        onChanged: (value) {
                          validatereferal = true;
                          setState(() {});
                        },
                        decoration: InputDecoration(
                            hintText: 'Enter referral code',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            contentPadding: EdgeInsets.all(8),
                            errorText: validatereferal ? null : errorreferal,
                            errorStyle: TextDesign.errortext,
                            hintStyle: TextDesign.hinttext),
                        onSubmitted: (value) {
                          if (referalController.text.isNotEmpty) {
                            if (referalController.text.isPhoneNumber) {
                              NetworkcallforuniqueField(
                                  3,
                                  referalController.text,
                                  NetworkUtility.unique_referal_api);
                            } else {
                              validatereferal = false;
                              errorreferal = "Please enter valid referal code";
                              setState(() {});
                            }
                          }
                        },
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus?.requestFocus();
                        },
                      ).marginOnly(top: 10, left: 20, right: 20),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Transform.scale(
                              scale: 0.8,
                              child: Checkbox(
                                  value: isCheck,
                                  checkColor: AppColor.theamecolor,
                                  activeColor: Colors.white,
                                  onChanged: (value) {
                                    setState(() {
                                      isCheck = value!;
                                      validateaccept = true;
                                    });
                                  }).marginOnly(left: 0),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  'I accept '.TegSubText(),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          _launchURL("terms-condition");
                                        },
                                        child: Text(
                                          ' Terms & Conditions ',
                                          style: TextStyle(
                                              color: Color(0xff007bff),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 10),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Text(
                                        '& ',
                                        style: TextStyle(
                                            color: AppColor.bordercolor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12),
                                        textAlign: TextAlign.center,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          _launchURL("privacy-policy");
                                        },
                                        child: Text(
                                          ' Privacy Policy *',
                                          style: TextStyle(
                                              color: Color(0xff007bff),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 10),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ).marginOnly(right: 30),
                          ]),
                      validateaccept
                          ? Container()
                          : Text(
                              "Please accept terms and conditions and privacy policy",
                              style: TextDesign.errortext,
                            ),
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 15),
                        child: ButtonDesign(
                            onPressed: () {
                              String? validate = validateField();
                              if (validate == null) {
                                Showconfirmatondialog();
                              }
                            },
                            child: "Register".buttoText()),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return LoginPage(false);
                            },
                          ));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            'Already have an account? '.TegSubText(),
                            Text(
                              ' Login Now',
                              style: TextStyle(
                                  color: AppColor.bordercolor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    String _url = NetworkUtility.base_api + url;
    //await launch(, forceWebView: true);
    await canLaunchUrl(Uri.parse(_url))
        ? await launchUrl(Uri.parse(_url))
        : throw 'Could not launch $_url';
  }

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController mobilenumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController referalController = TextEditingController();
  String? validateField() {
    setState(() {
      validatefirstname = firstNameController.text.isNotEmpty;
      validatelastname = lastController.text.isNotEmpty;
      validatemail =
          mailController.text.isNotEmpty && mailController.text.isEmail;
      validatemobile = mobilenumberController.text.isNotEmpty &&
          mobilenumberController.text.isPhoneNumber;
      validatepassword = passwordController.text.isNotEmpty;
      validateaccept = isCheck;

      erroremail = mailController.text.isEmpty
          ? "Please enter email address"
          : (mailController.text.isEmail
              ? null
              : "Please enter valid email address");

      errornumber = mobilenumberController.text.isEmpty
          ? "Please enter mobile number"
          : (mobilenumberController.text.isPhoneNumber
              ? null
              : "Please enter valid mobile number");
    });

    // Return an error message if any validation fails
    if (!validatefirstname ||
        !validatelastname ||
        !validatemail ||
        !validatemobile ||
        !validatepassword ||
        !validateaccept) {
      return "error";
    }

    // Return null if all validations pass
    return null;
  }
  // String? ValidateField() {
  //   validatefirstname = true;
  //   validatelastname = true;
  //   validatemail = true;
  //   validatemobile = true;
  //   validatepassword = true;
  //   validateaccept = true;
  //   if (firstNameController.text.isEmpty &&
  //       lastController.text.isEmpty &&
  //       mailController.text.isEmpty &&
  //       mobilenumberController.text.isEmpty &&
  //       passwordController.text.isEmpty &&
  //       isCheck == false) {
  //     validatefirstname = false;
  //     validatelastname = false;
  //     validatemail = false;
  //     validatemobile = false;
  //     validatepassword = false;
  //     validateaccept = false;
  //     setState(() {});
  //     return "error";
  //   } else if (lastController.text.isEmpty &&
  //       mailController.text.isEmpty &&
  //       mobilenumberController.text.isEmpty &&
  //       passwordController.text.isEmpty &&
  //       isCheck == false) {
  //     validatelastname = false;
  //     validatemail = false;
  //     validatemobile = false;
  //     validatepassword = false;
  //     validateaccept = false;
  //     setState(() {});
  //     return "error";
  //   } else if (mailController.text.isEmpty &&
  //       mobilenumberController.text.isEmpty &&
  //       passwordController.text.isEmpty &&
  //       isCheck == false) {
  //     validatemail = false;
  //     validatemobile = false;
  //     validatepassword = false;
  //     validateaccept = false;
  //     setState(() {});
  //     return "error";
  //   } else if (mobilenumberController.text.isEmpty &&
  //       passwordController.text.isEmpty &&
  //       isCheck == false) {
  //     validatemobile = false;
  //     validatepassword = false;
  //     validateaccept = false;
  //     setState(() {});
  //     return "error";
  //   } else if (passwordController.text.isEmpty && isCheck == false) {
  //     validatepassword = false;
  //     validateaccept = false;
  //     setState(() {});
  //     return "error";
  //   } else if (firstNameController.text.isEmpty) {
  //     validatefirstname = false;
  //     setState(() {});
  //     return "error";
  //   } else if (lastController.text.isEmpty) {
  //     validatelastname = false;
  //     setState(() {});
  //     return "error";
  //   } else if (mailController.text.isEmpty) {
  //     validatemail = false;
  //     erroremail = "Please enter email address";
  //     setState(() {});
  //     return "error";
  //   } else if (mailController.text.isEmail == false) {
  //     validatemail = false;
  //     erroremail = "Please enter valid email address";
  //     setState(() {});
  //     return "error";
  //   } else if (mobilenumberController.text.isEmpty) {
  //     validatemobile = false;
  //     setState(() {});
  //     errornumber = "Please enter mobile number";
  //     return "error";
  //   } else if (mobilenumberController.text.isPhoneNumber == false) {
  //     validatemobile = false;
  //     errornumber = "Please enter valid mobile number";
  //     setState(() {});
  //     return "error";
  //   } else if (passwordController.text.isEmpty) {
  //     validatepassword = false;
  //     setState(() {});
  //     return "error";
  //   } else if (!isCheck) {
  //     validateaccept = false;
  //     setState(() {});
  //     return "error";
  //   } else {
  //     setState(() {});
  //     return null;
  //   }
  // }

  Showconfirmatondialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialogDesign(
            description: "Are you sure? you want to register to UNG ",
            nobuttonPressed: () {
              Navigator.pop(context);
            },
            yesbuttonPressed: () {
              Navigator.pop(context);
              NetworkcallforuniqueField(1, mobilenumberController.text,
                  NetworkUtility.unique_mobile_api);
            },
            title: "Confirmation",
          );
        });
  }

  Future<void> Networkcallforsignup() async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading");
      String createjson = CreateJson().createjsonforsignup(
          firstNameController.text,
          lastController.text,
          mailController.text,
          mobilenumberController.text,
          passwordController.text,
          referalController.text,
          isCheck ? "1" : "0",
          context);
      Networkcall networkcall = Networkcall();
      List<Object?>? signup = await networkcall.postMethod(
          NetworkUtility.sign_up,
          NetworkUtility.sign_up_api,
          createjson,
          context);
      if (signup != null) {
        Navigator.pop(context);
        List<Signupresponse> signupresponse = List.from(signup!);
        String status = signupresponse[0].status.toString();
        switch (status) {
          case "true":
            String mobilenumber = signupresponse[0].data!.mobile!;
            Navigator.push(
                context,
                MaterialPageRoute(
                  settings: RouteSettings(name: 'OTP'),
                  builder: (context) {
                    return OTPVerificationScreen(
                        signupresponse[0].data!.otp!,
                        mobilenumber,
                        signupresponse[0].data!.tblUnverifiedId!,
                        "signup",
                        widget.referalName,
                        widget.isreturn);
                  },
                )).then((value) {
              if (widget.referalName == "") {
              } else {
                Navigator.pop(context);
              }
            });
            break;
          case "false":
            SnackBarDesign(signupresponse[0].message!, context,
                AppColor.errorcolor, Colors.white);
            break;
        }
      } else {
        Navigator.pop(context);
        SnackBarDesign(
            'Something went wrong', context, AppColor.errorcolor, Colors.white);
      }
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), 'Networkcallforsignup', "Sing Up", context);
    }
  }

  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  Future<void> NetworkcallforuniqueField(
      int forwhat, String value, String api) async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading");
      String createjson = "";
      if (forwhat == 1) {
        createjson =
            CreateJson().createjsonforuniquemobilenumber(value, context);
      } else if (forwhat == 2) {
        createjson = CreateJson().createjsonforuniqueemail(value, context);
      } else if (forwhat == 3) {
        createjson =
            CreateJson().createjsonforuniquereferealcode(value, context);
      }
      Networkcall networkcall = Networkcall();
      List<Object?>? unique = await networkcall.postMethod(
          NetworkUtility.unique_field, api, createjson, context);
      if (unique != null) {
        Navigator.pop(context);
        List<Uniquefieldresponse> uniqueresponse = List.from(unique!);
        String status = uniqueresponse[0].status.toString();
        switch (status) {
          case "true":
            validateField();
            break;
          case "false":
            if (forwhat == 1) {
              validatemobile = false;
              errornumber = uniqueresponse[0].message.toString();
            } else if (forwhat == 2) {
              validatemail = false;
              erroremail = uniqueresponse[0].message.toString();
            } else if (forwhat == 3) {
              validatereferal = false;
              errorreferal = uniqueresponse[0].message.toString();
            }
            setState(() {});
            break;
        }
      } else {
        Navigator.pop(context);
        SnackBarDesign(
            'Something went wrong', context, AppColor.errorcolor, Colors.white);
      }
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), 'Networkcallforuniquemobilenumber', "Sing Up", context);
    }
  }
}
