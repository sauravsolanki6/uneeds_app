// To parse this JSON data, do
//
//     final loginresponse = loginresponseFromJson(jsonString);

import 'dart:convert';

List<Loginresponse> loginresponseFromJson(String str) =>
    List<Loginresponse>.from(
        json.decode(str).map((x) => Loginresponse.fromJson(x)));

String loginresponseToJson(List<Loginresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Loginresponse {
  String? status;
  String? message;
  Data? data;

  Loginresponse({
    this.status,
    this.message,
    this.data,
  });

  factory Loginresponse.fromJson(Map<String, dynamic> json) => Loginresponse(
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
  String? firstName;
  String? lastName;
  String? mobile;
  String? email;
  String? id;
  String? attepmt;

  Data({
    this.firstName,
    this.lastName,
    this.mobile,
    this.email,
    this.id,
    this.attepmt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        firstName: json["first_name"],
        lastName: json["last_name"],
        mobile: json["mobile"],
        email: json["email"],
        id: json["id"],
        attepmt: json["attepmt"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "mobile": mobile,
        "email": email,
        "id": id,
        "attepmt": attepmt,
      };
}
