// To parse this JSON data, do
//
//     final updateccavenuePayEmIresponse = updateccavenuePayEmIresponseFromJson(jsonString);

import 'dart:convert';

List<UpdateccavenuePayEmIresponse> updateccavenuePayEmIresponseFromJson(
        String str) =>
    List<UpdateccavenuePayEmIresponse>.from(
        json.decode(str).map((x) => UpdateccavenuePayEmIresponse.fromJson(x)));

String updateccavenuePayEmIresponseToJson(
        List<UpdateccavenuePayEmIresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UpdateccavenuePayEmIresponse {
  String? status;
  String? message;
  String? tei;
  String? epi;

  UpdateccavenuePayEmIresponse({
    this.status,
    this.message,
    this.tei,
    this.epi,
  });

  factory UpdateccavenuePayEmIresponse.fromJson(Map<String, dynamic> json) =>
      UpdateccavenuePayEmIresponse(
        status: json["status"],
        message: json["message"],
        tei: json["tei"],
        epi: json["epi"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "tei": tei,
        "epi": epi,
      };
}
