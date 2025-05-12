import 'dart:convert';
import 'dart:io';

import 'package:UNGolds/constant/extension.dart';
import 'package:UNGolds/network/call/updateccavenuepayemicall.dart';
import 'package:UNGolds/network/response/ccavenueresponsehandler.dart';
import 'package:UNGolds/network/response/ccavenueupdatePayEMIresponse.dart';
import 'package:UNGolds/network/response/ccavenueupdateresponse.dart';
import 'package:UNGolds/screens/gold_order/payment_failed.dart';
import 'package:UNGolds/screens/gold_order/thank_u_payment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:html/parser.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../constant/app_color.dart';
import '../../constant/printmessage.dart';
import '../../constant/progressdialog.dart';
import '../../constant/snackbardesign.dart';
import '../../network/createjson.dart';
import '../../network/networkcall.dart';
import '../../network/networkutility.dart';
import '../../network/response/ccavenueapiresponse.dart';

class CCAvenuepageForPayEMI extends StatefulWidget {
  String url, orderid;
  int allowed_to_pay_charge_or_deduct;
  CCAvenuepageForPayEMI(
      this.url, this.allowed_to_pay_charge_or_deduct, this.orderid);

  @override
  _CCAvenuepageForPayEMIState createState() => _CCAvenuepageForPayEMIState();
}

WebViewController controller = WebViewController();

class _CCAvenuepageForPayEMIState extends State<CCAvenuepageForPayEMI> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onUrlChange: (change) async {
            print(change);
          },
          onProgress: (int progress) {
            print(progress);
          },
          onPageStarted: (String url) async {
            print('URL: ' + url);
            if (url ==
                NetworkUtility.base_api + "api_ccavnue_emi_pay_response") {
              // ProgressDialog.showProgressDialog1(context, "title");
              final String htmlContent = await controller.getHtml();
              final parsedJson = parse(htmlContent);
              final jsonData = parsedJson.body?.text;
              var data = parsedJson.body;
              String str = jsonData.toString();
              controller.clearCache();
              final result = ccavenuresponsehandlerFromJson(str);
              //Ccavenuresponsehandler response = result!;
              String orderstatus = result.orderStatus!;
              String trackingid = result.trackingId!;
              String bankrefno = result.bankRefNo!;
              String orderid = result.orderId!;
              if (orderstatus == "Success") {
                //Navigator.pop(context);
                Networkcallforupdateccavenue(
                    orderstatus, trackingid, bankrefno, "1", "1", orderid);
              } else {
                // Navigator.pop(context);
                Networkcallforupdateccavenue(
                    orderstatus, trackingid, bankrefno, "1", "1", orderid);
              }
              print('orderstatus: ' + orderstatus);
            } else {
              print('URL: ' + url);
            }
          },
          onPageFinished: (String url) {
            print(url);
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            // if (request.url.startsWith('https://www.youtube.com/')) {
            // return NavigationDecision.prevent;
            // }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
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
                    'Secure Payment'.introTitleText(context),
                  ],
                ).marginOnly(top: 10),
              ),
            ],
          ),
        ),
        body: WebViewWidget(controller: controller),
      ),
    );
  }

  Future<void> Networkcallforupdateccavenue(
      String orderstatus,
      String trackingId,
      String bankref,
      String paymenttype,
      String paymentstatus,
      String orderid) async {
    try {
      ProgressDialog.showProgressDialog1(context, "Loading...");
      String creatjson = CreateJson().createjsonforPayEMIudateccavenuecall(
        orderid,
        trackingId,
        bankref,
        orderstatus,
        paymentstatus,
        widget.allowed_to_pay_charge_or_deduct.toString(),
        context,
      );
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.update_the_ccavnue_emi_pay,
          NetworkUtility.api_update_the_ccavnue_emi_pay,
          creatjson,
          context);
      if (list != null) {
        Navigator.pop(context);

        List<UpdateccavenuePayEmIresponse> response = List.from(list!);
        String status = response[0].status!;
        switch (status) {
          case "true":
            if (orderstatus == "Success") {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ThankuPayment(
                          2.03, response[0].tei!, response[0].epi!)));
            } else {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => PaymentFailed()));
            }
            break;
          case "false":
            SnackBarDesign('Unable to do payment!', context,
                AppColor.errorcolor, Colors.white);
            Navigator.pop(context);
            break;
        }
      } else {
        Navigator.pop(context);
        Navigator.pop(context);
      }
    } catch (e) {
      PrintMessage.printmessage(e.toString(), 'Networkcallforplaceorderwithemi',
          'Check Out EMI', context);
    }
  }
}
