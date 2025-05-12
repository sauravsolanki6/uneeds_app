import 'package:UNGolds/constant/app_color.dart';
import 'package:UNGolds/constant/button_design.dart';
import 'package:UNGolds/constant/extension.dart';
import 'package:UNGolds/screens/login_page/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Thankyouforreferal extends StatefulWidget {
  State createState() => ThankyouforreferalState();
}

class ThankyouforreferalState extends State<Thankyouforreferal> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: context.theme.cardColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(CupertinoIcons.left_chevron)),
        elevation: 0,
        toolbarHeight: 70,
        backgroundColor: context.theme.cardColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Center(
            child: Lottie.asset(
              'assets/images/done.json',
            ),
          ),
          Text(
            'Thank You!',
            style: TextStyle(
                color: Color(0xffd4aa1e),
                fontSize: 16,
                fontWeight: FontWeight.w700),
          ),
          Text(
            'Your referral has been registed successfully. \n Please click on continue to continue your work',
            style: TextStyle(
                color: AppColor.bordercolor,
                fontSize: 10,
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ).marginOnly(top: 10, bottom: 10),
          _continuelogin(),
        ]),
      ),
    );
  }

  Widget _continuelogin() {
    return Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 8, left: 20, right: 20),
        child: ButtonDesign(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Continue ',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 16),
            )));
  }
}
