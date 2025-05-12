// To parse this JSON data, do
//
//     final updatetheccavnuecall = updatetheccavnuecallFromJson(jsonString);

import 'dart:convert';

List<Updatetheccavnuecall> updatetheccavnuecallFromJson(String str) =>
    List<Updatetheccavnuecall>.from(
        json.decode(str).map((x) => Updatetheccavnuecall.fromJson(x)));

String updatetheccavnuecallToJson(List<Updatetheccavnuecall> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Updatetheccavnuecall {
  String? orderId;
  String? trackingId;
  String? bankRefNo;
  String? paymentType;
  String? paymentStatus;

  Updatetheccavnuecall({
    this.orderId,
    this.trackingId,
    this.bankRefNo,
    this.paymentType,
    this.paymentStatus,
  });

  factory Updatetheccavnuecall.fromJson(Map<String, dynamic> json) =>
      Updatetheccavnuecall(
        orderId: json["order_id"],
        trackingId: json["tracking_id"],
        bankRefNo: json["bank_ref_no"],
        paymentType: json["payment_type"],
        paymentStatus: json["payment_status"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "tracking_id": trackingId,
        "bank_ref_no": bankRefNo,
        "payment_type": paymentType,
        "payment_status": paymentStatus,
      };
}
