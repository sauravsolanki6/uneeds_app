// To parse this JSON data, do
//
//     final emiinvoiceresponse = emiinvoiceresponseFromJson(jsonString);

import 'dart:convert';

List<Emiinvoiceresponse> emiinvoiceresponseFromJson(String str) =>
    List<Emiinvoiceresponse>.from(
        json.decode(str).map((x) => Emiinvoiceresponse.fromJson(x)));

String emiinvoiceresponseToJson(List<Emiinvoiceresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Emiinvoiceresponse {
  String? status;
  String? message;
  List<EmiinvoiceresponseDatum>? data;

  Emiinvoiceresponse({
    this.status,
    this.message,
    this.data,
  });

  factory Emiinvoiceresponse.fromJson(Map<String, dynamic> json) =>
      Emiinvoiceresponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<EmiinvoiceresponseDatum>.from(
                json["data"]!.map((x) => EmiinvoiceresponseDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class EmiinvoiceresponseDatum {
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
  dynamic gstOnProduct;
  dynamic membershipFee;
  String? nextDueDate;
  String? country;
  String? cities;
  String? state;
  String? name;
  String? mobile;
  String? pincode;
  dynamic region;
  dynamic landmark;
  String? address;

  EmiinvoiceresponseDatum({
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
    this.gstOnProduct,
    this.membershipFee,
    this.nextDueDate,
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

  factory EmiinvoiceresponseDatum.fromJson(Map<String, dynamic> json) =>
      EmiinvoiceresponseDatum(
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
        gstOnProduct: json["gst_on_product"],
        membershipFee: json["membership_fee"],
        nextDueDate: json["next_due_date"],
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
        "gst_on_product": gstOnProduct,
        "membership_fee": membershipFee,
        "next_due_date": nextDueDate,
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
