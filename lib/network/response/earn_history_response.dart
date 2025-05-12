// To parse this JSON data, do
//
//     final earnhistoryresponse = earnhistoryresponseFromJson(jsonString);

import 'dart:convert';

List<Earnhistoryresponse> earnhistoryresponseFromJson(String str) =>
    List<Earnhistoryresponse>.from(
        json.decode(str).map((x) => Earnhistoryresponse.fromJson(x)));

String earnhistoryresponseToJson(List<Earnhistoryresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Earnhistoryresponse {
  String? status;
  String? message;
  List<EarnhistoryresponseDatum>? data;

  Earnhistoryresponse({
    this.status,
    this.message,
    this.data,
  });

  factory Earnhistoryresponse.fromJson(Map<String, dynamic> json) =>
      Earnhistoryresponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<EarnhistoryresponseDatum>.from(
                json["data"]!.map((x) => EarnhistoryresponseDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class EarnhistoryresponseDatum {
  String? referralId;
  String? totalEarnPrice;
  String? name;

  EarnhistoryresponseDatum({
    this.referralId,
    this.totalEarnPrice,
    this.name,
  });

  factory EarnhistoryresponseDatum.fromJson(Map<String, dynamic> json) =>
      EarnhistoryresponseDatum(
        referralId: json["referral_id"],
        totalEarnPrice: json["total_earn_price"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "referral_id": referralId,
        "total_earn_price": totalEarnPrice,
        "name": name,
      };
}
