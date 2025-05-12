// To parse this JSON data, do
//
//     final updateccavenuePayEmIcall = updateccavenuePayEmIcallFromJson(jsonString);

import 'dart:convert';

UpdateccavenuePayEmIcall updateccavenuePayEmIcallFromJson(String str) =>
    UpdateccavenuePayEmIcall.fromJson(json.decode(str));

String updateccavenuePayEmIcallToJson(UpdateccavenuePayEmIcall data) =>
    json.encode(data.toJson());

class UpdateccavenuePayEmIcall {
  String? orderId;
  String? trackingId;
  String? bankRefNo;
  String? orderStatus;
  String? paymentStatus;
  String? allowedToPayChargeOrDeduct;

  UpdateccavenuePayEmIcall({
    this.orderId,
    this.trackingId,
    this.bankRefNo,
    this.orderStatus,
    this.paymentStatus,
    this.allowedToPayChargeOrDeduct,
  });

  factory UpdateccavenuePayEmIcall.fromJson(Map<String, dynamic> json) =>
      UpdateccavenuePayEmIcall(
        orderId: json["order_id"],
        trackingId: json["tracking_id"],
        bankRefNo: json["bank_ref_no"],
        orderStatus: json["order_status"],
        paymentStatus: json["payment_status"],
        allowedToPayChargeOrDeduct: json["allowed_to_pay_charge_or_deduct"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "tracking_id": trackingId,
        "bank_ref_no": bankRefNo,
        "order_status": orderStatus,
        "payment_status": paymentStatus,
        "allowed_to_pay_charge_or_deduct": allowedToPayChargeOrDeduct,
      };
}
