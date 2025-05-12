// To parse this JSON data, do
//
//     final repaymentscheduleresponse = repaymentscheduleresponseFromJson(jsonString);

import 'dart:convert';

List<Repaymentscheduleresponse> repaymentscheduleresponseFromJson(String str) =>
    List<Repaymentscheduleresponse>.from(
        json.decode(str).map((x) => Repaymentscheduleresponse.fromJson(x)));

String repaymentscheduleresponseToJson(List<Repaymentscheduleresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Repaymentscheduleresponse {
  String? status;
  String? lateEmiCharge;
  String? lateEmiChargePaid;
  String? message;
  List<RepaymentscheduleresponseDatum>? data;

  Repaymentscheduleresponse({
    this.status,
    this.lateEmiCharge,
    this.lateEmiChargePaid,
    this.message,
    this.data,
  });

  factory Repaymentscheduleresponse.fromJson(Map<String, dynamic> json) =>
      Repaymentscheduleresponse(
        status: json["status"],
        lateEmiCharge: json["late_emi_charge"],
        lateEmiChargePaid: json["late_emi_charge_paid"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<RepaymentscheduleresponseDatum>.from(json["data"]!
                .map((x) => RepaymentscheduleresponseDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "late_emi_charge": lateEmiCharge,
        "late_emi_charge_paid": lateEmiChargePaid,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class RepaymentscheduleresponseDatum {
  String? id;
  String? customerId;
  String? addressId;
  String? orderId;
  DateTime? paymentDate;
  String? paymentAmount;
  String? paymentStatus;
  dynamic transactionNumber;
  dynamic referenceNumber;
  dynamic paidDate;
  String? payVia;
  dynamic paymentMethod;
  dynamic paymentTransactionIdentifier;
  dynamic merchantTransactionIdentifier;
  dynamic identifier;
  dynamic transactionId;
  String? paymentType;
  String? purhcaseGram;
  String? emiMonth;
  String? installmentMonth;
  dynamic remark;
  dynamic isSchedule;
  dynamic reason;
  dynamic isVerify;
  dynamic verifyReason;
  String? isDeleted;
  String? status;
  DateTime? createdOn;
  DateTime? updatedOn;

  RepaymentscheduleresponseDatum({
    this.id,
    this.customerId,
    this.addressId,
    this.orderId,
    this.paymentDate,
    this.paymentAmount,
    this.paymentStatus,
    this.transactionNumber,
    this.referenceNumber,
    this.paidDate,
    this.payVia,
    this.paymentMethod,
    this.paymentTransactionIdentifier,
    this.merchantTransactionIdentifier,
    this.identifier,
    this.transactionId,
    this.paymentType,
    this.purhcaseGram,
    this.emiMonth,
    this.installmentMonth,
    this.remark,
    this.isSchedule,
    this.reason,
    this.isVerify,
    this.verifyReason,
    this.isDeleted,
    this.status,
    this.createdOn,
    this.updatedOn,
  });

  factory RepaymentscheduleresponseDatum.fromJson(Map<String, dynamic> json) =>
      RepaymentscheduleresponseDatum(
        id: json["id"],
        customerId: json["customer_id"],
        addressId: json["address_id"],
        orderId: json["order_id"],
        paymentDate: json["payment_date"] == null
            ? null
            : DateTime.parse(json["payment_date"]),
        paymentAmount: json["payment_amount"],
        paymentStatus: json["payment_status"],
        transactionNumber: json["transaction_number"],
        referenceNumber: json["reference_number"],
        paidDate: json["paid_date"],
        payVia: json["pay_via"],
        paymentMethod: json["payment_method"],
        paymentTransactionIdentifier: json["payment_transaction_identifier"],
        merchantTransactionIdentifier: json["merchant_transaction_Identifier"],
        identifier: json["identifier"],
        transactionId: json["transaction_id"],
        paymentType: json["payment_type"],
        purhcaseGram: json["purhcase_gram"],
        emiMonth: json["emi_month"],
        installmentMonth: json["installment_month"],
        remark: json["remark"],
        isSchedule: json["is_schedule"],
        reason: json["reason"],
        isVerify: json["is_verify"],
        verifyReason: json["verify_reason"],
        isDeleted: json["is_deleted"],
        status: json["status"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        updatedOn: json["updated_on"] == null
            ? null
            : DateTime.parse(json["updated_on"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "address_id": addressId,
        "order_id": orderId,
        "payment_date": paymentDate?.toIso8601String(),
        "payment_amount": paymentAmount,
        "payment_status": paymentStatus,
        "transaction_number": transactionNumber,
        "reference_number": referenceNumber,
        "paid_date": paidDate,
        "pay_via": payVia,
        "payment_method": paymentMethod,
        "payment_transaction_identifier": paymentTransactionIdentifier,
        "merchant_transaction_Identifier": merchantTransactionIdentifier,
        "identifier": identifier,
        "transaction_id": transactionId,
        "payment_type": paymentType,
        "purhcase_gram": purhcaseGram,
        "emi_month": emiMonth,
        "installment_month": installmentMonth,
        "remark": remark,
        "is_schedule": isSchedule,
        "reason": reason,
        "is_verify": isVerify,
        "verify_reason": verifyReason,
        "is_deleted": isDeleted,
        "status": status,
        "created_on": createdOn?.toIso8601String(),
        "updated_on": updatedOn?.toIso8601String(),
      };
}
