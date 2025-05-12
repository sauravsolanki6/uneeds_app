// To parse this JSON data, do
//
//     final viewemiorderresponse = viewemiorderresponseFromJson(jsonString);

import 'dart:convert';

List<Viewemiorderresponse> viewemiorderresponseFromJson(String str) =>
    List<Viewemiorderresponse>.from(
        json.decode(str).map((x) => Viewemiorderresponse.fromJson(x)));

String viewemiorderresponseToJson(List<Viewemiorderresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Viewemiorderresponse {
  String? status;
  String? message;
  Data? data;

  Viewemiorderresponse({
    this.status,
    this.message,
    this.data,
  });

  factory Viewemiorderresponse.fromJson(Map<String, dynamic> json) =>
      Viewemiorderresponse(
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
  String? addressId;
  String? customerId;
  String? tblEmiOrderId;
  String? totalAmount;
  String? firstEmiPay;
  String? paymentStatus;
  DateTime? paymentDate;
  String? payVia;
  String? orderStatus;
  dynamic orderStatusUpdateDate;
  dynamic orderId;
  String? invoiceNumber;
  String? transactionNumber;
  String? referenceNumber;
  String? showOrderCard;
  String? isDeleted;
  String? status;
  DateTime? createdOn;
  DateTime? updatedOn;
  String? purchaseLiveRate;
  String? purchaseGram;

  Data({
    this.id,
    this.addressId,
    this.customerId,
    this.tblEmiOrderId,
    this.totalAmount,
    this.firstEmiPay,
    this.paymentStatus,
    this.paymentDate,
    this.payVia,
    this.orderStatus,
    this.orderStatusUpdateDate,
    this.orderId,
    this.invoiceNumber,
    this.transactionNumber,
    this.referenceNumber,
    this.showOrderCard,
    this.isDeleted,
    this.status,
    this.createdOn,
    this.updatedOn,
    this.purchaseLiveRate,
    this.purchaseGram,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        addressId: json["address_id"],
        customerId: json["customer_id"],
        tblEmiOrderId: json["tbl_emi_order_id"],
        totalAmount: json["total_amount"],
        firstEmiPay: json["first_emi_pay"],
        paymentStatus: json["payment_status"],
        paymentDate: json["payment_date"] == null
            ? null
            : DateTime.parse(json["payment_date"]),
        payVia: json["pay_via"],
        orderStatus: json["order_status"],
        orderStatusUpdateDate: json["order_status_update_date"],
        orderId: json["order_id"],
        invoiceNumber: json["invoice_number"],
        transactionNumber: json["transaction_number"],
        referenceNumber: json["reference_number"],
        showOrderCard: json["show_order_card"],
        isDeleted: json["is_deleted"],
        status: json["status"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        updatedOn: json["updated_on"] == null
            ? null
            : DateTime.parse(json["updated_on"]),
        purchaseLiveRate: json["purchase_live_rate"],
        purchaseGram: json["purchase_gram"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address_id": addressId,
        "customer_id": customerId,
        "tbl_emi_order_id": tblEmiOrderId,
        "total_amount": totalAmount,
        "first_emi_pay": firstEmiPay,
        "payment_status": paymentStatus,
        "payment_date":
            "${paymentDate!.year.toString().padLeft(4, '0')}-${paymentDate!.month.toString().padLeft(2, '0')}-${paymentDate!.day.toString().padLeft(2, '0')}",
        "pay_via": payVia,
        "order_status": orderStatus,
        "order_status_update_date": orderStatusUpdateDate,
        "order_id": orderId,
        "invoice_number": invoiceNumber,
        "transaction_number": transactionNumber,
        "reference_number": referenceNumber,
        "show_order_card": showOrderCard,
        "is_deleted": isDeleted,
        "status": status,
        "created_on": createdOn?.toIso8601String(),
        "updated_on": updatedOn?.toIso8601String(),
        "purchase_live_rate": purchaseLiveRate,
        "purchase_gram": purchaseGram,
      };
}
