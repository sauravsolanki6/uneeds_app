// To parse this JSON data, do
//
//     final referalcustomerlistresponse = referalcustomerlistresponseFromJson(jsonString);

import 'dart:convert';

List<Referalcustomerlistresponse> referalcustomerlistresponseFromJson(
        String str) =>
    List<Referalcustomerlistresponse>.from(
        json.decode(str).map((x) => Referalcustomerlistresponse.fromJson(x)));

String referalcustomerlistresponseToJson(
        List<Referalcustomerlistresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Referalcustomerlistresponse {
  String? status;
  String? message;
  List<ReferalcustomerlistDatum>? data;

  Referalcustomerlistresponse({
    this.status,
    this.message,
    this.data,
  });

  factory Referalcustomerlistresponse.fromJson(Map<String, dynamic> json) =>
      Referalcustomerlistresponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<ReferalcustomerlistDatum>.from(
                json["data"]!.map((x) => ReferalcustomerlistDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ReferalcustomerlistDatum {
  String? name;
  String? purchaseGram;
  DateTime? purchaseDate;
  int? totalOrder;
  String? id;
  String? isActive;

  ReferalcustomerlistDatum({
    this.name,
    this.purchaseGram,
    this.purchaseDate,
    this.totalOrder,
    this.id,
    this.isActive,
  });

  factory ReferalcustomerlistDatum.fromJson(Map<String, dynamic> json) =>
      ReferalcustomerlistDatum(
        name: json["name"],
        purchaseGram: json["purchase_gram"],
        purchaseDate: json["purchase_date"] == null
            ? null
            : DateTime.parse(json["purchase_date"]),
        totalOrder: json["total_order"],
        id: json["id"],
        isActive: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "purchase_gram": purchaseGram,
        "purchase_date":
            "${purchaseDate!.year.toString().padLeft(4, '0')}-${purchaseDate!.month.toString().padLeft(2, '0')}-${purchaseDate!.day.toString().padLeft(2, '0')}",
        "total_order": totalOrder,
        "id": id,
        "is_active": isActive,
      };
}
