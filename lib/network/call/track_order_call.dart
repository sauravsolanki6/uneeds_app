// To parse this JSON data, do
//
//     final trackordercall = trackordercallFromJson(jsonString);

import 'dart:convert';

Trackordercall trackordercallFromJson(String str) =>
    Trackordercall.fromJson(json.decode(str));

String trackordercallToJson(Trackordercall data) => json.encode(data.toJson());

class Trackordercall {
  String? tblOrderId;
  String? status;

  Trackordercall({
    this.tblOrderId,
    this.status,
  });

  factory Trackordercall.fromJson(Map<String, dynamic> json) => Trackordercall(
        tblOrderId: json["tbl_order_id"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "tbl_order_id": tblOrderId,
        "status": status,
      };
}
