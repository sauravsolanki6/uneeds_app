import 'dart:convert';

import 'package:UNGolds/constant/button_design.dart';
import 'package:UNGolds/constant/extension.dart';
import 'package:UNGolds/constant/printmessage.dart';
import 'package:UNGolds/constant/progressdialog.dart';
import 'package:UNGolds/constant/snackbardesign.dart';
import 'package:UNGolds/network/createjson.dart';
import 'package:UNGolds/network/networkcall.dart';
import 'package:UNGolds/network/networkutility.dart';
import 'package:UNGolds/network/response/ccavenueapiresponse.dart';
import 'package:UNGolds/network/response/updatetheemipaystatusresponse.dart';
import 'package:UNGolds/screens/gold_order/CCAvenuepage.dart';
import 'package:UNGolds/screens/gold_order/payment_failed.dart';
import 'package:UNGolds/screens/gold_order/thank_u_payment.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';

import 'package:http/http.dart' as http;

import '../../constant/app_color.dart';
import '../../constant/utility.dart';
import '../../network/response/buygoldpaymentuneedswalletresponse.dart';
import '../../network/response/buygoldwalletresponse.dart';
import '../../network/response/getwayactiveresponse.dart';
import '../../network/response/walletamountresponse.dart';
import 'CCAvenueWebViewPageForPayEMI.dart';
import 'CCAvenuepageForpayemi.dart';
import 'EMIpaymentwallet.dart';

String orderId = "";
double amount = 0.0;

class PayEmiPayment extends StatefulWidget {
  double totalpayable, emiamount, latecharge;
  String orderid;
  int allowed_to_pay_charge_or_deduct;
  bool ispaylateemichage;
  PayEmiPayment(
      this.totalpayable,
      this.orderid,
      this.allowed_to_pay_charge_or_deduct,
      this.emiamount,
      this.latecharge,
      this.ispaylateemichage);

  @override
  State<PayEmiPayment> createState() => _PayEmiPaymentState();
}

class _PayEmiPaymentState extends State<PayEmiPayment> {
  String environment = "PRODUCTION";
  String appId = "";

  String transactionId =
      "UN_" + orderId + "_" + DateTime.now().millisecondsSinceEpoch.toString();
  String merchantId = "M22W78TXIJGOB";

  bool enableLogging = true;
  String checksum = "";
  String saltKey = "1540eb95-e736-4c20-acd4-6c09eb2a6761";

  int saltIndex = 1;
//Need to test
  String callbackUrl = NetworkUtility.base_api + "/payment-success";

  String body = "";
  String apiEndPoint = "/pg/v1/pay";

  Object? result;

  getChecksum(double totalpayable) {
    final requestData = {
      "merchantId": merchantId,
      "merchantTransactionId": transactionId,
      "merchantUserId": "MUID123",
      "amount": (totalpayable * 100),
      "mobileNumber": "8999166472",
      "callbackUrl": callbackUrl,
      "paymentInstrument": {"type": "PAY_PAGE"}
    };

    String base64Body = base64.encode(utf8.encode(json.encode(requestData)));

    checksum =
        '${sha256.convert(utf8.encode(base64Body + apiEndPoint + saltKey)).toString()}###$saltIndex';

    return base64Body;
  }

  @override
  void initState() {
    super.initState();
    orderId = widget.orderid;
    amount = widget.totalpayable;
    // amount = 11.30;
    transactionId = "UN_" +
        orderId +
        "_" +
        DateTime.now().millisecondsSinceEpoch.toString();
    phonepeInit();

    body = getChecksum(widget.totalpayable).toString();
    Networkcallforgetgetwayactivestatus();
    Networkcallforgetgetwalletbalance();
  }

  double creaditamount = 0.0,
      debitamount = 0.0,
      walletbalanceamount = 0.0,
      uneedswalletbalance = 0.0;
  Future<void> Networkcallforgetgetwalletbalance() async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading");
      String createjson = CreateJson()
          .createjsonforgetwalletdebithistory(AppUtility.ID, context);
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.api_user_wallet_amount,
          NetworkUtility.api_user_wallet_amount_url,
          createjson,
          context);
      if (list != null) {
        Navigator.pop(context);
        List<Walletamountesponse> response = List.from(list!);
        String status = response[0].status.toString();
        switch (status) {
          case "true":
            creaditamount = double.parse(response[0].creditWalletAmount!);
            if (response[0].debitWalletAmount == null) {
              debitamount == 0.0;
            } else {
              debitamount = double.parse(response[0].debitWalletAmount!);
            }

            walletbalanceamount =
                double.parse(response[0].balanceWalletAmount!);
            uneedswalletbalance =
                double.parse(response[0].uneed_wallet_balance!);
            setState(() {});
            break;
          case "false":
            SnackBarDesign(
                'No data found!', context, AppColor.errorcolor, Colors.white);

            break;
        }
      } else {
        SnackBarDesign('Something went wrong!', context, AppColor.errorcolor,
            Colors.white);

        Navigator.pop(context);
      }
    } catch (e) {
      PrintMessage.printmessage(e.toString(), 'Networkcallforreferandearn',
          "Refer And Earn ", context);
    }
  }

  int ccavenuactive = 0, phonepayactive = 0, walletactive = 0;
  Future<void> Networkcallforgetgetwayactivestatus() async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading");

      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.getMethod(
          NetworkUtility.api_active_payment_way,
          NetworkUtility.api_active_payment_way_url,
          context);
      if (list != null) {
        Navigator.pop(context);
        List<Getwayactiveresponse> response = List.from(list!);
        String status = response[0].status.toString();
        switch (status) {
          case "true":
            ccavenuactive = int.parse(response[0].ccavenue!);
            phonepayactive = int.parse(response[0].phonepay!);
            walletactive = int.parse(response[0].wallet!);
            setState(() {});
            break;
          case "false":
            SnackBarDesign(
                'Payment getway is under maintenance, Please try after some time ',
                context,
                AppColor.errorcolor,
                Colors.white);

            break;
        }
      } else {
        SnackBarDesign('Something went wrong!', context, AppColor.errorcolor,
            Colors.white);

        Navigator.pop(context);
      }
    } catch (e) {
      PrintMessage.printmessage(e.toString(),
          'Networkcallforgetgetwayactivestatus', "Payment getway ", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
              ccavenuactive == 0 && phonepayactive == 0 && walletactive == 0
                  ? Text(
                      'Sorry for inconvenience, Payment gateway is under maintenance',
                      style: TextStyle(
                          color: AppColor.bordercolor,
                          fontSize: 10,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ).marginOnly(top: 10, bottom: 10)
                  : Text(
                      'Experience unparalleled security with our Payment Gateway. Simplify transactions and elevate your business with seamless, encrypted payment processing.',
                      style: TextStyle(
                          color: AppColor.bordercolor,
                          fontSize: 10,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ).marginOnly(top: 10, bottom: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ccavenuactive == 0
                      ? Container()
                      : ButtonDesign(
                          onPressed: () {
                            Networkcallforplaceorderwithccavenue(
                                widget.orderid);
                          },
                          child: 'Pay Via CC Avenue'.buttoText()),
                  SizedBox(
                    width: 10,
                  ),
                  phonepayactive == 0
                      ? Container()
                      : ButtonDesign(
                          onPressed: () {
                            startPgTransaction();
                          },
                          child: 'Pay Via Phonepe'.buttoText()),
                  walletactive == 0
                      ? Container()
                      : walletbalanceamount >= widget.totalpayable
                          ? ButtonDesign(
                              onPressed: () {
                                Networkcallforplaceorderwithwallet(
                                    widget.orderid);
                              },
                              child: 'Pay Via Wallet'.buttoText())
                          : Container(),
                  uneedswalletbalance >= widget.totalpayable
                      ? ButtonDesign(
                          onPressed: () {
                            Networkcallforplaceorderwithuneedswallet(
                                widget.orderid);
                          },
                          child: 'Pay Via Uneeds Wallet'.buttoText())
                      : Container(),
                ],
              ),
              // Text("Result \n $result"),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> Networkcallforplaceorderwithwallet(String orderid) async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading...");
      String creatjson = CreateJson().createjsonforbuygoldwallet(
        orderid,
        context,
      );
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.api_get_product_buy_order_details_through_wallet,
          NetworkUtility.api_get_product_buy_order_details_through_wallet_url,
          creatjson,
          context);
      if (list != null) {
        Navigator.pop(context);
        List<Buygoldwalletresponse> response = List.from(list!);
        String status = response[0].status!;
        switch (status) {
          case "true":
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return EMIPaymentWallet(
                    widget.orderid,
                    walletbalanceamount,
                    widget.totalpayable,
                    widget.orderid,
                    widget.ispaylateemichage ? 2 : 0,
                    widget.emiamount,
                    widget.latecharge //means table invoice id
                    );
              },
            ));
            break;
          case "false":
            SnackBarDesign('Unable to proccess , Please try again!', context,
                AppColor.errorcolor, Colors.white);
            break;
        }
      } else {
        Navigator.pop(context);
      }
    } catch (e) {
      PrintMessage.printmessage(e.toString(), 'Networkcallforplaceorderwithemi',
          'Check Out EMI', context);
    }
  }

  void phonepeInit() {
    PhonePePaymentSdk.init(environment, appId, merchantId, enableLogging)
        .then((val) => {
              setState(() {
                result = 'PhonePe SDK Initialized - $val';
              })
            })
        .catchError((error) {
      handleError(error);
      return <dynamic>{};
    });
  }

  void startPgTransaction() async {
    try {
      var response =
          PhonePePaymentSdk.startTransaction(body, callbackUrl, checksum, "");
      response.then((val) async {
        if (val != null) {
          String status = val['status'].toString();
          String error = val['error'].toString();

          if (status == 'SUCCESS') {
            result = "Flow complete - status : SUCCESS";

            await checkStatus();
          } else {
            result = "Flow complete - status : $status and error $error";
          }
        } else {
          result = "Flow Incomplete";
        }
      }).catchError((error) {
        handleError(error);
        return <dynamic>{};
      });
    } catch (error) {
      handleError(error);
    }
  }

  void handleError(error) {
    setState(() {
      result = {"error": error};
    });
  }

  checkStatus() async {
    try {
      String url =
          "https://api.phonepe.com/apis/hermes/pg/v1/status/$merchantId/$transactionId"; //Test

      String concatenatedString =
          "/pg/v1/status/$merchantId/$transactionId$saltKey";

      var bytes = utf8.encode(concatenatedString);
      var digest = sha256.convert(bytes);
      String hashedString = digest.toString();

      //  combine with salt key
      String xVerify = "$hashedString###$saltIndex";

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "X-MERCHANT-ID": merchantId,
        "X-VERIFY": xVerify,
      };

      await http.get(Uri.parse(url), headers: headers).then((value) {
        Map<String, dynamic> res = jsonDecode(value.body);

        try {
          if (res["code"] == "PAYMENT_SUCCESS" &&
              res['data']['responseCode'] == "SUCCESS") {
            ProgressDialog.showProgressDialog(context, "title");
            Networkcallforupdatetheemipaystatuscall(
                "UNG${transactionId}", res['data']['transactionId']);
          } else {
            // Fluttertoast.showToast(
            //     msg: "${res["message"]} Something went wrong");
            // Navigator.pop(context);
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return PaymentFailed();
              },
            ));
          }
        } catch (e) {
          Fluttertoast.showToast(msg: "${res["message" + e.toString()]}");
          Navigator.pop(context);
        }
      });
    } catch (e) {
      Fluttertoast.showToast(msg: " Error: " + e.toString());
    }
  }

  Future<void> Networkcallforupdatetheemipaystatuscall(
      String transactionid, String providerReferenceId) async {
    try {
      String createjson = CreateJson()
          .createjsonforupdatetheemirepaymentstatuscall(
              transactionid,
              providerReferenceId,
              context,
              orderId,
              widget.allowed_to_pay_charge_or_deduct);
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.update_the_emi_pay_status,
          NetworkUtility.api_pay_emi_amount_through_gateway,
          createjson,
          context);
      if (list != null) {
        Navigator.pop(context);
        List<Updatetheemipaystatusresponse> response = List.from(list!);
        String status = response[0].status!;
        switch (status) {
          case "true":
            // SnackBarDesign(response[0].message!, context, AppColor.greencolor,
            //     Colors.white);
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return ThankuPayment(amount, orderId,
                    'Thank you for payment. You can continue to purchase gold on emi');
              },
            ));
            break;
          case "false":
            SnackBarDesign(
                response[0].message!, context, AppColor.redcolor, Colors.white);
            break;
        }
      } else {
        Navigator.pop(context);
        PrintMessage.printmessage(
            'Something went wrong',
            'Networkcallforupdatetheemipaystatuscall',
            'PhonepaypaymentNew',
            context);
      }
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(),
          'Networkcallforupdatetheemipaystatuscall',
          'PhonepaypaymentNew',
          context);
    }
  }

  Future<void> Networkcallforplaceorderwithccavenue(String orderid) async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading...");
      String creatjson = CreateJson().createjsonforpayemiccavenueapicall(
        orderid,
        AppUtility.ID,
        widget.totalpayable.toString(),
        widget.allowed_to_pay_charge_or_deduct,
        context,
      );
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.api_initiate_cc_avenue,
          NetworkUtility.api_initiate_cc_avenue_request_for_emi,
          creatjson,
          context);
      if (list != null) {
        Navigator.pop(context);
        List<Ccavenueapiresponse> response = List.from(list!);
        String status = response[0].status!;
        switch (status) {
          case "true":
            // Navigator.pushReplacement(context, MaterialPageRoute(
            //   builder: (context) {
            //     return CCAvenuepageForPayEMI(response[0].initiateUrl!,
            //         widget.allowed_to_pay_charge_or_deduct, widget.orderid);
            //   },
            // ));
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return CCAvenueWebViewPageForPayEMI(
                    response[0].initiateUrl!, amount, orderid);
              },
            ));
            break;
          case "false":
            SnackBarDesign('Unable to pay emi!', context, AppColor.errorcolor,
                Colors.white);
            break;
        }
      } else {
        Navigator.pop(context);
      }
    } catch (e) {
      PrintMessage.printmessage(e.toString(), 'Networkcallforplaceorderwithemi',
          'Check Out EMI', context);
    }
  }

  Future<void> Networkcallforplaceorderwithuneedswallet(String orderid) async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading...");
      String creatjson = CreateJson().createjsonforemipayunwallet(
        orderid,
        widget.allowed_to_pay_charge_or_deduct,
        context,
      );
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.set_buy_product_by_uneed_wallet,
          NetworkUtility.update_emi_pay_through_uneeds_wallet_url,
          creatjson,
          context);
      if (list != null) {
        Navigator.pop(context);
        List<Buygoldpaymentuneedswalletresponse> response = List.from(list!);
        String status = response[0].status!;
        switch (status) {
          case "true":
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return ThankuPayment(amount, orderId,
                    'Thank you for payment. You can continue to purchase gold on emi');
              },
            ));
            break;
          case "false":
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return PaymentFailed();
              },
            ));
            break;
        }
      } else {
        Navigator.pop(context);
      }
    } catch (e) {
      PrintMessage.printmessage(e.toString(), 'Networkcallforplaceorderwithemi',
          'Check Out EMI', context);
    }
  }
}
