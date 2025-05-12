// To parse this JSON data, do
//
//     final liverateresponse = liverateresponseFromJson(jsonString);

import 'dart:convert';

List<Liverateresponse> liverateresponseFromJson(String str) =>
    List<Liverateresponse>.from(
        json.decode(str).map((x) => Liverateresponse.fromJson(x)));

String liverateresponseToJson(List<Liverateresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Liverateresponse {
  String? status;
  String? message;
  Data? data;

  Liverateresponse({
    this.status,
    this.message,
    this.data,
  });

  factory Liverateresponse.fromJson(Map<String, dynamic> json) =>
      Liverateresponse(
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
  String? id;
  String? productPricePerGram;

  Data({
    this.id,
    this.productPricePerGram,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        productPricePerGram: json["product_price_per_gram"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_price_per_gram": productPricePerGram,
      };
}
