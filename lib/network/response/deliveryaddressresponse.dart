// To parse this JSON data, do
//
//     final deliveryaddressresponse = deliveryaddressresponseFromJson(jsonString);

import 'dart:convert';

List<Deliveryaddressresponse> deliveryaddressresponseFromJson(String str) =>
    List<Deliveryaddressresponse>.from(
        json.decode(str).map((x) => Deliveryaddressresponse.fromJson(x)));

String deliveryaddressresponseToJson(List<Deliveryaddressresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Deliveryaddressresponse {
  String? status;
  String? message;
  Data? data;

  Deliveryaddressresponse({
    this.status,
    this.message,
    this.data,
  });

  factory Deliveryaddressresponse.fromJson(Map<String, dynamic> json) =>
      Deliveryaddressresponse(
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
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
