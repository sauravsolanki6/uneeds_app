import 'dart:convert';
import 'dart:io';

import 'package:UNGolds/constant/extension.dart';
import 'package:UNGolds/network/call/enachresponsecall.dart';
import 'package:UNGolds/network/response/eNachresponseresponse.dart';
import 'package:UNGolds/screens/gold_order/thank_you_for_buy_gold.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:weipl_checkout_flutter/weipl_checkout_flutter.dart';

import '../../constant/app_color.dart';
import '../../constant/button_design.dart';
import '../../constant/printmessage.dart';
import '../../constant/progressdialog.dart';
import '../../constant/utility.dart';
import '../../network/createjson.dart';
import '../../network/networkcall.dart';
import '../../network/networkutility.dart';
import '../../network/response/getenachtokenresponse.dart';
import 'dart:developer' as dev;

import 'thankyoueNachsetup.dart';

class eNachsetuppage extends StatefulWidget {
  String orderId, pagename;
  eNachsetuppage(this.orderId, this.pagename);

  @override
  _eNachsetuppageState createState() => _eNachsetuppageState();
}

class _eNachsetuppageState extends State<eNachsetuppage> {
  WeiplCheckoutFlutter wlCheckoutFlutter = WeiplCheckoutFlutter();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NetworkcallforeNachToken();
  }

  String token = "",
      token1 = "",
      startdate = "",
      enddate = "",
      custmobile = "",
      custemail = "",
      merchantId = "",
      txnId = "", //DateTime.now().millisecondsSinceEpoch.toString(),
      amounttype = "",
      frquency = "",
      emiAmount = "";
  Future<void> NetworkcallforeNachToken() async {
    try {
      ProgressDialog.showProgressDialog(context, "title");
      String cretaejsonstring = CreateJson()
          .createjsonforenachtoken(AppUtility.ID, widget.orderId, context);
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.api_generate_enach_token,
          NetworkUtility.api_generate_enach_token_url,
          cretaejsonstring,
          context);
      if (list != null) {
        Navigator.pop(context);
        List<Getenachtoakenresponse> response = List.from(list!);
        String status = response[0].status!;
        switch (status) {
          case "true":
            token = response[0].token!;
            startdate = response[0].emiStartDate!;
            enddate = response[0].emiEndDate!;
            custmobile = response[0].customerMobile!;
            custemail = response[0].customerEmail!;
            merchantId = response[0].merchantId!;
            txnId = response[0].transactionId!;
            emiAmount = response[0].emiAmount!;
            amounttype = response[0].amountType!;
            frquency = response[0].frequency!;

            generatetoken();
            setState(() {});
            break;
          case "false":
            break;
        }
      } else {
        Navigator.pop(context);
      }
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "NetworkcallforeNachToken", "ThankuPayment", context);
    }
  }

  generatetoken() {
    String abc =
        "$merchantId|$txnId|$emiAmount||${AppUtility.ID}|$custmobile|$custemail|$startdate|$enddate|$emiAmount|M|$frquency|||||3101716022AKDUHN";
    var bytes = utf8.encode(abc); // Convert the input to bytes
    var digest = sha256.convert(bytes);
    token = digest.toString();
    token1 = digest.toString();
    dev.log(token1);
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
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
                    'eNach Setup'.introTitleText(context),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/enach.png',
                    height: 100,
                    width: 100,
                  ),
                ),
                Text(
                  "Please click on the eNACH setup button to conveniently, process for all future EMI payments through automatic debit.",
                  style: TextStyle(
                      color: AppColor.bordercolor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ).marginOnly(top: 10, bottom: 10),
                ButtonDesign(
                    onPressed: () {
                      // Networkcallforgetenachdata(
                      //     widget.orderId, widget.emiorderid);
                      eNachfuntion();
                    },
                    child: 'eNach SETUP'.buttoText()),
              ]),
        ),
      ),
    );
  }

  eNachfuntion() {
    String deviceID = ""; // initialize variable

    if (Platform.isAndroid) {
      deviceID =
          "AndroidSH1"; // Android-specific deviceId, supported options are "AndroidSH1" & "AndroidSH2"
    } else if (Platform.isIOS) {
      deviceID =
          "iOSSH1"; // iOS-specific deviceId, supported options are "iOSSH1" & "iOSSH2"
    }

    var reqJson = {
      "features": {
        "enableAbortResponse": true,
        "enableExpressPay": true,
        "enableInstrumentDeRegistration": true,
        "enableMerTxnDetails": true,
        "enableSI": true,
        "siDetailsAtMerchantEnd": true
      },
      "consumerData": {
        "deviceId": deviceID,
        "token": token1,
        "paymentMode": "all",
        "merchantLogoUrl":
            "https://www.paynimo.com/CompanyDocs/company-logo-vertical.png", //provided merchant logo will be displayed
        "merchantId": merchantId,
        "currency": "INR",
        "consumerId": AppUtility.ID,
        "consumerMobileNo": custmobile,
        "consumerEmailId": custemail,
        "txnId": txnId, //Unique merchant transaction ID
        "accountType": "Saving",
        "debitStartDate": startdate,
        "debitEndDate": enddate,
        "maxAmount": emiAmount,
        "amountType": "M",
        "frequency": frquency,
        "items": [
          {"itemId": "first", "amount": emiAmount, "comAmt": "0"}
        ],
        "customStyle": {
          "PRIMARY_COLOR_CODE": "#45beaa", //merchant primary color code
          "SECONDARY_COLOR_CODE":
              "#FFFFFF", //provide merchant's suitable color code
          "BUTTON_COLOR_CODE_1":
              "#2d8c8c", //merchant"s button background color code
          "BUTTON_COLOR_CODE_2":
              "#FFFFFF" //provide merchant's suitable color code for button text
        }
      }
    };

    wlCheckoutFlutter.on(WeiplCheckoutFlutter.wlResponse, handleResponse);
    dev.log(reqJson[1].toString());
    wlCheckoutFlutter.open(reqJson);
  }

  void handleResponse(Map<dynamic, dynamic> response) {
    List<MapEntry<dynamic, dynamic>> dynamiclist = response.entries.toList();
    print(dynamiclist);

    String respo = "${response}";
    List<String> abc = respo.split("|");
    List<String> abcd = abc[0].split(":");
    if (abcd[1] == " 0300") {
      NetworkcallforeNachresponse("$response");
    } else {
      showAlertDialog(context, "Failed", "${response}");
    }
  }

  Future<void> NetworkcallforeNachresponse(String dynamiclist) async {
    try {
      if (dynamiclist.startsWith('{msg:') && dynamiclist.endsWith('}')) {
        dynamiclist = dynamiclist.substring(5, dynamiclist.length - 1);
      }
      ProgressDialog.showProgressDialog(context, "title");
      String cretaejsonstring =
          CreateJson().createjsonforenachresponse(dynamiclist, context);
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.api_get_enach_response,
          NetworkUtility.api_get_enach_response_url,
          cretaejsonstring,
          context);
      if (list != null) {
        Navigator.pop(context);
        List<Enachresponseresponse> response = List.from(list!);
        String status = response[0].status!;
        switch (status) {
          case "true":
            // showSucesstDialog(
            //     context, "eNach Registration Success", dynamiclist);
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return ThankuForeNachsetup(widget.pagename);
              },
            ));
            break;
          case "false":
            break;
        }
      } else {
        Navigator.pop(context);
      }
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "NetworkcallforeNachToken", "ThankuPayment", context);
    }
  }

  void showSucesstDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Okay"),
      onPressed: () {
        Navigator.pop(context, false);
      },
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.only(left: 25, right: 25),
          title: Center(child: Text(title)),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          content: SizedBox(
            height: 400,
            width: 300,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  Text(message),
                ],
              ),
            ),
          ),
          actions: [
            continueButton,
          ],
        );
      },
    );
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Okay"),
      onPressed: () {
        dev.log(message);
        Navigator.pop(context, false);
      },
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.only(left: 25, right: 25),
          title: Center(child: Text(title)),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          content: SizedBox(
            height: 400,
            width: 300,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  Text(message),
                ],
              ),
            ),
          ),
          actions: [
            continueButton,
          ],
        );
      },
    );
  }
}
