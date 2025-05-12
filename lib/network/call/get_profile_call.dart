// To parse this JSON data, do
//
//     final getprofilecall = getprofilecallFromJson(jsonString);

import 'dart:convert';

Getprofilecall getprofilecallFromJson(String str) =>
    Getprofilecall.fromJson(json.decode(str));

String getprofilecallToJson(Getprofilecall data) => json.encode(data.toJson());

class Getprofilecall {
  String? id;

  Getprofilecall({
    this.id,
  });

  factory Getprofilecall.fromJson(Map<String, dynamic> json) => Getprofilecall(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
