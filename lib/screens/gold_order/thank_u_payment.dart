import 'package:UNGolds/constant/app_color.dart';
import 'package:UNGolds/constant/button_design.dart';
import 'package:UNGolds/constant/extension.dart';
import 'package:UNGolds/screens/gold_order/eNachsetuppage.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:weipl_checkout_flutter/weipl_checkout_flutter.dart';
import '../bottom_navigation_bar.dart';

class ThankuPayment extends StatefulWidget {
  double ammount;
  String orderId, emiorderid;
  ThankuPayment(this.ammount, this.orderId, this.emiorderid);
  State createState() => ThankuPaymentState();
}

class ThankuPaymentState extends State<ThankuPayment> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
          Text(
            "Click the eNACH button to set up automatic debit for all your future EMI payments for added convenience",
            style: TextStyle(
                color: AppColor.bordercolor,
                fontSize: 12,
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ).marginOnly(top: 10, bottom: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: ButtonDesign(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BottomNavigationBarPage(),
                          ),
                          (route) => false);
                    },
                    child: 'Back Home'.buttoText()),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: ButtonDesign(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return eNachsetuppage(widget.orderId, "EMI");
                        },
                      ));
                    },
                    child: 'eNach'.buttoText()),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
