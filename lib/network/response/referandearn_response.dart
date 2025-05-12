// To parse this JSON data, do
//
//     final referalandearnresponse = referalandearnresponseFromJson(jsonString);

import 'dart:convert';

List<Referalandearnresponse> referalandearnresponseFromJson(String str) =>
    List<Referalandearnresponse>.from(
        json.decode(str).map((x) => Referalandearnresponse.fromJson(x)));

String referalandearnresponseToJson(List<Referalandearnresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Referalandearnresponse {
  String? status;
  double? earnAmount;
  double? deductAmount;
  int? requestPending;
  String? kycStatus;
  int? bankDetailsAdded;
  String? tdsDeductionPercentage;
  String? message;
  List<Datum>? data;
  double? total_withdraw_amount;
  Referalandearnresponse({
    this.status,
    this.earnAmount,
    this.deductAmount,
    this.requestPending,
    this.kycStatus,
    this.bankDetailsAdded,
    this.tdsDeductionPercentage,
    this.message,
    this.data,
    this.total_withdraw_amount,
  });

  factory Referalandearnresponse.fromJson(Map<String, dynamic> json) =>
      Referalandearnresponse(
        status: json["status"],
        earnAmount: json["earn_amount"]?.toDouble(),
        deductAmount: json["deduct_amount"]?.toDouble(),
        total_withdraw_amount: json["total_withdraw_amount"]?.toDouble(),
        requestPending: json["request_pending"],
        kycStatus: json["kyc_status"],
        bankDetailsAdded: json["bank_details_added"],
        tdsDeductionPercentage: json["tds_deduction_percentage"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "earn_amount": earnAmount,
        "deduct_amount": deductAmount,
        "request_pending": requestPending,
        "total_withdraw_amount": total_withdraw_amount,
        "kyc_status": kycStatus,
        "bank_details_added": bankDetailsAdded,
        "tds_deduction_percentage": tdsDeductionPercentage,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? firstName;
  String? lastName;
  String? mobile;

  Datum({
    this.firstName,
    this.lastName,
    this.mobile,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        firstName: json["first_name"],
        lastName: json["last_name"],
        mobile: json["mobile"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "mobile": mobile,
      };
}
