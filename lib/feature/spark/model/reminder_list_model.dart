// To parse this JSON data, do
//
//     final reminderListModel = reminderListModelFromJson(jsonString);

import 'dart:convert';

ReminderListModel reminderListModelFromJson(String str) =>
    ReminderListModel.fromJson(json.decode(str));

String reminderListModelToJson(ReminderListModel data) =>
    json.encode(data.toJson());

class ReminderListModel {
  bool? success;
  String? message;
  List<Datum>? data;
  int? code;

  ReminderListModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory ReminderListModel.fromJson(Map<String, dynamic> json) =>
      ReminderListModel(
        success: json["success"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "code": code,
      };
}

class Datum {
  int id;
  int sparkId;
  DateTime reminderDate;
  String reminderTime;
  DateTime createdAt;
  DateTime updatedAt;

  Datum({
    required this.id,
    required this.sparkId,
    required this.reminderDate,
    required this.reminderTime,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        sparkId: json["spark_id"],
        reminderDate: DateTime.parse(json["reminder_date"]),
        reminderTime: json["reminder_time"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "spark_id": sparkId,
        "reminder_date":
            "${reminderDate.year.toString().padLeft(4, '0')}-${reminderDate.month.toString().padLeft(2, '0')}-${reminderDate.day.toString().padLeft(2, '0')}",
        "reminder_time": reminderTime,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
