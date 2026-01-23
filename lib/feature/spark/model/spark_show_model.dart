import 'dart:convert';

class SparkShowModel {
  bool? success;
  String? message;
  Data? data;
  int? code;

  SparkShowModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory SparkShowModel.fromRawJson(String str) =>
      SparkShowModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SparkShowModel.fromJson(Map<String, dynamic> json) => SparkShowModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
        "code": code,
      };
}

class Data {
  int? id;
  String? title;
  String? description;
  String? dateTime;
  String? formattedDate;
  String? time;
  String? daysStatus;
  bool? isToday;
  bool? isPast;
  bool? isUpcoming;
  bool? isSelf;
  CreatedBy? createdBy;
  Vip? vip;

  Data({
    this.id,
    this.title,
    this.description,
    this.dateTime,
    this.formattedDate,
    this.time,
    this.daysStatus,
    this.isToday,
    this.isPast,
    this.isUpcoming,
    this.isSelf,
    this.createdBy,
    this.vip,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        dateTime: json["date_time"],
        formattedDate: json["formatted_date"],
        time: json["time"],
        daysStatus: json["days_status"],
        isToday: json["is_today"],
        isPast: json["is_past"],
        isUpcoming: json["is_upcoming"],
        isSelf: json["is_self"],
        createdBy: json["created_by"] == null
            ? null
            : CreatedBy.fromJson(json["created_by"]),
        vip: json["vip"] == null ? null : Vip.fromJson(json["vip"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "date_time": dateTime,
        "formatted_date": formattedDate,
        "time": time,
        "days_status": daysStatus,
        "is_today": isToday,
        "is_past": isPast,
        "is_upcoming": isUpcoming,
        "is_self": isSelf,
        "created_by": createdBy?.toJson(),
        "vip": vip?.toJson(),
      };
}

class CreatedBy {
  int? id;
  String? name;
  String? avatar;

  CreatedBy({
    this.id,
    this.name,
    this.avatar,
  });

  factory CreatedBy.fromRawJson(String str) =>
      CreatedBy.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        id: json["id"],
        name: json["name"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatar": avatar,
      };
}

class Vip {
  int? id;
  String? name;
  String? avatar;
  String? phone;
  Relation? relation;
  String? specialNotes;
  dynamic anniversaryDate;

  Vip({
    this.id,
    this.name,
    this.avatar,
    this.phone,
    this.relation,
    this.specialNotes,
    this.anniversaryDate,
  });

  factory Vip.fromRawJson(String str) => Vip.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Vip.fromJson(Map<String, dynamic> json) => Vip(
        id: json["id"],
        name: json["name"],
        avatar: json["avatar"],
        phone: json["phone"],
        relation: json["relation"] == null
            ? null
            : Relation.fromJson(json["relation"]),
        specialNotes: json["special_notes"],
        anniversaryDate: json["anniversary_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatar": avatar,
        "phone": phone,
        "relation": relation?.toJson(),
        "special_notes": specialNotes,
        "anniversary_date": anniversaryDate,
      };
}

class Relation {
  int? id;
  String? name;
  Category? category;

  Relation({
    this.id,
    this.name,
    this.category,
  });

  factory Relation.fromRawJson(String str) =>
      Relation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Relation.fromJson(Map<String, dynamic> json) => Relation(
        id: json["id"],
        name: json["name"],
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category": category?.toJson(),
      };
}

class Category {
  int? id;
  String? name;

  Category({
    this.id,
    this.name,
  });

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
