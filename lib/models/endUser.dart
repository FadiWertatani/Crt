// To parse this JSON data, do
//
//     final endUser = endUserFromJson(jsonString);

import 'dart:convert';

EndUser endUserFromJson(String str) => EndUser.fromJson(json.decode(str));

String endUserToJson(EndUser data) => json.encode(data.toJson());

class EndUser {
  EndUser({
    required this.uId,
    this.email,
    this.name,
    this.phoneNumber,
  });

  String uId;
  String? email;
  String? name;
  String? phoneNumber;

  factory EndUser.fromJson(Map<String, dynamic> json) => EndUser(
    uId: json["uId"],
    name: json["name"],
    phoneNumber: json["phoneNumber"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "uId": uId,
    "name": name,
    "phoneNumber": phoneNumber,
    "email": email,
  };
}
