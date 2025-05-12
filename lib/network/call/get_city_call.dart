// To parse this JSON data, do
//
//     final getcitycall = getcitycallFromJson(jsonString);

import 'dart:convert';

Getcitycall getcitycallFromJson(String str) =>
    Getcitycall.fromJson(json.decode(str));

String getcitycallToJson(Getcitycall data) => json.encode(data.toJson());

class Getcitycall {
  String? stateId;

  Getcitycall({
    this.stateId,
  });

  factory Getcitycall.fromJson(Map<String, dynamic> json) => Getcitycall(
        stateId: json["state_id"],
      );

  Map<String, dynamic> toJson() => {
        "state_id": stateId,
      };
}
