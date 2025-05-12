// To parse this JSON data, do
//
//     final emireceiptresponse = emireceiptresponseFromJson(jsonString);

import 'dart:convert';

List<Emireceiptresponse> emireceiptresponseFromJson(String str) =>
    List<Emireceiptresponse>.from(
        json.decode(str).map((x) => Emireceiptresponse.fromJson(x)));

String emireceiptresponseToJson(List<Emireceiptresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Emireceiptresponse {
  String? status;
  String? message;
  List<EmireceiptresponseDatum>? data;

  Emireceiptresponse({
    this.status,
    this.message,
    this.data,
  });

  factory Emireceiptresponse.fromJson(Map<String, dynamic> json) =>
      Emireceiptresponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<EmireceiptresponseDatum>.from(
                json["data"]!.map((x) => EmireceiptresponseDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class EmireceiptresponseDatum {
  String? id;
  String? customerId;
  dynamic addressId;
  String? orderId;
  DateTime? paymentDate;
  String? paymentAmount;
  String? paymentStatus;
  dynamic transactionNumber;
  DateTime? paidDate;
  String? payVia;
  dynamic transactionId;
  dynamic referenceNumber;
  String? paymentType;
  String? purhcaseGram;
  String? emiMonth;
  String? installmentMonth;
  String? isDeleted;
  String? status;
  DateTime? createdOn;
  DateTime? updatedOn;
  String? country;
  String? cities;
  String? state;
  String? name;
  String? mobile;
  String? pincode;
  dynamic region;
  dynamic landmark;
  String? address;

  EmireceiptresponseDatum({
    this.id,
    this.customerId,
    this.addressId,
    this.orderId,
    this.paymentDate,
    this.paymentAmount,
    this.paymentStatus,
    this.transactionNumber,
    this.paidDate,
    this.payVia,
    this.transactionId,
    this.referenceNumber,
    this.paymentType,
    this.purhcaseGram,
    this.emiMonth,
    this.installmentMonth,
    this.isDeleted,
    this.status,
    this.createdOn,
    this.updatedOn,
    this.country,
    this.cities,
    this.state,
    this.name,
    this.mobile,
    this.pincode,
    this.region,
    this.landmark,
    this.address,
  });

  factory EmireceiptresponseDatum.fromJson(Map<String, dynamic> json) =>
      EmireceiptresponseDatum(
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
        paidDate: json["paid_date"] == null
            ? null
            : DateTime.parse(json["paid_date"]),
        payVia: json["pay_via"],
        transactionId: json["transaction_id"],
        referenceNumber: json["reference_number"],
        paymentType: json["payment_type"],
        purhcaseGram: json["purhcase_gram"],
        emiMonth: json["emi_month"],
        installmentMonth: json["installment_month"],
        isDeleted: json["is_deleted"],
        status: json["status"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        updatedOn: json["updated_on"] == null
            ? null
            : DateTime.parse(json["updated_on"]),
        country: json["country"],
        cities: json["cities"],
        state: json["state"],
        name: json["name"],
        mobile: json["mobile"],
        pincode: json["pincode"],
        region: json["region"],
        landmark: json["landmark"],
        address: json["address"],
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
        "paid_date": paidDate?.toIso8601String(),
        "pay_via": payVia,
        "transaction_id": transactionId,
        "reference_number": referenceNumber,
        "payment_type": paymentType,
        "purhcase_gram": purhcaseGram,
        "emi_month": emiMonth,
        "installment_month": installmentMonth,
        "is_deleted": isDeleted,
        "status": status,
        "created_on": createdOn?.toIso8601String(),
        "updated_on": updatedOn?.toIso8601String(),
        "country": country,
        "cities": cities,
        "state": state,
        "name": name,
        "mobile": mobile,
        "pincode": pincode,
        "region": region,
        "landmark": landmark,
        "address": address,
      };
}
