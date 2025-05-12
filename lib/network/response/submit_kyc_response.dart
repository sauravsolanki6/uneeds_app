// To parse this JSON data, do
//
//     final submitkycresponse = submitkycresponseFromJson(jsonString);

import 'dart:convert';

List<Submitkycresponse> submitkycresponseFromJson(String str) =>
    List<Submitkycresponse>.from(
        json.decode(str).map((x) => Submitkycresponse.fromJson(x)));

String submitkycresponseToJson(List<Submitkycresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Submitkycresponse {
  String? status;
  String? message;
  Data? data;

  Submitkycresponse({
    this.status,
    this.message,
    this.data,
  });

  factory Submitkycresponse.fromJson(Map<String, dynamic> json) =>
      Submitkycresponse(
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
  String? customerId;
  String? aadharFront;
  String? aadharBack;
  String? panFront;
  String? panBack;
  String? acceptAgreement;
  String? kycStatus;
  String? status;
  String? isDeleted;
  DateTime? createdOn;
  DateTime? updatedOn;
  String? kyc;

  Data({
    this.id,
    this.customerId,
    this.aadharFront,
    this.aadharBack,
    this.panFront,
    this.panBack,
    this.acceptAgreement,
    this.kycStatus,
    this.status,
    this.isDeleted,
    this.createdOn,
    this.updatedOn,
    this.kyc,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        customerId: json["customer_id"],
        aadharFront: json["aadhar_front"],
        aadharBack: json["aadhar_back"],
        panFront: json["pan_front"],
        panBack: json["pan_back"],
        acceptAgreement: json["accept_agreement"],
        kycStatus: json["kyc_status"],
        status: json["status"],
        isDeleted: json["is_deleted"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        updatedOn: json["updated_on"] == null
            ? null
            : DateTime.parse(json["updated_on"]),
        kyc: json["kyc"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "aadhar_front": aadharFront,
        "aadhar_back": aadharBack,
        "pan_front": panFront,
        "pan_back": panBack,
        "accept_agreement": acceptAgreement,
        "kyc_status": kycStatus,
        "status": status,
        "is_deleted": isDeleted,
        "created_on": createdOn?.toIso8601String(),
        "updated_on": updatedOn?.toIso8601String(),
        "kyc": kyc,
      };
}
