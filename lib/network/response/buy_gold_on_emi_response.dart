// To parse this JSON data, do
//
//     final buygoldonemiresponse = buygoldonemiresponseFromJson(jsonString);

import 'dart:convert';

List<Buygoldonemiresponse> buygoldonemiresponseFromJson(String str) =>
    List<Buygoldonemiresponse>.from(
        json.decode(str).map((x) => Buygoldonemiresponse.fromJson(x)));

String buygoldonemiresponseToJson(List<Buygoldonemiresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Buygoldonemiresponse {
  String? status;
  String? message;
  Data? data;

  Buygoldonemiresponse({
    this.status,
    this.message,
    this.data,
  });

  factory Buygoldonemiresponse.fromJson(Map<String, dynamic> json) =>
      Buygoldonemiresponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  int? orderId;

  Data({
    this.orderId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        orderId: json["order_id"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
      };
}
