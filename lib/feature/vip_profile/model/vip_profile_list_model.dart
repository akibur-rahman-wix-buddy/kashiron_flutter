// To parse this JSON data, do
//
//     final vipProfileListModel = vipProfileListModelFromJson(jsonString);

import 'dart:convert';

VipProfileListModel vipProfileListModelFromJson(String str) =>
    VipProfileListModel.fromJson(json.decode(str));

String vipProfileListModelToJson(VipProfileListModel data) =>
    json.encode(data.toJson());

class VipProfileListModel {
  bool? success;
  String? message;
  List<Datum>? data;
  int? code;

  VipProfileListModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory VipProfileListModel.fromJson(Map<String, dynamic> json) =>
      VipProfileListModel(
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
  String name;
  List<Vip> vips;
  int? id;

  Datum({
    required this.name,
    required this.vips,
    this.id,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        name: json["name"],
        vips: List<Vip>.from(json["vips"].map((x) => Vip.fromJson(x))),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "vips": List<dynamic>.from(vips.map((x) => x.toJson())),
        "id": id,
      };
}

class Vip {
  int id;
  String name;
  String avatar;
  Relation relation;
  int sparkCount;
  DateTime? anniversaryDate;

  Vip({
    required this.id,
    required this.name,
    required this.avatar,
    required this.relation,
    required this.sparkCount,
    required this.anniversaryDate,
  });

  factory Vip.fromJson(Map<String, dynamic> json) => Vip(
        id: json["id"],
        name: json["name"],
        avatar: json["avatar"],
        relation: Relation.fromJson(json["relation"]),
        sparkCount: json["spark_count"],
        anniversaryDate: json["anniversary_date"] == null
            ? null
            : DateTime.parse(json["anniversary_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatar": avatar,
        "relation": relation.toJson(),
        "spark_count": sparkCount,
        "anniversary_date": anniversaryDate?.toIso8601String(),
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
