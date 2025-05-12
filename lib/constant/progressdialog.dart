import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ProgressDialog {
  static showProgressDialog(BuildContext context, String title) async {
    try {
      await Future.delayed(Duration(milliseconds: 50));
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          // return alert;
          // return Lottie.asset("assets/images/load.json",
          //     height: 1000, fit: BoxFit.contain);
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  'assets/images/load.json',
                  height: 200, // Adjust the height as needed
                  fit: BoxFit.contain,
                ),
              ],
            ),
          );
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }

  static showProgressDialog1(BuildContext context, String title) async {
    try {
      await Future.delayed(Duration(milliseconds: 50));
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          // return alert;
          return Lottie.asset("assets/images/payment.json");
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
