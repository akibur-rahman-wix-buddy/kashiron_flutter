import 'dart:convert';

class UpcomingSparksModel {
  bool? success;
  String? message;
  List<Datum>? data;
  int? code;

  UpcomingSparksModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory UpcomingSparksModel.fromRawJson(String str) =>
      UpcomingSparksModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpcomingSparksModel.fromJson(Map<String, dynamic> json) =>
      UpcomingSparksModel(
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
  String? date;
  bool? isToday;
  bool? isTomorrow;
  List<Spark>? sparks;

  Datum({
    this.date,
    this.isToday,
    this.isTomorrow,
    this.sparks,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        date: json["date"],
        isToday: json["is_today"],
        isTomorrow: json["is_tomorrow"],
        sparks: json["sparks"] == null
            ? []
            : List<Spark>.from(json["sparks"]!.map((x) => Spark.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "is_today": isToday,
        "is_tomorrow": isTomorrow,
        "sparks": sparks == null
            ? []
            : List<dynamic>.from(sparks!.map((x) => x.toJson())),
      };
}

class Spark {
  int? id;
  String? title;
  String? description;
  String? time;
  String? dateTime;
  String? daysLeft;
  bool? isSelf;
  CreatedBy? vip;
  CreatedBy? createdBy;

  Spark({
    this.id,
    this.title,
    this.description,
    this.time,
    this.dateTime,
    this.daysLeft,
    this.isSelf,
    this.vip,
    this.createdBy,
  });

  factory Spark.fromRawJson(String str) => Spark.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Spark.fromJson(Map<String, dynamic> json) => Spark(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        time: json["time"],
        dateTime: json["date_time"],
        daysLeft: json["days_left"],
        isSelf: json["is_self"],
        vip: json["vip"] == null ? null : CreatedBy.fromJson(json["vip"]),
        createdBy: json["created_by"] == null
            ? null
            : CreatedBy.fromJson(json["created_by"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "time": time,
        "date_time": dateTime,
        "days_left": daysLeft,
        "is_self": isSelf,
        "vip": vip?.toJson(),
        "created_by": createdBy?.toJson(),
      };
}

class CreatedBy {
  int? id;
  String? name;
  String? avatar;
  Relation? relation;

  CreatedBy({
    this.id,
    this.name,
    this.avatar,
    this.relation,
  });

  factory CreatedBy.fromRawJson(String str) =>
      CreatedBy.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        id: json["id"],
        name: json["name"],
        avatar: json["avatar"],
        relation: json["relation"] == null
            ? null
            : Relation.fromJson(json["relation"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatar": avatar,
        "relation": relation?.toJson(),
      };
}

class Relation {
  int? id;
  String? name;
  String? category;

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
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category": category,
      };
}
