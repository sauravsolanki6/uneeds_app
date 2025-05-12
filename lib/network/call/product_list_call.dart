// To parse this JSON data, do
//
//     final productlistcall = productlistcallFromJson(jsonString);

import 'dart:convert';

Productlistcall productlistcallFromJson(String str) =>
    Productlistcall.fromJson(json.decode(str));

String productlistcallToJson(Productlistcall data) =>
    json.encode(data.toJson());

class Productlistcall {
  int? offset;
  int? limit;
  String? producttype;
  String? search_text;

  Productlistcall({
    this.offset,
    this.limit,
    this.producttype,
    this.search_text,
  });

  factory Productlistcall.fromJson(Map<String, dynamic> json) =>
      Productlistcall(
        offset: json["offset"],
        limit: json["limit"],
        producttype: json["producttype"],
        search_text: json["search_text"],
      );

  Map<String, dynamic> toJson() => {
        "offset": offset,
        "limit": limit,
        "producttype": producttype,
        "search_text": search_text
      };
}
