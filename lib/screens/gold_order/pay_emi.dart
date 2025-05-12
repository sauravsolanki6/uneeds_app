import 'package:UNGolds/constant/button_design.dart';
import 'package:UNGolds/constant/extension.dart';
import 'package:UNGolds/screens/gold_order/buy_gold_payment.dart';
import 'package:UNGolds/screens/gold_order/pay_emi_payment.dart';
import 'package:UNGolds/screens/gold_order/thank_u_payment.dart';
import 'package:UNGolds/screens/gold_order/thank_u_payment_emi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/app_color.dart';
import '../../constant/printmessage.dart';
import '../../constant/progressdialog.dart';
import '../../constant/show_confirmation_dialog.dart';
import '../../constant/snackbardesign.dart';
import '../../constant/utility.dart';
import '../../network/createjson.dart';
import '../../network/networkcall.dart';
import '../../network/networkutility.dart';
import '../../network/response/emipaymentwalletresponse.dart';

class PayEMI extends StatefulWidget {
  double walletAmount, emiamount, lateemicharge;
  String orderId;
  PayEMI(this.walletAmount, this.emiamount, this.lateemicharge, this.orderId);
  State createState() => PayEMIState();
}

class PayEMIState extends State<PayEMI> {
  @override
  Widget build(BuildContext context) {
    double totalpayamount = widget.emiamount;
    if (_ispaylateemichage == true) {
      totalpayamount = totalpayamount + widget.lateemicharge;
      // setState(() {});
    }
    if (_isdeductfromwallet == true) {
      if (widget.emiamount > widget.walletAmount) {
        totalpayamount = widget.emiamount - widget.walletAmount;
      } else {
        // totalpayamount = widget.walletAmount - widget.emiamount;

        totalpayamount = 0.0;
      }
      // setState(() {});
    }
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(CupertinoIcons.left_chevron)),
        elevation: 0,
        toolbarHeight: 70,
        backgroundColor: AppColor.bgcolor.withOpacity(0.2),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  'Pay EMI'.introTitleText(context),
                ],
              ).marginOnly(top: 10),
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
        width: double.maxFinite,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
            color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              //widget.walletAmount == 0.0 ? Container() :
              _showwalletammount(),
              // widget.lateemicharge == 0.0
              //     ? Container()
              //     :
              widget.lateemicharge == 0.0
                  ? Container()
                  : _showlateammount(widget.lateemicharge),
              _showemiammount(widget.emiamount),
              //  widget.walletAmount == 0.0 ? Container() : _checkwalletammount(),
              widget.lateemicharge == 0.0
                  ? Container()
                  : _checkpaylateemicharge(),
              _totalammountpay(totalpayamount),
              ButtonDesign(
                  onPressed: () {
                    showConfirmationDialog(totalpayamount);
                  },
                  child: 'Continue'.buttoText())
            ],
          ),
        ),
      ),
    );
  }

  Widget _showwalletammount() {
    return Row(
      children: [
        Text(
          'Wallet Amount: ${widget.walletAmount.inRupeesFormat()}',
          style: TextStyle(
              color: AppColor.bordercolor,
              fontSize: 12,
              fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  Widget _showlateammount(double lateemicharge) {
    return Row(
      children: [
        Text(
          'Total Late EMI Charge: ${lateemicharge.inRupeesFormat()}',
          style: TextStyle(
              color: AppColor.bordercolor,
              fontSize: 12,
              fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  bool _isdeductfromwallet = false;
  Widget _checkwalletammount() {
    return Row(
      children: [
        Checkbox(
          value: _isdeductfromwallet,
          onChanged: (value) {
            setState(() {
              _isdeductfromwallet = value!;
            });
          },
        ),
        Text(
          'Want To Deduct EMI Amount From Wallet?',
          style: TextStyle(
              color: AppColor.bordercolor,
              fontSize: 12,
              fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  bool _ispaylateemichage = false;
  Widget _checkpaylateemicharge() {
    return Row(
      children: [
        Checkbox(
          value: _ispaylateemichage,
          onChanged: (value) {
            setState(() {
              _ispaylateemichage = value!;
            });
          },
        ),
        Text(
          'Want To Pay Late EMI Charge? ',
          style: TextStyle(
              color: AppColor.bordercolor,
              fontSize: 12,
              fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  Widget _showemiammount(double emiamount) {
    return Row(
      children: [
        Text(
          'EMI Amount: ${emiamount.inRupeesFormat()}',
          style: TextStyle(
              color: AppColor.bordercolor,
              fontSize: 12,
              fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  Widget _totalammountpay(double totalpayamount) {
    return Row(
      children: [
        Text(
          'Total Pay Amount: ',
          style: TextStyle(
              color: AppColor.bordercolor,
              fontSize: 12,
              fontWeight: FontWeight.w500),
        ),
        Text(
          ' ${totalpayamount.inRupeesFormat()}',
          style: TextStyle(
            color: AppColor.bordercolor,
            fontSize: 12,
          ),
        )
      ],
    );
  }

  showConfirmationDialog(double totalpayamount) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialogDesign(
            description: "Are you sure? You want pay emi?",
            nobuttonPressed: () {
              Navigator.pop(context);
            },
            yesbuttonPressed: () {
              Navigator.pop(context);

              if (totalpayamount != 0.0) {
                int allowed_to_pay_charge_or_deduct = 0;
                if (_ispaylateemichage == true) {
                  allowed_to_pay_charge_or_deduct = 2;
                }

                // As per discuss with sanket on date 22/08/2024 i comment this lines
                // if (_isdeductfromwallet == true) {
                //   allowed_to_pay_charge_or_deduct = 2;
                // }
                // if (_ispaylateemichage == true && _isdeductfromwallet == true) {
                //   allowed_to_pay_charge_or_deduct = 3;
                // }
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return PayEmiPayment(
                        totalpayamount,
                        widget.orderId,
                        allowed_to_pay_charge_or_deduct,
                        widget.emiamount,
                        widget.lateemicharge,
                        _ispaylateemichage);
                  },
                ));
              } else {
                Networkcallforallowpaymentfromwallet(
                    widget.orderId, _ispaylateemichage, totalpayamount);
              }
            },
            title: "Confirmation",
          );
        });
  }

  Future<void> Networkcallforallowpaymentfromwallet(
      String orderId, bool _ispaylateemichage, double amount) async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading...");
      String createjosn = CreateJson().craetejsonforemipayfromwallet(
          AppUtility.ID,
          "1",
          orderId,
          context,
          _ispaylateemichage ? "1" : "0",
          widget.emiamount);
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.emi_pay_from_wallet,
          NetworkUtility.emi_pay_from_wallet_api,
          createjosn,
          context);
      if (list != null) {
        Navigator.pop(context);
        List<Emipaymentwalletresponse> response = List.from(list!);
        String status = response[0].status!;
        switch (status) {
          case "true":
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return ThankuPaymentEMI(amount, widget.orderId,
                    _isdeductfromwallet, _ispaylateemichage);
              },
            ));
            break;
          case "false":
            SnackBarDesign(
                "Message", context, AppColor.sucesscolor, Colors.white);
            break;
        }
      } else {
        Navigator.pop(context);
        SnackBarDesign("Something went wrong!", context, AppColor.errorcolor,
            Colors.white);
      }
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(),
          "Networkcallforallowpaymentfromwallet()",
          "Thank u Payment EMI",
          context);
    }
  }
}
