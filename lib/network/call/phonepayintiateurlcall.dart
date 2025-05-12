// To parse this JSON data, do
//
//     final phonepayinitiateurlcall = phonepayinitiateurlcallFromJson(jsonString);

import 'dart:convert';

import 'package:UNGolds/network/response/phonepayurlresponse.dart';

PhonepayurlDatum phonepayinitiateurlcallFromJson(String str) =>
    PhonepayurlDatum.fromJson(json.decode(str));

String phonepayinitiateurlcallToJson(PhonepayurlDatum data) =>
    json.encode(data.toJson());
