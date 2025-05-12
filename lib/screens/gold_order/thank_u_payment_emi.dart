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
import 'package:UNGolds/network/response/emipaymentwalletresponse.dart';
import 'package:UNGolds/screens/gold_order/buygoldonemipayment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ThankuPaymentEMI extends StatefulWidget {
  double ammount;
  String orderId;
  bool _isdeductfromwallet, _ispaylateemichage;
  ThankuPaymentEMI(this.ammount, this.orderId, this._isdeductfromwallet,
      this._ispaylateemichage);
  State createState() => ThankuPaymentEMIState();
}

class ThankuPaymentEMIState extends State<ThankuPaymentEMI> {
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
            'Thank you for payment. You can continue to purchase gold',
            style: TextStyle(
                color: AppColor.bordercolor,
                fontSize: 10,
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ).marginOnly(top: 10, bottom: 10),
          ButtonDesign(
              onPressed: () {
                Navigator.pop(context);
              },
              child: 'Continue'.buttoText())
        ]),
      ),
    );
  }

  Future<void> Networkcallforupdatepayment() async {
    try {
      ProgressDialog.showProgressDialog(context, "");
      String createjosn =
          CreateJson().createjsonforwithID(AppUtility.ID, context);
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.all_amount,
          NetworkUtility.all_amount_api,
          createjosn,
          context);
      if (list != null) {
        Navigator.pop(context);
      } else {
        Navigator.pop(context);
        SnackBarDesign('Something went wrong!', context, AppColor.bordercolor,
            Colors.white);
      }
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), 'Networkcallforupdatepayment', 'Thank you', context);
    }
  }
}
