// To parse this JSON data, do
//
//     final buygoldonemicall = buygoldonemicallFromJson(jsonString);

import 'dart:convert';

Buygoldonemicall buygoldonemicallFromJson(String str) =>
    Buygoldonemicall.fromJson(json.decode(str));

String buygoldonemicallToJson(Buygoldonemicall data) =>
    json.encode(data.toJson());

class Buygoldonemicall {
  String? id;
  String? productPricePerGram;
  String? purchaseGram;
  String? actualBookingAmt;
  String? emiAmount;
  String? emiMonth;
  String? proceessAmt;
  String? proceessGst;
  String? processTotalAmt;
  String? makingAmt;
  String? makingGst;
  String? membershipType;
  String? membershipStatus;
  String? membership_fee;

  Buygoldonemicall(
      {this.id,
      this.productPricePerGram,
      this.purchaseGram,
      this.actualBookingAmt,
      this.emiAmount,
      this.emiMonth,
      this.proceessAmt,
      this.proceessGst,
      this.processTotalAmt,
      this.makingAmt,
      this.makingGst,
      this.membershipType,
      this.membershipStatus,
      this.membership_fee});

  factory Buygoldonemicall.fromJson(Map<String, dynamic> json) =>
      Buygoldonemicall(
          id: json["id"],
          productPricePerGram: json["product_price_per_gram"],
          purchaseGram: json["purchase_gram"],
          actualBookingAmt: json["actual_booking_amt"],
          emiAmount: json["emi_amount"],
          emiMonth: json["emi_month"],
          proceessAmt: json["proceess_amt"],
          proceessGst: json["proceess_gst"],
          processTotalAmt: json["process_total_amt"],
          makingAmt: json["making_amt"],
          makingGst: json["making_gst"],
          membershipType: json["membership_type"],
          membershipStatus: json["membership_status"],
          membership_fee: json["membership_fee"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_price_per_gram": productPricePerGram,
        "purchase_gram": purchaseGram,
        "actual_booking_amt": actualBookingAmt,
        "emi_amount": emiAmount,
        "emi_month": emiMonth,
        "proceess_amt": proceessAmt,
        "proceess_gst": proceessGst,
        "process_total_amt": processTotalAmt,
        "making_amt": makingAmt,
        "making_gst": makingGst,
        "membership_type": membershipType,
        "membership_status": membershipStatus,
        "membership_fee": membership_fee
      };
}
