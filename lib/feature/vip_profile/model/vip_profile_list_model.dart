import 'dart:convert';

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

  factory VipProfileListModel.fromRawJson(String str) =>
      VipProfileListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VipProfileListModel.fromJson(Map<String, dynamic> json) =>
      VipProfileListModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "code": code,
      };
}

class Datum {
  int? id;
  String? name;
  List<Vip>? vips;

  Datum({
    this.id,
    this.name,
    this.vips,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        vips: json["vips"] == null
            ? []
            : List<Vip>.from(json["vips"]!.map((x) => Vip.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "vips": vips == null
            ? []
            : List<dynamic>.from(vips!.map((x) => x.toJson())),
      };
}

class Vip {
  int? id;
  String? name;
  String? avatar;
  Relation? relation;
  int? sparkCount;
  DateTime? anniversaryDate;

  Vip({
    this.id,
    this.name,
    this.avatar,
    this.relation,
    this.sparkCount,
    this.anniversaryDate,
  });

  factory Vip.fromRawJson(String str) => Vip.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Vip.fromJson(Map<String, dynamic> json) => Vip(
        id: json["id"],
        name: json["name"],
        avatar: json["avatar"],
        relation: json["relation"] == null
            ? null
            : Relation.fromJson(json["relation"]),
        sparkCount: json["spark_count"],
        anniversaryDate: json["anniversary_date"] == null
            ? null
            : DateTime.parse(json["anniversary_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatar": avatar,
        "relation": relation?.toJson(),
        "spark_count": sparkCount,
        "anniversary_date": anniversaryDate?.toIso8601String(),
      };
}

class Relation {
  int? id;
  String? name;

  Relation({
    this.id,
    this.name,
  });

  factory Relation.fromRawJson(String str) =>
      Relation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Relation.fromJson(Map<String, dynamic> json) => Relation(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
