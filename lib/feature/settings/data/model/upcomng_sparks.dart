import 'dart:convert';

class UpcomingSparksModel {
  List<UpcomingSpark>? data;

  UpcomingSparksModel({
    this.data,
  });

  factory UpcomingSparksModel.fromRawJson(String str) =>
      UpcomingSparksModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpcomingSparksModel.fromJson(List<dynamic> json) =>
      UpcomingSparksModel(
        data: List<UpcomingSpark>.from(
          json.map((x) => UpcomingSpark.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class UpcomingSpark {
  int? id;
  String? title;
  String? description;
  String? dateTime;
  String? formattedDate;
  String? daysLeft;
  String? vipName;
  String? vipAvatar;
  bool? isToday;

  UpcomingSpark({
    this.id,
    this.title,
    this.description,
    this.dateTime,
    this.formattedDate,
    this.daysLeft,
    this.vipName,
    this.vipAvatar,
    this.isToday,
  });

  factory UpcomingSpark.fromRawJson(String str) =>
      UpcomingSpark.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpcomingSpark.fromJson(Map<String, dynamic> json) => UpcomingSpark(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        dateTime: json["date_time"],
        formattedDate: json["formatted_date"],
        daysLeft: json["days_left"],
        vipName: json["vip_name"],
        vipAvatar: json["vip_avatar"],
        isToday: json["is_today"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "date_time": dateTime,
        "formatted_date": formattedDate,
        "days_left": daysLeft,
        "vip_name": vipName,
        "vip_avatar": vipAvatar,
        "is_today": isToday,
      };
}
