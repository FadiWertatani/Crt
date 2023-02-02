// To parse this JSON data, do
//
//     final busModel = busModelFromJson(jsonString);

import 'dart:convert';

DateModel busModelFromJson(String str) => DateModel.fromJson(json.decode(str));

String busModelToJson(DateModel data) => json.encode(data.toJson());

class DateModel {
  DateModel({
    this.date,
  });

  String? date;

  factory DateModel.fromJson(Map<String, dynamic> json) => DateModel(
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "date": date,
  };
}
