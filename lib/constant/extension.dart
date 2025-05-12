import 'dart:convert';
import 'dart:io';

import 'package:UNGolds/constant/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:webview_flutter/webview_flutter.dart';

extension TextWidget on String {
  introTitleText(BuildContext context) {
    return Text(
      this,
      style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 20,
          fontFamily: 'Switzer-Regular'),
      textAlign: TextAlign.center,
    );
  }

  getText() {
    return Text(
      this,
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
      textAlign: TextAlign.center,
    );
  }

  buttoText() {
    return Text(
      this,
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
      textAlign: TextAlign.center,
    );
  }

  TitelText(BuildContext context) {
    return Text(
      this,
      style: TextStyle(
          // ignore: deprecated_member_use
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 32),
      textAlign: TextAlign.center,
    );
  }

  SubTitelText() {
    return Text(
      this,
      style: TextStyle(
          color: Color(0xff828A89), fontWeight: FontWeight.w400, fontSize: 16),
      textAlign: TextAlign.center,
    );
  }

  nameText(BuildContext context) {
    return Text(
      this,
      style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.w400, fontSize: 16),
      textAlign: TextAlign.center,
    );
  }

  TegText(BuildContext context) {
    return Text(
      this,
      style: TextStyle(
          color: AppColor.bordercolor,
          fontWeight: FontWeight.w600,
          fontSize: 15),
      textAlign: TextAlign.center,
    );
  }

  TegSubText() {
    return Text(
      this,
      style: TextStyle(
          color: AppColor.bordercolor,
          fontWeight: FontWeight.w300,
          fontSize: 12),
      textAlign: TextAlign.center,
    );
  }

  TegTitleText() {
    return Text(
      this,
      style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.w500, fontSize: 12),
      textAlign: TextAlign.center,
    );
  }

  TegSubText_new() {
    return Text(
      this,
      style: TextStyle(
          color: Color.fromARGB(255, 58, 58, 59),
          fontWeight: FontWeight.w600,
          fontSize: 15),
      textAlign: TextAlign.center,
    );
  }

  homePageText(BuildContext context) {
    return Text(
      this,
      style: TextStyle(
          color: Color.fromARGB(255, 40, 40, 40),
          fontWeight: FontWeight.w600,
          fontSize: 16),
      textAlign: TextAlign.center,
    );
  }

  pageViewtext() {
    return Text(
      this,
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),
      textAlign: TextAlign.center,
    );
  }

  pageViewSubText() {
    return Text(
      this,
      style: TextStyle(
          color: Color(0xffCBD5DA), fontWeight: FontWeight.w400, fontSize: 13),
      textAlign: TextAlign.center,
    );
  }

  pageViewButtonText() {
    return Text(
      this,
      style: TextStyle(
          color: Color(0xffCBD5DA), fontWeight: FontWeight.w400, fontSize: 13),
      textAlign: TextAlign.center,
    );
  }

  priceText() {
    return Text(
      this,
      style: TextStyle(
          color: Color(0xffF2A666), fontWeight: FontWeight.w400, fontSize: 13),
      textAlign: TextAlign.center,
    );
  }

  pricechairText() {
    return Text(
      this,
      style: TextStyle(color: Color(0xffF2A666), fontSize: 13),
      textAlign: TextAlign.center,
    );
  }

  pricechairText1() {
    return Text(
      this,
      style: TextStyle(
          color: Color(0xffF2A666), fontWeight: FontWeight.w500, fontSize: 16),
      textAlign: TextAlign.start,
    );
  }

  viewPageText(BuildContext context) {
    return Text(
      this,
      style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.w500, fontSize: 24),
      textAlign: TextAlign.start,
    );
  }

  reviewText(BuildContext context) {
    return Text(
      this,
      style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.w400, fontSize: 12),
    );
  }

  reviewsubText() {
    return Text(
      this,
      style: TextStyle(
          color: Color(0xff828A89), fontWeight: FontWeight.w400, fontSize: 12),
    );
  }

  gramText() {
    return Text(
      this,
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.w400, fontSize: 10),
      textAlign: TextAlign.center,
    );
  }

  dialogbuttontext() {
    Text(
      this,
    );
  }
}

extension RupeesFormatter on double {
  String inRupeesFormat() {
    return indianRupeesFormat.format(this);
  }
}

final indianRupeesFormat = NumberFormat.currency(
  name: "INR",
  locale: 'en_IN',
  decimalDigits: 2, // change it to get decimal places
  symbol: '₹ ',
);

extension WebViewControllerExtension on WebViewController {
  Future<String> getHtml() {
    return runJavaScriptReturningResult('document.documentElement.outerHTML')
        .then((value) {
      if (Platform.isAndroid) {
        return jsonDecode(value as String) as String;
      } else {
        return value as String;
      }
    });
  }
}
