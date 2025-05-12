// To parse this JSON data, do
//
//     final addnomineedetailscall = addnomineedetailscallFromJson(jsonString);

import 'dart:convert';

Addnomineedetailscall addnomineedetailscallFromJson(String str) =>
    Addnomineedetailscall.fromJson(json.decode(str));

String addnomineedetailscallToJson(Addnomineedetailscall data) =>
    json.encode(data.toJson());

class Addnomineedetailscall {
  String? customerId;
  String? nomineeName;
  String? nomineeContact;
  String? nomineeAge;
  String? relationWithCustomer;
  String? nomineeAddress;

  Addnomineedetailscall({
    this.customerId,
    this.nomineeName,
    this.nomineeContact,
    this.nomineeAge,
    this.relationWithCustomer,
    this.nomineeAddress,
  });

  factory Addnomineedetailscall.fromJson(Map<String, dynamic> json) =>
      Addnomineedetailscall(
        customerId: json["customer_id"],
        nomineeName: json["nominee_name"],
        nomineeContact: json["nominee_contact"],
        nomineeAge: json["nominee_age"],
        relationWithCustomer: json["relation_with_customer"],
        nomineeAddress: json["nominee_address"],
      );

  Map<String, dynamic> toJson() => {
        "customer_id": customerId,
        "nominee_name": nomineeName,
        "nominee_contact": nomineeContact,
        "nominee_age": nomineeAge,
        "relation_with_customer": relationWithCustomer,
        "nominee_address": nomineeAddress,
      };
}
