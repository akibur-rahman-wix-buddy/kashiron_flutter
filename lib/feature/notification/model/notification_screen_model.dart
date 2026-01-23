import 'dart:convert';

class NotificationScreenModel {
  bool? success;
  String? message;
  Data? data;
  int? code;

  NotificationScreenModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory NotificationScreenModel.fromRawJson(String str) =>
      NotificationScreenModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationScreenModel.fromJson(Map<String, dynamic> json) =>
      NotificationScreenModel(
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
  List<Group>? groups;

  Data({
    this.groups,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        groups: json["groups"] == null
            ? []
            : List<Group>.from(json["groups"]!.map((x) => Group.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "groups": groups == null
            ? []
            : List<dynamic>.from(groups!.map((x) => x.toJson())),
      };
}

class Group {
  String? title;
  List<Item>? items;

  Group({
    this.title,
    this.items,
  });

  factory Group.fromRawJson(String str) => Group.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        title: json["title"],
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Item {
  int? id;
  Title? title;
  Message? message;
  String? timeLabel;
  Category? category;
  bool? isUnread;
  DateTime? scheduledAt;
  Type? type;
  int? sparkId;
  RelatedVip? relatedVip;

  Item({
    this.id,
    this.title,
    this.message,
    this.timeLabel,
    this.category,
    this.isUnread,
    this.scheduledAt,
    this.type,
    this.sparkId,
    this.relatedVip,
  });

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        title: titleValues.map[json["title"]] ?? Title.UNKNOWN,
        message: messageValues.map[json["message"]] ?? Message.UNKNOWN,
        timeLabel: json["time_label"],
        category: categoryValues.map[json["category"]] ?? Category.UNKNOWN,
        isUnread: json["is_unread"],
        scheduledAt: json["scheduled_at"] == null
            ? null
            : DateTime.parse(json["scheduled_at"]),
        type: typeValues.map[json["type"]] ?? Type.UNKNOWN,
        sparkId: json["spark_id"],
        relatedVip: json["related_vip"] == null
            ? null
            : RelatedVip.fromJson(json["related_vip"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": titleValues.reverse[title],
        "message": messageValues.reverse[message],
        "time_label": timeLabel,
        "category": categoryValues.reverse[category],
        "is_unread": isUnread,
        "scheduled_at": scheduledAt?.toIso8601String(),
        "type": typeValues.reverse[type],
        "spark_id": sparkId,
        "related_vip": relatedVip?.toJson(),
      };
}

enum Category { SPARK, SELF_CARE, UNKNOWN }

final categoryValues = EnumValues({
  "Spark": Category.SPARK,
  "Self-Care": Category.SELF_CARE,
  "": Category.UNKNOWN
});

enum Message {
  FGYHFG_GFJH_FGFH_FGFH_VFGF_GHFG_HG_HG_H,
  THIS_VIP_FOR_DESCRIPTION,
  TITLE_DESCRIPTION,
  NEW_REMINDER,
  REMINDER_DESCRIPTION,
  UNKNOWN
}

final messageValues = EnumValues({
  "fgyhfg gfjh fgfh fgfh vfgf ghfg hg hg h":
      Message.FGYHFG_GFJH_FGFH_FGFH_VFGF_GHFG_HG_HG_H,
  "This VIP for Description ....": Message.THIS_VIP_FOR_DESCRIPTION,
  "Title description": Message.TITLE_DESCRIPTION,
  "New reminder": Message.NEW_REMINDER,
  "Reminder description": Message.REMINDER_DESCRIPTION,
  "": Message.UNKNOWN
});

class RelatedVip {
  String? name;
  String? avatar;

  RelatedVip({
    this.name,
    this.avatar,
  });

  factory RelatedVip.fromRawJson(String str) =>
      RelatedVip.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RelatedVip.fromJson(Map<String, dynamic> json) => RelatedVip(
        name: json["name"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "avatar": avatar,
      };
}

enum Title {
  HELLO_THIS_IS_REMINDER,
  VJGVHUJG_HJ_GHFG_F_GFG,
  WIFE_SELECTED,
  NEW_REMINDER,
  UNKNOWN
}

final titleValues = EnumValues({
  "Hello This is Reminder.": Title.HELLO_THIS_IS_REMINDER,
  "vjgvhujg hj ghfg f gfg": Title.VJGVHUJG_HJ_GHFG_F_GFG,
  "Wife Selected": Title.WIFE_SELECTED,
  "NEW Reminder": Title.NEW_REMINDER,
  "": Title.UNKNOWN
});

enum Type { EVENT_START, REMINDER, UNKNOWN }

final typeValues = EnumValues({
  "event_start": Type.EVENT_START,
  "reminder": Type.REMINDER,
  "": Type.UNKNOWN
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
