// To parse this JSON data, do
//
//     final updateccavenueProductresponse = updateccavenueProductresponseFromJson(jsonString);

import 'dart:convert';

List<UpdateccavenueProductresponse> updateccavenueProductresponseFromJson(
        String str) =>
    List<UpdateccavenueProductresponse>.from(
        json.decode(str).map((x) => UpdateccavenueProductresponse.fromJson(x)));

String updateccavenueProductresponseToJson(
        List<UpdateccavenueProductresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UpdateccavenueProductresponse {
  String? status;
  String? message;

  UpdateccavenueProductresponse({
    this.status,
    this.message,
  });

  factory UpdateccavenueProductresponse.fromJson(Map<String, dynamic> json) =>
      UpdateccavenueProductresponse(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
