//
//
//
//
//
// class HomeApiDataModel {
//   bool? success;
//   String? message;
//   Data? data;
//   int? code;
//
//   HomeApiDataModel({this.success, this.message, this.data, this.code});
//
//   HomeApiDataModel.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     message = json['message'];
//     data = json['data'] != null ? Data.fromJson(json['data']) : null;
//     code = json['code'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['success'] = this.success;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     data['code'] = this.code;
//     return data;
//   }
// }
//
// class Data {
//   dynamic totalVipProfiles;
//   dynamic thisWeekSparks;
//   dynamic vipBirthdaysThisMonth;
//   String? userName;
//   String? userAvatar;
//   UpcomingSparksResponse? upcomingSparks; // Changed from List<UpcomingSparks>
//   List<UpcomingBirthdays>? upcomingBirthdays;
//   List<PopularGifts>? popularGifts;
//
//   Data({
//     this.totalVipProfiles,
//     this.thisWeekSparks,
//     this.vipBirthdaysThisMonth,
//     this.userName,
//     this.userAvatar,
//     this.upcomingSparks,
//     this.upcomingBirthdays,
//     this.popularGifts,
//   });
//
//   factory Data.fromJson(Map<String, dynamic> json) {
//     return Data(
//       totalVipProfiles: json['total_vip_profiles'] as int?,
//       thisWeekSparks: json['this_week_sparks'] as int?,
//       vipBirthdaysThisMonth: json['vip_birthdays_this_month'],
//       userName: json['user_name'] as String?,
//       userAvatar: json['user_avatar'] as String?,
//       upcomingSparks: json['upcoming_sparks'] != null
//           ? UpcomingSparksResponse.fromJson(json['upcoming_sparks'])
//           : null,
//       upcomingBirthdays: json['upcoming_birthdays'] != null
//           ? List<UpcomingBirthdays>.from(
//         json['upcoming_birthdays'].map(
//               (x) => UpcomingBirthdays.fromJson(x),
//         ),
//       )
//           : null,
//       popularGifts: json['popular_gifts'] != null
//           ? List<PopularGifts>.from(
//         json['popular_gifts'].map(
//               (x) => PopularGifts.fromJson(x),
//         ),
//       )
//           : null,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['total_vip_profiles'] = totalVipProfiles;
//     data['this_week_sparks'] = thisWeekSparks;
//     data['vip_birthdays_this_month'] = vipBirthdaysThisMonth;
//     data['user_name'] = userName;
//     data['user_avatar'] = userAvatar;
//
//     if (upcomingSparks != null) {
//       data['upcoming_sparks'] = upcomingSparks!.toJson();
//     }
//
//     if (upcomingBirthdays != null) {
//       data['upcoming_birthdays'] =
//           upcomingBirthdays!.map((v) => v.toJson()).toList();
//     }
//
//     if (popularGifts != null) {
//       data['popular_gifts'] =
//           popularGifts!.map((v) => v.toJson()).toList();
//     }
//
//     return data;
//   }
// }
//
// // New class to handle the nested upcoming_sparks response structure
// class UpcomingSparksResponse {
//   Map<String, dynamic>? headers;
//   OriginalResponse? original;
//   dynamic exception;
//
//   UpcomingSparksResponse({this.headers, this.original, this.exception});
//
//   factory UpcomingSparksResponse.fromJson(Map<String, dynamic> json) {
//     return UpcomingSparksResponse(
//       headers: json['headers'] != null
//           ? Map<String, dynamic>.from(json['headers'])
//           : null,
//       original: json['original'] != null
//           ? OriginalResponse.fromJson(json['original'])
//           : null,
//       exception: json['exception'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     if (headers != null) {
//       data['headers'] = headers;
//     }
//     if (original != null) {
//       data['original'] = original!.toJson();
//     }
//     data['exception'] = exception;
//     return data;
//   }
// }
//
// class OriginalResponse {
//   bool? success;
//   String? message;
//   List<UpcomingSparks>? data;
//   int? code;
//
//   OriginalResponse({this.success, this.message, this.data, this.code});
//
//   factory OriginalResponse.fromJson(Map<String, dynamic> json) {
//     return OriginalResponse(
//       success: json['success'] as bool?,
//       message: json['message'] as String?,
//       data: json['data'] != null
//           ? List<UpcomingSparks>.from(
//         json['data'].map(
//               (x) => UpcomingSparks.fromJson(x),
//         ),
//       )
//           : null,
//       code: json['code'] as int?,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['success'] = success;
//     data['message'] = message;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     data['code'] = code;
//     return data;
//   }
// }
//
// class UpcomingSparks {
//   dynamic id;
//   String? title;
//   String? description;
//   String? dateTime;
//   String? formattedDate;
//   String? daysLeft;
//   String? vipName;
//   String? vipAvatar;
//   bool? isToday;
//
//   UpcomingSparks({
//     this.id,
//     this.title,
//     this.description,
//     this.dateTime,
//     this.formattedDate,
//     this.daysLeft,
//     this.vipName,
//     this.vipAvatar,
//     this.isToday,
//   });
//
//   factory UpcomingSparks.fromJson(Map<String, dynamic> json) {
//     return UpcomingSparks(
//       id: json['id'] as int?,
//       title: json['title'] as String?,
//       description: json['description'] as String?,
//       dateTime: json['date_time'] as String?,
//       formattedDate: json['formatted_date'] as String?,
//       daysLeft: json['days_left'] as String?,
//       vipName: json['vip_name'] as String?,
//       vipAvatar: json['vip_avatar'] as String?,
//       isToday: json['is_today'] as bool?,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['id'] = id;
//     data['title'] = title;
//     data['description'] = description;
//     data['date_time'] = dateTime;
//     data['formatted_date'] = formattedDate;
//     data['days_left'] = daysLeft;
//     data['vip_name'] = vipName;
//     data['vip_avatar'] = vipAvatar;
//     data['is_today'] = isToday;
//     return data;
//   }
// }
//
// class UpcomingBirthdays {
//   dynamic vipId;
//   String? name;
//   String? avatar;
//   String? relation;
//   String? birthdayDate;
//   String? inDaysText;
//   bool? isToday;
//
//   UpcomingBirthdays({
//     this.vipId,
//     this.name,
//     this.avatar,
//     this.relation,
//     this.birthdayDate,
//     this.inDaysText,
//     this.isToday,
//   });
//
//   factory UpcomingBirthdays.fromJson(Map<String, dynamic> json) {
//     return UpcomingBirthdays(
//       vipId: json['vip_id'] as int?,
//       name: json['name'] as String?,
//       avatar: json['avatar'] as String?,
//       relation: json['relation'] as String?,
//       birthdayDate: json['birthday_date'] as String?,
//       inDaysText: json['in_days_text'] as String?,
//       isToday: json['is_today'] as bool?,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['vip_id'] = vipId;
//     data['name'] = name;
//     data['avatar'] = avatar;
//     data['relation'] = relation;
//     data['birthday_date'] = birthdayDate;
//     data['in_days_text'] = inDaysText;
//     data['is_today'] = isToday;
//     return data;
//   }
// }
//
// class PopularGifts {
//   dynamic listingId;
//   String? title;
//   Price? price;
//   String? url;
//   String? mainImage;
//   dynamic views;
//   dynamic favorers;
//   bool? isFavourite;
//
//   PopularGifts({
//     this.listingId,
//     this.title,
//     this.price,
//     this.url,
//     this.mainImage,
//     this.views,
//     this.favorers,
//     this.isFavourite,
//   });
//
//   factory PopularGifts.fromJson(Map<String, dynamic> json) {
//     return PopularGifts(
//       listingId: json['listing_id'] as int?,
//       title: json['title'] as String?,
//       price: json['price'] != null
//           ? Price.fromJson(json['price'])
//           : null,
//       url: json['url'] as String?,
//       mainImage: json['main_image'] as String?,
//       views: json['views'] as int?,
//       favorers: json['favorers'] as int?,
//       isFavourite: json['is_favourite'] as bool?,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['listing_id'] = listingId;
//     data['title'] = title;
//     if (price != null) {
//       data['price'] = price!.toJson();
//     }
//     data['url'] = url;
//     data['main_image'] = mainImage;
//     data['views'] = views;
//     data['favorers'] = favorers;
//     data['is_favourite'] = isFavourite;
//     return data;
//   }
// }
//
// class Price {
//   dynamic amount;
//   String? currencyCode;
//
//   Price({this.amount, this.currencyCode});
//
//   factory Price.fromJson(Map<String, dynamic> json) {
//     return Price(
//       amount: json['amount'] as int?,
//       currencyCode: json['currency_code'] as String?,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['amount'] = amount;
//     data['currency_code'] = currencyCode;
//     return data;
//   }
// }



class HomeApiDataModel {
  bool? success;
  String? message;
  Data? data;
  int? code;

  HomeApiDataModel({this.success, this.message, this.data, this.code});

  HomeApiDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['code'] = code;
    return data;
  }
}

class Data {
  int? totalVipProfiles;
  int? thisWeekSparks;
  int? vipBirthdaysThisMonth;
  String? userName;
  String? userAvatar;
  List<UpcomingSpark>? upcomingSparks;
  List<UpcomingBirthdayData>? upcomingBirthdays;
  List<PopularGift>? popularGifts;

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

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      totalVipProfiles: json['total_vip_profiles'],
      thisWeekSparks: json['this_week_sparks'],
      vipBirthdaysThisMonth: json['vip_birthdays_this_month'],
      userName: json['user_name'],
      userAvatar: json['user_avatar'],
      upcomingSparks: json['upcoming_sparks'] != null
          ? (json['upcoming_sparks'] as List)
          .map((item) => UpcomingSpark.fromJson(item))
          .toList()
          : null,
      upcomingBirthdays: json['upcoming_birthdays'] != null
          ? (json['upcoming_birthdays'] as List)
          .map((item) => UpcomingBirthdayData.fromJson(item))
          .toList()
          : null,
      popularGifts: json['popular_gifts'] != null
          ? (json['popular_gifts'] as List)
          .map((item) => PopularGift.fromJson(item))
          .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_vip_profiles'] = totalVipProfiles;
    data['this_week_sparks'] = thisWeekSparks;
    data['vip_birthdays_this_month'] = vipBirthdaysThisMonth;
    data['user_name'] = userName;
    data['user_avatar'] = userAvatar;

    if (upcomingSparks != null) {
      data['upcoming_sparks'] = upcomingSparks!.map((v) => v.toJson()).toList();
    }

    if (upcomingBirthdays != null) {
      data['upcoming_birthdays'] = upcomingBirthdays!.map((v) => v.toJson()).toList();
    }

    if (popularGifts != null) {
      data['popular_gifts'] = popularGifts!.map((v) => v.toJson()).toList();
    }

    return data;
  }
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

  factory UpcomingSpark.fromJson(Map<String, dynamic> json) {
    return UpcomingSpark(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      dateTime: json['date_time'],
      formattedDate: json['formatted_date'],
      daysLeft: json['days_left'],
      vipName: json['vip_name'],
      vipAvatar: json['vip_avatar'],
      isToday: json['is_today'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['date_time'] = dateTime;
    data['formatted_date'] = formattedDate;
    data['days_left'] = daysLeft;
    data['vip_name'] = vipName;
    data['vip_avatar'] = vipAvatar;
    data['is_today'] = isToday;
    return data;
  }
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

  factory UpcomingBirthdayData.fromJson(Map<String, dynamic> json) {
    return UpcomingBirthdayData(
      vipId: json['vip_id'],
      name: json['name'],
      avatar: json['avatar'],
      relation: json['relation'],
      birthdayDate: json['birthday_date'],
      inDaysText: json['in_days_text'],
      isToday: json['is_today'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vip_id'] = vipId;
    data['name'] = name;
    data['avatar'] = avatar;
    data['relation'] = relation;
    data['birthday_date'] = birthdayDate;
    data['in_days_text'] = inDaysText;
    data['is_today'] = isToday;
    return data;
  }
}

class PopularGift {
  int? listingId;
  String? title;
  Price? price;
  String? url;
  String? mainImage;
  int? views;
  int? favorers;
  bool? isFavourite;

  PopularGift({
    this.listingId,
    this.title,
    this.price,
    this.url,
    this.mainImage,
    this.views,
    this.favorers,
    this.isFavourite,
  });

  factory PopularGift.fromJson(Map<String, dynamic> json) {
    return PopularGift(
      listingId: json['listing_id'],
      title: json['title'],
      price: json['price'] != null ? Price.fromJson(json['price']) : null,
      url: json['url'],
      mainImage: json['main_image'],
      views: json['views'],
      favorers: json['favorers'],
      isFavourite: json['is_favourite'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['listing_id'] = listingId;
    data['title'] = title;
    if (price != null) {
      data['price'] = price!.toJson();
    }
    data['url'] = url;
    data['main_image'] = mainImage;
    data['views'] = views;
    data['favorers'] = favorers;
    data['is_favourite'] = isFavourite;
    return data;
  }
}

class Price {
  int? amount;
  String? currencyCode;

  Price({this.amount, this.currencyCode});

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      amount: json['amount'],
      currencyCode: json['currency_code'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['currency_code'] = currencyCode;
    return data;
  }
}