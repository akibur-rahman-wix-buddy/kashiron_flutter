import 'dart:convert';

VipProfileListModel vipProfileListModelFromJson(String str) =>
    VipProfileListModel.fromJson(json.decode(str));

String vipProfileListModelToJson(VipProfileListModel data) =>
    json.encode(data.toJson());

class VipProfileListModel {
  final bool? success;
  final String? message;
  final List<Datum>? data;
  final int? code;

  VipProfileListModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory VipProfileListModel.fromJson(Map<String, dynamic> json) =>
      VipProfileListModel(
        success: json["success"] as bool? ?? false,
        message: json["message"] as String? ?? "",
        data: (json["data"] as List<dynamic>?)
                ?.map((x) => Datum.fromJson(x))
                .toList() ??
            [],
        code: json["code"] as int? ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "code": code,
      };
}

class Datum {
  final String name;
  final List<Vip> vips;
  final int? id;

  Datum({
    required this.name,
    required this.vips,
    this.id,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        name: json["name"] as String? ?? "",
        vips: (json["vips"] as List<dynamic>?)
                ?.map((x) => Vip.fromJson(x))
                .toList() ??
            [],
        id: json["id"] as int?,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "vips": List<dynamic>.from(vips.map((x) => x.toJson())),
        "id": id,
      };
}

class Vip {
  final int id;
  final String name;
  final String avatar;
  final Relation relation;
  final BirthDate birthDate;
  final String nextBirthday;
  final double daysUntilBirthday;
  final int sparkCount;
  final String? anniversaryDate;

  Vip({
    required this.id,
    required this.name,
    required this.avatar,
    required this.relation,
    required this.birthDate,
    required this.nextBirthday,
    required this.daysUntilBirthday,
    required this.sparkCount,
    this.anniversaryDate,
  });

  factory Vip.fromJson(Map<String, dynamic> json) => Vip(
        id: json["id"] as int? ?? 0,
        name: json["name"] as String? ?? "",
        avatar: json["avatar"] as String? ?? "",
        relation: Relation.fromJson(json["relation"] ?? {}),
        birthDate: BirthDate.fromJson(json["birth_date"] ?? {}),
        nextBirthday: json["next_birthday"] as String? ?? "",
        daysUntilBirthday:
            (json["days_until_birthday"] as num?)?.toDouble() ?? 0.0,
        sparkCount: json["spark_count"] as int? ?? 0,
        anniversaryDate: json["anniversary_date"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatar": avatar,
        "relation": relation.toJson(),
        "birth_date": birthDate.toJson(),
        "next_birthday": nextBirthday,
        "days_until_birthday": daysUntilBirthday,
        "spark_count": sparkCount,
        "anniversary_date": anniversaryDate,
      };
}

class Relation {
  final int id;
  final String name;

  Relation({
    required this.id,
    required this.name,
  });

  factory Relation.fromJson(Map<String, dynamic> json) => Relation(
        id: json["id"] as int? ?? 0,
        name: json["name"] as String? ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class BirthDate {
  final String formatted;
  final String display;
  final int age;

  BirthDate({
    required this.formatted,
    required this.display,
    required this.age,
  });

  factory BirthDate.fromJson(Map<String, dynamic> json) => BirthDate(
        formatted: json["formatted"] as String? ?? "",
        display: json["display"] as String? ?? "",
        age: json["age"] as int? ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "formatted": formatted,
        "display": display,
        "age": age,
      };
}
