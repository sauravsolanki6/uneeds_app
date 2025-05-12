// To parse this JSON data, do
//
//     final trackemiorderresponse = trackemiorderresponseFromJson(jsonString);

import 'dart:convert';

List<Trackemiorderresponse> trackemiorderresponseFromJson(String str) =>
    List<Trackemiorderresponse>.from(
        json.decode(str).map((x) => Trackemiorderresponse.fromJson(x)));

String trackemiorderresponseToJson(List<Trackemiorderresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Trackemiorderresponse {
  String? status;
  String? message;
  Data? data;

  Trackemiorderresponse({
    this.status,
    this.message,
    this.data,
  });

  factory Trackemiorderresponse.fromJson(Map<String, dynamic> json) =>
      Trackemiorderresponse(
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
  String? emiInvoiceId;
  String? orderStatus;
  DateTime? orderStatusUpdateDate;
  String? remark;
  String? isDeleted;
  String? status;
  DateTime? createdOn;
  DateTime? updatedOn;

  Data({
    this.id,
    this.emiInvoiceId,
    this.orderStatus,
    this.orderStatusUpdateDate,
    this.remark,
    this.isDeleted,
    this.status,
    this.createdOn,
    this.updatedOn,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        emiInvoiceId: json["emi_invoice_id"],
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
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "emi_invoice_id": emiInvoiceId,
        "order_status": orderStatus,
        "order_status_update_date": orderStatusUpdateDate?.toIso8601String(),
        "remark": remark,
        "is_deleted": isDeleted,
        "status": status,
        "created_on": createdOn?.toIso8601String(),
        "updated_on": updatedOn?.toIso8601String(),
      };
}
