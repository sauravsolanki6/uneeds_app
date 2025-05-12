// To parse this JSON data, do
//
//     final addnomineedetailsresponse = addnomineedetailsresponseFromJson(jsonString);

import 'dart:convert';

List<Addnomineedetailsresponse> addnomineedetailsresponseFromJson(String str) =>
    List<Addnomineedetailsresponse>.from(
        json.decode(str).map((x) => Addnomineedetailsresponse.fromJson(x)));

String addnomineedetailsresponseToJson(List<Addnomineedetailsresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Addnomineedetailsresponse {
  String? status;
  String? message;
  Data? data;

  Addnomineedetailsresponse({
    this.status,
    this.message,
    this.data,
  });

  factory Addnomineedetailsresponse.fromJson(Map<String, dynamic> json) =>
      Addnomineedetailsresponse(
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
