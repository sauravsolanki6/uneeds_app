import 'dart:convert';
import 'dart:io';

import 'package:UNGolds/constant/extension.dart';
import 'package:UNGolds/network/response/ccavenueresponsehandler.dart';
import 'package:UNGolds/network/response/ccavenueupdateresponse.dart';
import 'package:UNGolds/screens/gold_order/payment_failed.dart';
import 'package:UNGolds/screens/gold_order/thank_u_payment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:html/parser.dart';
import 'package:lottie/lottie.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../constant/app_color.dart';
import '../../constant/printmessage.dart';
import '../../constant/progressdialog.dart';
import '../../constant/snackbardesign.dart';
import '../../network/createjson.dart';
import '../../network/networkcall.dart';
import '../../network/networkutility.dart';
import '../../network/response/ccavenueapiresponse.dart';

class CCAvenuepage extends StatefulWidget {
  String url;
  CCAvenuepage(this.url);

  @override
  _CCAvenuepageState createState() => _CCAvenuepageState();
}

WebViewController controller = WebViewController();

class _CCAvenuepageState extends State<CCAvenuepage> {
  bool isLoading = false;
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
            if (url == NetworkUtility.base_api + "api_ccavnue_response") {
              setState(() {
                isLoading = true; // Show loading indicator
              });
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
                Networkcallforupdateccavenue(
                    orderstatus, trackingid, bankrefno, "1", "1", orderid);
                setState(() {
                  isLoading =
                      false; // Hide loading indicator after network call
                });
              } else {
                Networkcallforupdateccavenue(
                    orderstatus, trackingid, bankrefno, "1", "1", orderid);
                setState(() {
                  isLoading =
                      false; // Hide loading indicator after network call
                });
              }
              print('orderstatus: ' + orderstatus);
            }
          },
          onPageFinished: (String url) {
            print(url);
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            // if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
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
        body: Stack(
          children: [
            WebViewWidget(controller: controller),
            if (isLoading) // Display loading indicator
              Center(
                child: Lottie.asset("assets/images/payment.json"),
              ),
          ],
        ),
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
      ProgressDialog.showProgressDialog(context, "Loading...");
      String creatjson = CreateJson().createjsonforudateccavenuecall(
        orderid,
        trackingId,
        bankref,
        paymenttype,
        paymentstatus,
        context,
      );
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.update_cc_avenue_emi_purchase,
          NetworkUtility.update_cc_avenue_emi_purchase_api,
          creatjson,
          context);
      if (list != null) {
        Navigator.pop(context);

        List<Updatetheccavnueresponse> response = List.from(list!);
        String status = response[0].status!;
        switch (status) {
          case "true":
            if (orderstatus == "Success") {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ThankuPayment(2.03, response[0].tei!, "")));
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
