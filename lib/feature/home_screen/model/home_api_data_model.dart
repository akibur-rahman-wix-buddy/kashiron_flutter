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
  List<UpcomingSpark>? upcomingSparks;
  List<UpcomingBirthdayData>? upcomingBirthdays;
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

  factory Data.fromJson(Map<String, dynamic> json) {
    // Handle upcoming_sparks which can be either a list or an object
    List<UpcomingSpark>? upcomingSparksList;

    if (json["upcoming_sparks"] != null) {
      if (json["upcoming_sparks"] is List) {
        // If it's a list, parse as list
        upcomingSparksList = List<UpcomingSpark>.from(
          json["upcoming_sparks"]!.map((x) => UpcomingSpark.fromJson(x)),
        );
      } else if (json["upcoming_sparks"] is Map) {
        // If it's an object (like popular_gifts structure), check if it has data
        final sparksData = json["upcoming_sparks"];
        if (sparksData["original"] != null &&
            sparksData["original"]["data"] is List) {
          upcomingSparksList = List<UpcomingSpark>.from(
            sparksData["original"]["data"]
                .map((x) => UpcomingSpark.fromJson(x)),
          );
        } else {
          upcomingSparksList = [];
        }
      }
    } else {
      upcomingSparksList = [];
    }

    return Data(
      totalVipProfiles: json["total_vip_profiles"],
      thisWeekSparks: json["this_week_sparks"],
      vipBirthdaysThisMonth: json["vip_birthdays_this_month"],
      userName: json["user_name"],
      userAvatar: json["user_avatar"],
      upcomingSparks: upcomingSparksList,
      upcomingBirthdays: json["upcoming_birthdays"] == null
          ? []
          : List<UpcomingBirthdayData>.from(
              json["upcoming_birthdays"]!
                  .map((x) => UpcomingBirthdayData.fromJson(x)),
            ),
      popularGifts: json["popular_gifts"] == null
          ? null
          : PopularGifts.fromJson(json["popular_gifts"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "total_vip_profiles": totalVipProfiles,
        "this_week_sparks": thisWeekSparks,
        "vip_birthdays_this_month": vipBirthdaysThisMonth,
        "user_name": userName,
        "user_avatar": userAvatar,
        "upcoming_sparks": upcomingSparks == null
            ? []
            : List<dynamic>.from(upcomingSparks!.map((x) => x.toJson())),
        "upcoming_birthdays": upcomingBirthdays == null
            ? []
            : List<dynamic>.from(upcomingBirthdays!.map((x) => x.toJson())),
        "popular_gifts": popularGifts?.toJson(),
      };
}

class PopularGifts {
  Headers? headers;
  Original? original;
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
            : Original.fromJson(json["original"]),
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

class Original {
  bool? success;
  String? message;
  List<GiftDatum>? data;
  int? code;

  Original({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory Original.fromRawJson(String str) =>
      Original.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Original.fromJson(Map<String, dynamic> json) => Original(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<GiftDatum>.from(
                json["data"]!.map((x) => GiftDatum.fromJson(x))),
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

class GiftDatum {
  int? id;
  String? title;
  GiftPrice? price;
  String? url;
  String? mainImage;
  int? views;
  int? favorers;
  bool? isFavourite;

  GiftDatum({
    this.id,
    this.title,
    this.price,
    this.url,
    this.mainImage,
    this.views,
    this.favorers,
    this.isFavourite,
  });

  factory GiftDatum.fromRawJson(String str) =>
      GiftDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GiftDatum.fromJson(Map<String, dynamic> json) => GiftDatum(
        id: json["id"],
        title: json["title"],
        price: json["price"] == null ? null : GiftPrice.fromJson(json["price"]),
        url: json["url"],
        mainImage: json["main_image"],
        views: json["views"],
        favorers: json["favorers"],
        isFavourite: json["is_favourite"],
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

class GiftPrice {
  double? amount;
  String? currencyCode;

  GiftPrice({
    this.amount,
    this.currencyCode,
  });

  factory GiftPrice.fromRawJson(String str) =>
      GiftPrice.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GiftPrice.fromJson(Map<String, dynamic> json) => GiftPrice(
        amount: json["amount"]?.toDouble(),
        currencyCode: json["currency_code"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "currency_code": currencyCode,
      };
}

class UpcomingBirthdayData {
  int? vipId;
  String? name;
  String? avatar;
  String? relation;
  String? birthdayDate;
  String? inDaysText;
  bool? isToday;

  UpcomingBirthdayData({
    this.vipId,
    this.name,
    this.avatar,
    this.relation,
    this.birthdayDate,
    this.inDaysText,
    this.isToday,
  });

  factory UpcomingBirthdayData.fromRawJson(String str) =>
      UpcomingBirthdayData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpcomingBirthdayData.fromJson(Map<String, dynamic> json) =>
      UpcomingBirthdayData(
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
