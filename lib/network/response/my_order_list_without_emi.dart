// To parse this JSON data, do
//
//     final myorderwithoutemiresponse = myorderwithoutemiresponseFromJson(jsonString);

import 'dart:convert';

List<Myorderwithoutemiresponse> myorderwithoutemiresponseFromJson(String str) =>
    List<Myorderwithoutemiresponse>.from(
        json.decode(str).map((x) => Myorderwithoutemiresponse.fromJson(x)));

String myorderwithoutemiresponseToJson(List<Myorderwithoutemiresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Myorderwithoutemiresponse {
  String? status;
  String? message;
  List<MyorderwithoutemiDatum>? data;

  Myorderwithoutemiresponse({
    this.status,
    this.message,
    this.data,
  });

  factory Myorderwithoutemiresponse.fromJson(Map<String, dynamic> json) =>
      Myorderwithoutemiresponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<MyorderwithoutemiDatum>.from(
                json["data"]!.map((x) => MyorderwithoutemiDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class MyorderwithoutemiDatum {
  String? id;
  String? addToCartId;
  String? productId;
  dynamic outwardId;
  String? custId;
  String? addressId;
  String? orderType;
  dynamic price;
  String? couponId;
  String? discount;
  String? shippingCharge;
  String? quantity;
  String? totalTax;
  String? totalPrice;
  String? emi;
  dynamic emiMonth;
  dynamic emiRate;
  String? invoiceNumber;
  String? orderStatus;
  dynamic orderStatusUpdateDate;
  dynamic cancelledBy;
  dynamic cancelReason;
  dynamic cancelDate;
  dynamic deliveryBoyId;
  dynamic courierNumber;
  dynamic shipDate;
  dynamic deliveryDate;
  dynamic deliveryCharges;
  String? paymentStatus;
  DateTime? paymentDate;
  String? payVia;
  String? transactionNumber;
  dynamic referenceNumber;
  dynamic stripeReceiptUrl;
  String? status;
  String? isDeleted;
  DateTime? createdOn;
  DateTime? updatedOn;
  String? productSlug;
  String? image;
  String? productInGram;
  String? productPricePerGram;
  String? image_path;
  MyorderwithoutemiDatum({
    this.id,
    this.addToCartId,
    this.productId,
    this.outwardId,
    this.custId,
    this.addressId,
    this.orderType,
    this.price,
    this.couponId,
    this.discount,
    this.shippingCharge,
    this.quantity,
    this.totalTax,
    this.totalPrice,
    this.emi,
    this.emiMonth,
    this.emiRate,
    this.invoiceNumber,
    this.orderStatus,
    this.orderStatusUpdateDate,
    this.cancelledBy,
    this.cancelReason,
    this.cancelDate,
    this.deliveryBoyId,
    this.courierNumber,
    this.shipDate,
    this.deliveryDate,
    this.deliveryCharges,
    this.paymentStatus,
    this.paymentDate,
    this.payVia,
    this.transactionNumber,
    this.referenceNumber,
    this.stripeReceiptUrl,
    this.status,
    this.isDeleted,
    this.createdOn,
    this.updatedOn,
    this.productSlug,
    this.image,
    this.productInGram,
    this.productPricePerGram,
    this.image_path,
  });

  factory MyorderwithoutemiDatum.fromJson(Map<String, dynamic> json) =>
      MyorderwithoutemiDatum(
        id: json["id"],
        addToCartId: json["add_to_cart_id"],
        productId: json["product_id"],
        outwardId: json["outward_id"],
        custId: json["cust_id"],
        addressId: json["address_id"],
        orderType: json["order_type"],
        price: json["price"],
        couponId: json["coupon_id"],
        discount: json["discount"],
        shippingCharge: json["shipping_charge"],
        quantity: json["quantity"],
        totalTax: json["total_tax"],
        totalPrice: json["total_price"],
        emi: json["emi"],
        emiMonth: json["emi_month"],
        emiRate: json["emi_rate"],
        invoiceNumber: json["invoice_number"],
        orderStatus: json["order_status"],
        orderStatusUpdateDate: json["order_status_update_date"],
        cancelledBy: json["cancelled_by"],
        cancelReason: json["cancel_reason"],
        cancelDate: json["cancel_date"],
        deliveryBoyId: json["delivery_boy_id"],
        courierNumber: json["courier_number"],
        shipDate: json["ship_date"],
        deliveryDate: json["delivery_date"],
        deliveryCharges: json["delivery_charges"],
        paymentStatus: json["payment_status"],
        paymentDate: json["payment_date"] == null
            ? null
            : DateTime.parse(json["payment_date"]),
        payVia: json["pay_via"],
        transactionNumber: json["transaction_number"],
        referenceNumber: json["reference_number"],
        stripeReceiptUrl: json["stripe_receipt_url"],
        status: json["status"],
        isDeleted: json["is_deleted"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        updatedOn: json["updated_on"] == null
            ? null
            : DateTime.parse(json["updated_on"]),
        productSlug: json["product_slug"],
        image: json["image"],
        productInGram: json["product_in_gram"],
        productPricePerGram: json["product_price_per_gram"],
        image_path: json["image_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "add_to_cart_id": addToCartId,
        "product_id": productId,
        "outward_id": outwardId,
        "cust_id": custId,
        "address_id": addressId,
        "order_type": orderType,
        "price": price,
        "coupon_id": couponId,
        "discount": discount,
        "shipping_charge": shippingCharge,
        "quantity": quantity,
        "total_tax": totalTax,
        "total_price": totalPrice,
        "emi": emi,
        "emi_month": emiMonth,
        "emi_rate": emiRate,
        "invoice_number": invoiceNumber,
        "order_status": orderStatus,
        "order_status_update_date": orderStatusUpdateDate,
        "cancelled_by": cancelledBy,
        "cancel_reason": cancelReason,
        "cancel_date": cancelDate,
        "delivery_boy_id": deliveryBoyId,
        "courier_number": courierNumber,
        "ship_date": shipDate,
        "delivery_date": deliveryDate,
        "delivery_charges": deliveryCharges,
        "payment_status": paymentStatus,
        "payment_date": paymentDate?.toIso8601String(),
        "pay_via": payVia,
        "transaction_number": transactionNumber,
        "reference_number": referenceNumber,
        "stripe_receipt_url": stripeReceiptUrl,
        "status": status,
        "is_deleted": isDeleted,
        "created_on": createdOn?.toIso8601String(),
        "updated_on": updatedOn?.toIso8601String(),
        "product_slug": productSlug,
        "image": image,
        "product_in_gram": productInGram,
        "product_price_per_gram": productPricePerGram,
        "image_path": image_path,
      };
}
