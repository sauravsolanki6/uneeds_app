import 'package:UNGolds/constant/extension.dart';
// import 'package:cc_avenue/cc_avenue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../constant/app_color.dart';

class CCAvenuepayment extends StatefulWidget {
  String orderId, amount;
  CCAvenuepayment(this.orderId, this.amount);
  State createState() => CCAvenuepaymentState();
}

Future<void> initPlatformState(String amount, String orderid) async {
  // Platform messages may fail, so we use a try/catch PlatformException.
  try {
    // await CcAvenue.cCAvenueInit(
    //     transUrl: 'https://secure.ccavenue.com/transaction/initTrans',
    //     accessCode: "AVIZ38KL69AP47ZIPA",
    //     amount: amount,
    //     cancelUrl: 'http://122.182.6.216/merchant/ccavResponseHandler.jsp',
    //     currencyType: 'INR',
    //     merchantId: "3083640",
    //     orderId: orderid,
    //     redirectUrl: 'http://122.182.6.216/merchant/ccavResponseHandler.jsp',
    //     rsaKeyUrl:
    //         'https://secure.ccavenue.com/transaction/transaction.do?command=initiateTransaction');

    // await CcAvenue.cCAvenueInit(
    //     transUrl: 'https://secure.ccavenue.com/transaction/initTrans',
    //     accessCode: '4YRUXLSRO20O8NIH',
    //     amount: '10',
    //     cancelUrl: 'http://122.182.6.216/merchant/ccavResponseHandler.jsp',
    //     currencyType: 'INR',
    //     merchantId: '2',
    //     orderId: '519',
    //     redirectUrl: 'http://122.182.6.216/merchant/ccavResponseHandler.jsp',
    //     rsaKeyUrl: 'https://secure.ccavenue.com/transaction/jsp/GetRSA.jsp');
  } on PlatformException catch (e) {
    print(e.toString());
  }
}

String amount = "", orderid = "";

class CCAvenuepaymentState extends State<CCAvenuepayment> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    amount = widget.amount;
    orderid = widget.orderId;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        backgroundColor: context.theme.cardColor,
        appBar: AppBar(
          // iconTheme: IconThemeData(color: Colors.black),
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
                    'Secure Payment'.introTitleText(context),
                  ],
                ).marginOnly(top: 10),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Lottie.asset('assets/images/done.json', width: 300),
              ),
              Text(
                'Secure Payment Gateway',
                style: TextStyle(
                    color: Color(0xffd4aa1e),
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                'Experience unparalleled security with our Payment Gateway. Simplify transactions and elevate your business with seamless, encrypted payment processing.',
                style: TextStyle(
                    color: AppColor.bordercolor,
                    fontSize: 10,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ).marginOnly(top: 10, bottom: 10),
              ElevatedButton(
                  onPressed: () {
                    initPlatformState(widget.amount, widget.orderId);
                  },
                  child: Text('CCAvenue')),
              // Text("Result \n $result"),
            ],
          ),
        ),
      ),
    );
  }

  void ccavaenufuntion() {
    // try {
    //   CcAvenue.cCAvenueInit(
    //       transUrl: 'https://secure.ccavenue.com/transaction/initTrans',
    //       rsaKeyUrl: 'https://secure.ccavenue.com/transaction/jsp/GetRSA.jsp',
    //       accessCode: "AVIZ38KL69AP47ZIPA",
    //       merchantId: "3083640",
    //       orderId: widget.orderId,
    //       currencyType: 'INR',
    //       amount: widget.amount,
    //       cancelUrl: 'http://122.182.6.216/merchant/ccavResponseHandler.jsp',
    //       redirectUrl: 'http://122.182.6.216/merchant/ccavResponseHandler.jsp');
    // } catch (e) {
    //   print(e.toString());
    // }
  }
}
