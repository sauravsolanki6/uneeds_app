// To parse this JSON data, do
//
//     final myorderlistcall = myorderlistcallFromJson(jsonString);

import 'dart:convert';

Myorderlistcall myorderlistcallFromJson(String str) =>
    Myorderlistcall.fromJson(json.decode(str));

String myorderlistcallToJson(Myorderlistcall data) =>
    json.encode(data.toJson());

class Myorderlistcall {
  String? id;
  String? orderType;

  Myorderlistcall({
    this.id,
    this.orderType,
  });

  factory Myorderlistcall.fromJson(Map<String, dynamic> json) =>
      Myorderlistcall(
        id: json["id"],
        orderType: json["order_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_type": orderType,
      };
}
