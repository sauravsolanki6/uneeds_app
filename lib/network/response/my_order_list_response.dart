// To parse this JSON data, do
//
//     final myorderlistresponse = myorderlistresponseFromJson(jsonString);

import 'dart:convert';

List<Myorderlistresponse> myorderlistresponseFromJson(String str) =>
    List<Myorderlistresponse>.from(
        json.decode(str).map((x) => Myorderlistresponse.fromJson(x)));

String myorderlistresponseToJson(List<Myorderlistresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Myorderlistresponse {
  String? status;
  String? message;
  List<MyorderlistresponseDatum>? data;

  Myorderlistresponse({
    this.status,
    this.message,
    this.data,
  });

  factory Myorderlistresponse.fromJson(Map<String, dynamic> json) =>
      Myorderlistresponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<MyorderlistresponseDatum>.from(
                json["data"]!.map((x) => MyorderlistresponseDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class MyorderlistresponseDatum {
  String? id;
  String? addressId;
  String? customerId;
  String? tblEmiOrderId;
  String? totalAmount;
  String? firstEmiPay;
  String? paymentStatus;
  DateTime? paymentDate;
  dynamic payVia;
  String? orderStatus;
  dynamic orderStatusUpdateDate;
  dynamic orderId;
  String? invoiceNumber;
  dynamic transactionNumber;
  dynamic referenceNumber;
  String? showOrderCard;
  String? isDeleted;
  String? status;
  DateTime? createdOn;
  DateTime? updatedOn;
  String? processingFee;
  String? proceessGst;
  String? bookingAmt;
  String? makingCharges;
  String? makingGst;
  String? purchaseLiveRate;
  String? purchaseGram;
  String? purchaseAmt;
  String? emiMonth;
  String? emiAmtPerMonth;
  String? customerType;
  dynamic membershipFee;
  String? show_order_card;

  MyorderlistresponseDatum({
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
    this.processingFee,
    this.proceessGst,
    this.bookingAmt,
    this.makingCharges,
    this.makingGst,
    this.purchaseLiveRate,
    this.purchaseGram,
    this.purchaseAmt,
    this.emiMonth,
    this.emiAmtPerMonth,
    this.customerType,
    this.membershipFee,
    this.show_order_card,
  });

  factory MyorderlistresponseDatum.fromJson(Map<String, dynamic> json) =>
      MyorderlistresponseDatum(
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
        processingFee: json["processing_fee"],
        proceessGst: json["proceess_gst"],
        bookingAmt: json["booking_amt"],
        makingCharges: json["making_charges"],
        makingGst: json["making_gst"],
        purchaseLiveRate: json["purchase_live_rate"],
        purchaseGram: json["purchase_gram"],
        purchaseAmt: json["purchase_amt"],
        emiMonth: json["emi_month"],
        emiAmtPerMonth: json["emi_amt_per_month"],
        customerType: json["customer_type"],
        membershipFee: json["membership_fee"],
        show_order_card: json["show_order_card"],
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
        "processing_fee": processingFee,
        "proceess_gst": proceessGst,
        "booking_amt": bookingAmt,
        "making_charges": makingCharges,
        "making_gst": makingGst,
        "purchase_live_rate": purchaseLiveRate,
        "purchase_gram": purchaseGram,
        "purchase_amt": purchaseAmt,
        "emi_month": emiMonth,
        "emi_amt_per_month": emiAmtPerMonth,
        "customer_type": customerType,
        "membership_fee": membershipFee,
        "show_order_card": show_order_card,
      };
}
