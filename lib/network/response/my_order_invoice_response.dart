// To parse this JSON data, do
//
//     final myorderinvoiceresponse = myorderinvoiceresponseFromJson(jsonString);

import 'dart:convert';

List<Myorderinvoiceresponse> myorderinvoiceresponseFromJson(String str) =>
    List<Myorderinvoiceresponse>.from(
        json.decode(str).map((x) => Myorderinvoiceresponse.fromJson(x)));

String myorderinvoiceresponseToJson(List<Myorderinvoiceresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Myorderinvoiceresponse {
  String? status;
  String? message;
  List<MyorderinvoiceDatum>? data;

  Myorderinvoiceresponse({
    this.status,
    this.message,
    this.data,
  });

  factory Myorderinvoiceresponse.fromJson(Map<String, dynamic> json) =>
      Myorderinvoiceresponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<MyorderinvoiceDatum>.from(
                json["data"]!.map((x) => MyorderinvoiceDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class MyorderinvoiceDatum {
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
  String? image;
  String? productName;
  String? makingCharge;
  String? makingGst;
  String? productPricePerGram;
  String? productType;
  String? productInGram;
  String? productGst;
  String? country;
  String? cities;
  String? state;
  String? name;
  String? mobile;
  String? pincode;
  String? address;
  String? image_path;

  MyorderinvoiceDatum({
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
    this.image,
    this.productName,
    this.makingCharge,
    this.makingGst,
    this.productPricePerGram,
    this.productType,
    this.productInGram,
    this.productGst,
    this.country,
    this.cities,
    this.state,
    this.name,
    this.mobile,
    this.address,
    this.pincode,
    this.image_path,
  });

  factory MyorderinvoiceDatum.fromJson(Map<String, dynamic> json) =>
      MyorderinvoiceDatum(
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
        image: json["image"],
        productName: json["product_name"],
        makingCharge: json["making_charge"],
        makingGst: json["making_gst"],
        productPricePerGram: json["product_price_per_gram"],
        productType: json["product_type"],
        productInGram: json["product_in_gram"],
        productGst: json["product_gst"],
        country: json["country"],
        cities: json["cities"],
        state: json["state"],
        name: json["name"],
        mobile: json["mobile"],
        pincode: json["pincode"],
        address: json["address"],
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
        "image": image,
        "product_name": productName,
        "making_charge": makingCharge,
        "making_gst": makingGst,
        "product_price_per_gram": productPricePerGram,
        "product_type": productType,
        "product_in_gram": productInGram,
        "product_gst": productGst,
        "country": country,
        "cities": cities,
        "state": state,
        "name": name,
        "mobile": mobile,
        "pincode": pincode,
        "address": address,
        "image_path": image_path
      };
}
