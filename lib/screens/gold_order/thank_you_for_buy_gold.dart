import 'package:UNGolds/constant/app_color.dart';
import 'package:UNGolds/constant/button_design.dart';
import 'package:UNGolds/constant/extension.dart';
import 'package:UNGolds/constant/printmessage.dart';
import 'package:UNGolds/constant/progressdialog.dart';
import 'package:UNGolds/constant/snackbardesign.dart';
import 'package:UNGolds/constant/utility.dart';
import 'package:UNGolds/network/createjson.dart';
import 'package:UNGolds/network/networkcall.dart';
import 'package:UNGolds/network/networkutility.dart';
import 'package:UNGolds/network/response/ccavenueapiresponse.dart';
import 'package:UNGolds/network/response/eNachresponse.dart';
import 'package:UNGolds/screens/gold_order/eNachsetuppage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../bottom_navigation_bar.dart';

class ThankuForBuyGold extends StatefulWidget {
  State createState() => ThankuForBuyGoldState();
}

class ThankuForBuyGoldState extends State<ThankuForBuyGold> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  'Thank You For Payment'.introTitleText(context),
                ],
              ).marginOnly(top: 10),
            ),
          ],
        ),
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
            "Payment successful! We're excited to fulfill your order. Thank you for your business!",
            style: TextStyle(
                color: AppColor.bordercolor,
                fontSize: 12,
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ).marginOnly(top: 10, bottom: 10),
          ButtonDesign(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BottomNavigationBarPage(),
                    ),
                    (route) => false);
              },
              child: 'Back Home'.buttoText())
        ]),
      ),
    );
  }
}
