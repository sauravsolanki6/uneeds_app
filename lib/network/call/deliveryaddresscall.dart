// To parse this JSON data, do
//
//     final deliveryaddresscall = deliveryaddresscallFromJson(jsonString);

import 'dart:convert';

Deliveryaddresscall deliveryaddresscallFromJson(String str) =>
    Deliveryaddresscall.fromJson(json.decode(str));

String deliveryaddresscallToJson(Deliveryaddresscall data) =>
    json.encode(data.toJson());

class Deliveryaddresscall {
  String? userId;
  String? full_name;
  String? mobile;
  String? country;
  String? state;
  String? city;
  String? pincode;
  String? taluka;
  String? address;

  Deliveryaddresscall({
    this.userId,
    this.full_name,
    this.mobile,
    this.country,
    this.state,
    this.city,
    this.pincode,
    this.taluka,
    this.address,
  });

  factory Deliveryaddresscall.fromJson(Map<String, dynamic> json) =>
      Deliveryaddresscall(
        userId: json["user_id"],
        full_name: json["full_name"],
        mobile: json["mobile"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        pincode: json["pincode"],
        taluka: json["taluka"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "full_name": full_name,
        "mobile": mobile,
        "country": country,
        "state": state,
        "city": city,
        "pincode": pincode,
        "taluka": taluka,
        "address": address,
      };
}
