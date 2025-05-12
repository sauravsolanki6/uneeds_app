// To parse this JSON data, do
//
//     final updateprofilecall = updateprofilecallFromJson(jsonString);

import 'dart:convert';

Updateprofilecall updateprofilecallFromJson(String str) =>
    Updateprofilecall.fromJson(json.decode(str));

String updateprofilecallToJson(Updateprofilecall data) =>
    json.encode(data.toJson());

class Updateprofilecall {
  String? id;
  String? firstName;
  String? lastName;
  String? country;
  String? state;
  String? district;
  String? taluka;
  String? address;
  String? pincode;
  String? aadharNo;
  String? panNo;
  String? birthDate;
  String? annivarsary;
  String? image;
  String? oldImage;
  String? gst_no;

  Updateprofilecall({
    this.id,
    this.firstName,
    this.lastName,
    this.country,
    this.state,
    this.district,
    this.taluka,
    this.address,
    this.pincode,
    this.aadharNo,
    this.panNo,
    this.birthDate,
    this.annivarsary,
    this.image,
    this.oldImage,
    this.gst_no,
  });

  factory Updateprofilecall.fromJson(Map<String, dynamic> json) =>
      Updateprofilecall(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        country: json["country"],
        state: json["state"],
        district: json["district"],
        taluka: json["taluka"],
        address: json["address"],
        pincode: json["pincode"],
        aadharNo: json["aadhar_no"],
        panNo: json["pan_no"],
        birthDate: json["birth_date"],
        annivarsary: json["annivarsary"],
        image: json["image"],
        oldImage: json["old_image"],
        gst_no: json["gst_no"],
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
        "aadhar_no": aadharNo,
        "pan_no": panNo,
        "birth_date": birthDate,
        "annivarsary": annivarsary,
        "image": image,
        "old_image": oldImage,
        "gst_no": gst_no,
      };
}
