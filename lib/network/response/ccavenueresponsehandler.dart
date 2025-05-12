// To parse this JSON data, do
//
//     final ccavenuresponsehandler = ccavenuresponsehandlerFromJson(jsonString);

import 'dart:convert';

Ccavenuresponsehandler ccavenuresponsehandlerFromJson(String str) =>
    Ccavenuresponsehandler.fromJson(json.decode(str));

String ccavenuresponsehandlerToJson(Ccavenuresponsehandler data) =>
    json.encode(data.toJson());

class Ccavenuresponsehandler {
  String? orderId;
  String? trackingId;
  String? bankRefNo;
  String? orderStatus;
  String? failureMessage;
  String? paymentMode;
  String? cardName;
  String? statusCode;
  String? statusMessage;
  String? currency;
  String? amount;
  String? billingName;
  String? billingAddress;
  String? billingCity;
  String? billingState;
  String? billingZip;
  String? billingCountry;
  String? billingTel;
  String? billingEmail;
  String? deliveryName;
  String? deliveryAddress;
  String? deliveryCity;
  String? deliveryState;
  String? deliveryZip;
  String? deliveryCountry;
  String? deliveryTel;
  String? merchantParam1;
  String? merchantParam2;
  String? merchantParam3;
  String? merchantParam4;
  String? merchantParam5;
  String? vault;
  String? offerType;
  String? offerCode;
  String? discountValue;
  String? merAmount;
  String? eciValue;
  String? retry;
  String? responseCode;
  String? billingNotes;
  String? transDate;
  String? binCountry;
  String? transFee;
  String? serviceTax;

  Ccavenuresponsehandler({
    this.orderId,
    this.trackingId,
    this.bankRefNo,
    this.orderStatus,
    this.failureMessage,
    this.paymentMode,
    this.cardName,
    this.statusCode,
    this.statusMessage,
    this.currency,
    this.amount,
    this.billingName,
    this.billingAddress,
    this.billingCity,
    this.billingState,
    this.billingZip,
    this.billingCountry,
    this.billingTel,
    this.billingEmail,
    this.deliveryName,
    this.deliveryAddress,
    this.deliveryCity,
    this.deliveryState,
    this.deliveryZip,
    this.deliveryCountry,
    this.deliveryTel,
    this.merchantParam1,
    this.merchantParam2,
    this.merchantParam3,
    this.merchantParam4,
    this.merchantParam5,
    this.vault,
    this.offerType,
    this.offerCode,
    this.discountValue,
    this.merAmount,
    this.eciValue,
    this.retry,
    this.responseCode,
    this.billingNotes,
    this.transDate,
    this.binCountry,
    this.transFee,
    this.serviceTax,
  });

  factory Ccavenuresponsehandler.fromJson(Map<String, dynamic> json) =>
      Ccavenuresponsehandler(
        orderId: json["order_id"],
        trackingId: json["tracking_id"],
        bankRefNo: json["bank_ref_no"],
        orderStatus: json["order_status"],
        failureMessage: json["failure_message"],
        paymentMode: json["payment_mode"],
        cardName: json["card_name"],
        statusCode: json["status_code"],
        statusMessage: json["status_message"],
        currency: json["currency"],
        amount: json["amount"],
        billingName: json["billing_name"],
        billingAddress: json["billing_address"],
        billingCity: json["billing_city"],
        billingState: json["billing_state"],
        billingZip: json["billing_zip"],
        billingCountry: json["billing_country"],
        billingTel: json["billing_tel"],
        billingEmail: json["billing_email"],
        deliveryName: json["delivery_name"],
        deliveryAddress: json["delivery_address"],
        deliveryCity: json["delivery_city"],
        deliveryState: json["delivery_state"],
        deliveryZip: json["delivery_zip"],
        deliveryCountry: json["delivery_country"],
        deliveryTel: json["delivery_tel"],
        merchantParam1: json["merchant_param1"],
        merchantParam2: json["merchant_param2"],
        merchantParam3: json["merchant_param3"],
        merchantParam4: json["merchant_param4"],
        merchantParam5: json["merchant_param5"],
        vault: json["vault"],
        offerType: json["offer_type"],
        offerCode: json["offer_code"],
        discountValue: json["discount_value"],
        merAmount: json["mer_amount"],
        eciValue: json["eci_value"],
        retry: json["retry"],
        responseCode: json["response_code"],
        billingNotes: json["billing_notes"],
        transDate: json["trans_date"],
        binCountry: json["bin_country"],
        transFee: json["trans_fee"],
        serviceTax: json["service_tax"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "tracking_id": trackingId,
        "bank_ref_no": bankRefNo,
        "order_status": orderStatus,
        "failure_message": failureMessage,
        "payment_mode": paymentMode,
        "card_name": cardName,
        "status_code": statusCode,
        "status_message": statusMessage,
        "currency": currency,
        "amount": amount,
        "billing_name": billingName,
        "billing_address": billingAddress,
        "billing_city": billingCity,
        "billing_state": billingState,
        "billing_zip": billingZip,
        "billing_country": billingCountry,
        "billing_tel": billingTel,
        "billing_email": billingEmail,
        "delivery_name": deliveryName,
        "delivery_address": deliveryAddress,
        "delivery_city": deliveryCity,
        "delivery_state": deliveryState,
        "delivery_zip": deliveryZip,
        "delivery_country": deliveryCountry,
        "delivery_tel": deliveryTel,
        "merchant_param1": merchantParam1,
        "merchant_param2": merchantParam2,
        "merchant_param3": merchantParam3,
        "merchant_param4": merchantParam4,
        "merchant_param5": merchantParam5,
        "vault": vault,
        "offer_type": offerType,
        "offer_code": offerCode,
        "discount_value": discountValue,
        "mer_amount": merAmount,
        "eci_value": eciValue,
        "retry": retry,
        "response_code": responseCode,
        "billing_notes": billingNotes,
        "trans_date": transDate,
        "bin_country": binCountry,
        "trans_fee": transFee,
        "service_tax": serviceTax,
      };
}
