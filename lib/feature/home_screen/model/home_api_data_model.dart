import 'dart:convert';

class HomeApiDataModel {
  bool? success;
  String? message;
  Data? data;
  int? code;

  HomeApiDataModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory HomeApiDataModel.fromRawJson(String str) =>
      HomeApiDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HomeApiDataModel.fromJson(Map<String, dynamic> json) =>
      HomeApiDataModel(
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
  int? totalVipProfiles;
  int? thisWeekSparks;
  int? vipBirthdaysThisMonth;
  String? userName;
  String? userAvatar;
  UpcomingSparks? upcomingSparks;
  List<UpcomingBirthday>? upcomingBirthdays;
  PopularGifts? popularGifts;

  Data({
    this.totalVipProfiles,
    this.thisWeekSparks,
    this.vipBirthdaysThisMonth,
    this.userName,
    this.userAvatar,
    this.upcomingSparks,
    this.upcomingBirthdays,
    this.popularGifts,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalVipProfiles: json["total_vip_profiles"],
        thisWeekSparks: json["this_week_sparks"],
        vipBirthdaysThisMonth: json["vip_birthdays_this_month"],
        userName: json["user_name"],
        userAvatar: json["user_avatar"],
        upcomingSparks: json["upcoming_sparks"] == null
            ? null
            : UpcomingSparks.fromJson(json["upcoming_sparks"]),
        upcomingBirthdays: json["upcoming_birthdays"] == null
            ? []
            : List<UpcomingBirthday>.from(json["upcoming_birthdays"]!
                .map((x) => UpcomingBirthday.fromJson(x))),
        popularGifts: json["popular_gifts"] == null
            ? null
            : PopularGifts.fromJson(json["popular_gifts"]),
      );

  Map<String, dynamic> toJson() => {
        "total_vip_profiles": totalVipProfiles,
        "this_week_sparks": thisWeekSparks,
        "vip_birthdays_this_month": vipBirthdaysThisMonth,
        "user_name": userName,
        "user_avatar": userAvatar,
        "upcoming_sparks": upcomingSparks?.toJson(),
        "upcoming_birthdays": upcomingBirthdays == null
            ? []
            : List<dynamic>.from(upcomingBirthdays!.map((x) => x.toJson())),
        "popular_gifts": popularGifts?.toJson(),
      };
}

class PopularGifts {
  Headers? headers;
  PopularGiftsOriginal? original;
  dynamic exception;

  PopularGifts({
    this.headers,
    this.original,
    this.exception,
  });

  factory PopularGifts.fromRawJson(String str) =>
      PopularGifts.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PopularGifts.fromJson(Map<String, dynamic> json) => PopularGifts(
        headers:
            json["headers"] == null ? null : Headers.fromJson(json["headers"]),
        original: json["original"] == null
            ? null
            : PopularGiftsOriginal.fromJson(json["original"]),
        exception: json["exception"],
      );

  Map<String, dynamic> toJson() => {
        "headers": headers?.toJson(),
        "original": original?.toJson(),
        "exception": exception,
      };
}

class Headers {
  Headers();

  factory Headers.fromRawJson(String str) => Headers.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Headers.fromJson(Map<String, dynamic> json) => Headers();

  Map<String, dynamic> toJson() => {};
}

class PopularGiftsOriginal {
  bool? success;
  String? message;
  List<Product>? data;

  PopularGiftsOriginal({
    this.success,
    this.message,
    this.data,
  });

  factory PopularGiftsOriginal.fromRawJson(String str) =>
      PopularGiftsOriginal.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PopularGiftsOriginal.fromJson(Map<String, dynamic> json) =>
      PopularGiftsOriginal(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Product>.from(json["data"]!.map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Product {
  int? id;
  String? title;
  Price? price;
  String? url;
  String? mainImage;
  int? views;
  int? favorers;
  bool? isFavourite;

  Product({
    this.id,
    this.title,
    this.price,
    this.url,
    this.mainImage,
    this.views,
    this.favorers,
    this.isFavourite,
  });

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        price: json["price"] == null ? null : Price.fromJson(json["price"]),
        url: json["url"],
        mainImage: json["main_image"],
        views: json["views"] ?? 0,
        favorers: json["favorers"] ?? 0,
        isFavourite: json["is_favourite"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price?.toJson(),
        "url": url,
        "main_image": mainImage,
        "views": views,
        "favorers": favorers,
        "is_favourite": isFavourite,
      };
}

class Price {
  double? amount;
  String? currencyCode;

  Price({
    this.amount,
    this.currencyCode,
  });

  factory Price.fromRawJson(String str) => Price.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        amount: json["amount"] is num
            ? (json["amount"] as num).toDouble()
            : double.tryParse(json["amount"].toString()) ?? 0.0,
        currencyCode: json["currency_code"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "currency_code": currencyCode,
      };
}

class UpcomingBirthday {
  int? vipId;
  String? name;
  String? avatar;
  String? relation;
  String? birthdayDate;
  String? inDaysText;
  bool? isToday;

  UpcomingBirthday({
    this.vipId,
    this.name,
    this.avatar,
    this.relation,
    this.birthdayDate,
    this.inDaysText,
    this.isToday,
  });

  factory UpcomingBirthday.fromRawJson(String str) =>
      UpcomingBirthday.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpcomingBirthday.fromJson(Map<String, dynamic> json) =>
      UpcomingBirthday(
        vipId: json["vip_id"],
        name: json["name"],
        avatar: json["avatar"],
        relation: json["relation"],
        birthdayDate: json["birthday_date"],
        inDaysText: json["in_days_text"],
        isToday: json["is_today"],
      );

  Map<String, dynamic> toJson() => {
        "vip_id": vipId,
        "name": name,
        "avatar": avatar,
        "relation": relation,
        "birthday_date": birthdayDate,
        "in_days_text": inDaysText,
        "is_today": isToday,
      };
}

class UpcomingSparks {
  Headers? headers;
  UpcomingSparksOriginal? original;
  dynamic exception;

  UpcomingSparks({
    this.headers,
    this.original,
    this.exception,
  });

  factory UpcomingSparks.fromRawJson(String str) =>
      UpcomingSparks.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpcomingSparks.fromJson(Map<String, dynamic> json) => UpcomingSparks(
        headers:
            json["headers"] == null ? null : Headers.fromJson(json["headers"]),
        original: json["original"] == null
            ? null
            : UpcomingSparksOriginal.fromJson(json["original"]),
        exception: json["exception"],
      );

  Map<String, dynamic> toJson() => {
        "headers": headers?.toJson(),
        "original": original?.toJson(),
        "exception": exception,
      };
}

class UpcomingSparksOriginal {
  bool? success;
  String? message;
  List<SparkData>? data;
  int? code;

  UpcomingSparksOriginal({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory UpcomingSparksOriginal.fromRawJson(String str) =>
      UpcomingSparksOriginal.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpcomingSparksOriginal.fromJson(Map<String, dynamic> json) =>
      UpcomingSparksOriginal(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<SparkData>.from(
                json["data"]!.map((x) => SparkData.fromJson(x))),
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

class SparkData {
  String? date;
  bool? isToday;
  bool? isTomorrow;
  List<Spark>? sparks;

  SparkData({
    this.date,
    this.isToday,
    this.isTomorrow,
    this.sparks,
  });

  factory SparkData.fromRawJson(String str) =>
      SparkData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SparkData.fromJson(Map<String, dynamic> json) => SparkData(
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
