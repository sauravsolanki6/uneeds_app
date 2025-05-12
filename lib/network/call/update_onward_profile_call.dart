// To parse this JSON data, do
//
//     final updateonwardprofilecall = updateonwardprofilecallFromJson(jsonString);

import 'dart:convert';

Updateonwardprofilecall updateonwardprofilecallFromJson(String str) =>
    Updateonwardprofilecall.fromJson(json.decode(str));

String updateonwardprofilecallToJson(Updateonwardprofilecall data) =>
    json.encode(data.toJson());

class Updateonwardprofilecall {
  String? id;
  String? firstName;
  String? lastName;
  String? country;
  String? state;
  String? district;
  String? taluka;
  String? address;
  String? pincode;
  String? image;
  String? oldImage;

  Updateonwardprofilecall({
    this.id,
    this.firstName,
    this.lastName,
    this.country,
    this.state,
    this.district,
    this.taluka,
    this.address,
    this.pincode,
    this.image,
    this.oldImage,
  });

  factory Updateonwardprofilecall.fromJson(Map<String, dynamic> json) =>
      Updateonwardprofilecall(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        country: json["country"],
        state: json["state"],
        district: json["district"],
        taluka: json["taluka"],
        address: json["address"],
        pincode: json["pincode"],
        image: json["image"],
        oldImage: json["old_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "country": country,
        "state": state,
        "district": district,
        "taluka": taluka,
        "address": address,
        "pincode": pincode,
        "image": image,
        "old_image": oldImage,
      };
}
