// To parse this JSON data, do
//
//     final vipProfileModel = vipProfileModelFromJson(jsonString);

import 'dart:convert';

VipProfileModel vipProfileModelFromJson(String str) =>
    VipProfileModel.fromJson(json.decode(str));

String vipProfileModelToJson(VipProfileModel data) =>
    json.encode(data.toJson());

class VipProfileModel {
  bool? success;
  String? message;
  Data? data;
  int? code;

  VipProfileModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory VipProfileModel.fromJson(Map<String, dynamic> json) =>
      VipProfileModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data!.toJson(),
        "code": code,
      };
}

class Data {
  int id;
  String name;
  String avatar;
  Relation relation;
  dynamic anniversaryDate;
  String specialNotes;
  List<Relation> selectedInterest;
  int sparkCount;
  List<dynamic> sparks;
  String birthday;
  String daysUntilBirthday;

  Data({
    required this.id,
    required this.name,
    required this.avatar,
    required this.relation,
    required this.anniversaryDate,
    required this.specialNotes,
    required this.selectedInterest,
    required this.sparkCount,
    required this.sparks,
    required this.birthday,
    required this.daysUntilBirthday,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        avatar: json["avatar"],
        relation: Relation.fromJson(json["relation"]),
        anniversaryDate: json["anniversary_date"],
        specialNotes: json["special_notes"],
        selectedInterest: List<Relation>.from(
            json["selected_interest"].map((x) => Relation.fromJson(x))),
        sparkCount: json["spark_count"],
        sparks: List<dynamic>.from(json["sparks"].map((x) => x)),
        birthday: json["birthday"],
        daysUntilBirthday: json["days_until_birthday"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatar": avatar,
        "relation": relation.toJson(),
        "anniversary_date": anniversaryDate,
        "special_notes": specialNotes,
        "selected_interest":
            List<dynamic>.from(selectedInterest.map((x) => x.toJson())),
        "spark_count": sparkCount,
        "sparks": List<dynamic>.from(sparks.map((x) => x)),
        "birthday": birthday,
        "days_until_birthday": daysUntilBirthday,
      };
}

class Relation {
  int id;
  String name;

  Relation({
    required this.id,
    required this.name,
  });

  factory Relation.fromJson(Map<String, dynamic> json) => Relation(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
