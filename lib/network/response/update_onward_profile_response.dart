// To parse this JSON data, do
//
//     final updateonwardprofileresponse = updateonwardprofileresponseFromJson(jsonString);

import 'dart:convert';

List<Updateonwardprofileresponse> updateonwardprofileresponseFromJson(
        String str) =>
    List<Updateonwardprofileresponse>.from(
        json.decode(str).map((x) => Updateonwardprofileresponse.fromJson(x)));

String updateonwardprofileresponseToJson(
        List<Updateonwardprofileresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Updateonwardprofileresponse {
  String? status;
  String? message;
  Data? data;

  Updateonwardprofileresponse({
    this.status,
    this.message,
    this.data,
  });

  factory Updateonwardprofileresponse.fromJson(Map<String, dynamic> json) =>
      Updateonwardprofileresponse(
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
