import 'package:UNGolds/constant/button_design.dart';
import 'package:UNGolds/constant/extension.dart';
import 'package:UNGolds/network/call/buygoldwalletstatus.dart';
import 'package:UNGolds/network/response/buy_gold_on_emi_response.dart';
import 'package:UNGolds/network/response/buygoldemiresponse.dart';
import 'package:UNGolds/screens/gold_order/payment_failed.dart';
import 'package:UNGolds/screens/gold_order/thank_you_for_buy_gold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../constant/app_color.dart';
import '../../constant/printmessage.dart';
import '../../constant/progressdialog.dart';
import '../../constant/snackbardesign.dart';
import '../../network/createjson.dart';
import '../../network/networkcall.dart';
import '../../network/networkutility.dart';
import '../../network/response/buygoldwalletresponse.dart';
import 'thank_u_payment.dart';

class BuyGoldPaymentWallet extends StatefulWidget {
  String orderid, pagename, pagevalue, emiorderid;
  double balanceamount, totalpayable;
  BuyGoldPaymentWallet(this.orderid, this.balanceamount, this.totalpayable,
      this.pagename, this.pagevalue, this.emiorderid);

  State createState() => BuyGoldPaymentWalletState();
}

class BuyGoldPaymentWalletState extends State<BuyGoldPaymentWallet> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  'Payment Details'.introTitleText(context),
                ],
              ).marginOnly(top: 10),
            ),
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 25,
            ).marginOnly(right: 10, top: 10)
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('My Wallet Amount: ${widget.balanceamount.inRupeesFormat()}'),
            SizedBox(
              height: 10,
            ),
            Text(
                'Total Payable Amount:${widget.totalpayable.inRupeesFormat()}'),
            SizedBox(
              height: 30,
            ),
            ButtonDesign(
                onPressed: () {
                  switch (widget.pagevalue) {
                    case "1": //Product purchase
                      productpurchaseupdatewalletpaymentstatus(widget.orderid);
                      break;
                    case "2": //Product purchase on emi
                      Onemipurchaseupdatewalletpaymentstatus(widget.orderid);
                      break;
                  }
                },
                child: 'Pay'.buttoText())
          ],
        ),
      ),
    );
  }

  Future<void> productpurchaseupdatewalletpaymentstatus(String orderid) async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading...");
      String creatjson = CreateJson().createjsonforbuygoldwallet(
        orderid,
        context,
      );
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.api_update_the_wallet_buy_product_status,
          NetworkUtility.api_update_the_wallet_buy_product_status_url,
          creatjson,
          context);
      if (list != null) {
        Navigator.pop(context);
        List<Buygoldwalletstatusresponse> response = List.from(list!);
        String status = response[0].status!;
        switch (status) {
          case "true":
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return ThankuForBuyGold();
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

  Future<void> Onemipurchaseupdatewalletpaymentstatus(String orderid) async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading...");
      String creatjson = CreateJson().createjsonforbuygoldwallet(
        orderid,
        context,
      );
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.api_update_the_wallet_emi_gold_purchase,
          NetworkUtility.api_update_the_wallet_emi_gold_purchase_url,
          creatjson,
          context);
      if (list != null) {
        Navigator.pop(context);
        List<Buygoldemiwalletstatusresponse> response = List.from(list!);
        String status = response[0].status!;
        switch (status) {
          case "true":
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return ThankuPayment(
                    widget.totalpayable, widget.orderid, widget.emiorderid);
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
