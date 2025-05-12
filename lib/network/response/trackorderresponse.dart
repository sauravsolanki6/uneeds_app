// To parse this JSON data, do
//
//     final trackorderresponse = trackorderresponseFromJson(jsonString);

import 'dart:convert';

List<Trackorderresponse> trackorderresponseFromJson(String str) =>
    List<Trackorderresponse>.from(
        json.decode(str).map((x) => Trackorderresponse.fromJson(x)));

String trackorderresponseToJson(List<Trackorderresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Trackorderresponse {
  String? status;
  String? message;
  List<Datum>? data;

  Trackorderresponse({
    this.status,
    this.message,
    this.data,
  });

  factory Trackorderresponse.fromJson(Map<String, dynamic> json) =>
      Trackorderresponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? id;
  String? tblInvoiceId;
  String? orderStatus;
  DateTime? orderStatusUpdateDate;
  String? remark;
  String? isDeleted;
  String? status;
  DateTime? createdOn;
  DateTime? updatedOn;
  String? totalPrice;
  DateTime? placedOn;
  String? invoiceNumber;

  Datum({
    this.id,
    this.tblInvoiceId,
    this.orderStatus,
    this.orderStatusUpdateDate,
    this.remark,
    this.isDeleted,
    this.status,
    this.createdOn,
    this.updatedOn,
    this.totalPrice,
    this.placedOn,
    this.invoiceNumber,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        tblInvoiceId: json["tbl_invoice_id"],
        orderStatus: json["order_status"],
        orderStatusUpdateDate: json["order_status_update_date"] == null
            ? null
            : DateTime.parse(json["order_status_update_date"]),
        remark: json["remark"],
        isDeleted: json["is_deleted"],
        status: json["status"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        updatedOn: json["updated_on"] == null
            ? null
            : DateTime.parse(json["updated_on"]),
        totalPrice: json["total_price"],
        placedOn: json["placed_on"] == null
            ? null
            : DateTime.parse(json["placed_on"]),
        invoiceNumber: json["invoice_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tbl_invoice_id": tblInvoiceId,
        "order_status": orderStatus,
        "order_status_update_date": orderStatusUpdateDate?.toIso8601String(),
        "remark": remark,
        "is_deleted": isDeleted,
        "status": status,
        "created_on": createdOn?.toIso8601String(),
        "updated_on": updatedOn?.toIso8601String(),
        "total_price": totalPrice,
        "placed_on": placedOn?.toIso8601String(),
        "invoice_number": invoiceNumber,
      };
}
