// To parse this JSON data, do
//
//     final buygoldpaymentuneedswalletresponse = buygoldpaymentuneedswalletresponseFromJson(jsonString);

import 'dart:convert';

List<Buygoldpaymentuneedswalletresponse>
    buygoldpaymentuneedswalletresponseFromJson(String str) =>
        List<Buygoldpaymentuneedswalletresponse>.from(json
            .decode(str)
            .map((x) => Buygoldpaymentuneedswalletresponse.fromJson(x)));

String buygoldpaymentuneedswalletresponseToJson(
        List<Buygoldpaymentuneedswalletresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Buygoldpaymentuneedswalletresponse {
  String? status;
  String? message;

  Buygoldpaymentuneedswalletresponse({
    this.status,
    this.message,
  });

  factory Buygoldpaymentuneedswalletresponse.fromJson(
          Map<String, dynamic> json) =>
      Buygoldpaymentuneedswalletresponse(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
