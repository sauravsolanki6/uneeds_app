// To parse this JSON data, do
//
//     final getfeesresponse = getfeesresponseFromJson(jsonString);

import 'dart:convert';

List<Getfeesresponse> getfeesresponseFromJson(String str) =>
    List<Getfeesresponse>.from(
        json.decode(str).map((x) => Getfeesresponse.fromJson(x)));

String getfeesresponseToJson(List<Getfeesresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Getfeesresponse {
  String? status;
  String? message;
  Data? data;

  Getfeesresponse({
    this.status,
    this.message,
    this.data,
  });

  factory Getfeesresponse.fromJson(Map<String, dynamic> json) =>
      Getfeesresponse(
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
  String? id;
  String? advanceBookingFess;
  dynamic membershipFess;
  dynamic kycFess;
  String? processingFess;
  String? processingFessGst;
  String? makingCharge;
  String? makingChargeGst;
  String? eighteenCaratPrice;
  String? twentyTwoCaratPrice;
  String? twentyFourCaratPrice;
  String? isDeleted;
  String? status;
  DateTime? createdOn;
  DateTime? updatedOn;
  String? membershipStatus;
  String? membershipType;
  String? updatedMembershipFees;

  Data({
    this.id,
    this.advanceBookingFess,
    this.membershipFess,
    this.kycFess,
    this.processingFess,
    this.processingFessGst,
    this.makingCharge,
    this.makingChargeGst,
    this.eighteenCaratPrice,
    this.twentyTwoCaratPrice,
    this.twentyFourCaratPrice,
    this.isDeleted,
    this.status,
    this.createdOn,
    this.updatedOn,
    this.membershipStatus,
    this.membershipType,
    this.updatedMembershipFees,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        advanceBookingFess: json["advance_booking_fess"],
        membershipFess: json["membership_fess"],
        kycFess: json["kyc_fess"],
        processingFess: json["processing_fess"],
        processingFessGst: json["processing_fess_gst"],
        makingCharge: json["making_charge"],
        makingChargeGst: json["making_charge_gst"],
        eighteenCaratPrice: json["eighteen_carat_price"],
        twentyTwoCaratPrice: json["twenty_two_carat_price"],
        twentyFourCaratPrice: json["twenty_four_carat_price"],
        isDeleted: json["is_deleted"],
        status: json["status"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        updatedOn: json["updated_on"] == null
            ? null
            : DateTime.parse(json["updated_on"]),
        membershipStatus: json["membership_status"],
        membershipType: json["membership_type"],
        updatedMembershipFees: json["updated_membership_fees"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "advance_booking_fess": advanceBookingFess,
        "membership_fess": membershipFess,
        "kyc_fess": kycFess,
        "processing_fess": processingFess,
        "processing_fess_gst": processingFessGst,
        "making_charge": makingCharge,
        "making_charge_gst": makingChargeGst,
        "eighteen_carat_price": eighteenCaratPrice,
        "twenty_two_carat_price": twentyTwoCaratPrice,
        "twenty_four_carat_price": twentyFourCaratPrice,
        "is_deleted": isDeleted,
        "status": status,
        "created_on": createdOn?.toIso8601String(),
        "updated_on": updatedOn?.toIso8601String(),
        "membership_status": membershipStatus,
        "membership_type": membershipType,
        "updated_membership_fees": updatedMembershipFees,
      };
}
