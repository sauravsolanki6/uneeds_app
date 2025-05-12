// To parse this JSON data, do
//
//     final getaddressresponse = getaddressresponseFromJson(jsonString);

import 'dart:convert';

List<Getaddressresponse> getaddressresponseFromJson(String str) =>
    List<Getaddressresponse>.from(
        json.decode(str).map((x) => Getaddressresponse.fromJson(x)));

String getaddressresponseToJson(List<Getaddressresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Getaddressresponse {
  String? status;
  String? message;
  Data? data;

  Getaddressresponse({
    this.status,
    this.message,
    this.data,
  });

  factory Getaddressresponse.fromJson(Map<String, dynamic> json) =>
      Getaddressresponse(
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
  String? name;
  String? mobile;
  String? country;
  String? state;
  String? city;
  String? taluka;
  String? pincode;
  dynamic region;
  dynamic landmark;
  String? address;
  String? status;
  String? isDeleted;
  DateTime? createdOn;
  DateTime? updatedOn;
  String? countryName;
  String? stateName;
  String? cityName;

  Data({
    this.id,
    this.customerId,
    this.name,
    this.mobile,
    this.country,
    this.state,
    this.city,
    this.taluka,
    this.pincode,
    this.region,
    this.landmark,
    this.address,
    this.status,
    this.isDeleted,
    this.createdOn,
    this.updatedOn,
    this.countryName,
    this.stateName,
    this.cityName,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        customerId: json["customer_id"],
        name: json["name"],
        mobile: json["mobile"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        taluka: json["taluka"],
        pincode: json["pincode"],
        region: json["region"],
        landmark: json["landmark"],
        address: json["address"],
        status: json["status"],
        isDeleted: json["is_deleted"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        updatedOn: json["updated_on"] == null
            ? null
            : DateTime.parse(json["updated_on"]),
        countryName: json["country_name"],
        stateName: json["state_name"],
        cityName: json["city_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "name": name,
        "mobile": mobile,
        "country": country,
        "state": state,
        "city": city,
        "taluka": taluka,
        "pincode": pincode,
        "region": region,
        "landmark": landmark,
        "address": address,
        "status": status,
        "is_deleted": isDeleted,
        "created_on": createdOn?.toIso8601String(),
        "updated_on": updatedOn?.toIso8601String(),
        "country_name": countryName,
        "state_name": stateName,
        "city_name": cityName,
      };
}
