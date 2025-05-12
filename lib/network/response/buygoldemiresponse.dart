// To parse this JSON data, do
//
//     final buygoldemiwalletstatusresponse = buygoldemiwalletstatusresponseFromJson(jsonString);

import 'dart:convert';

List<Buygoldemiwalletstatusresponse> buygoldemiwalletstatusresponseFromJson(
        String str) =>
    List<Buygoldemiwalletstatusresponse>.from(json
        .decode(str)
        .map((x) => Buygoldemiwalletstatusresponse.fromJson(x)));

String buygoldemiwalletstatusresponseToJson(
        List<Buygoldemiwalletstatusresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Buygoldemiwalletstatusresponse {
  String? status;
  String? orderId;
  String? message;
  Data? data;

  Buygoldemiwalletstatusresponse({
    this.status,
    this.orderId,
    this.message,
    this.data,
  });

  factory Buygoldemiwalletstatusresponse.fromJson(Map<String, dynamic> json) =>
      Buygoldemiwalletstatusresponse(
        status: json["status"],
        orderId: json["order_id"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "order_id": orderId,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
