import 'dart:convert';

class PopularProductsModel {
  bool? success;
  String? message;
  List<Datum>? data;

  PopularProductsModel({
    this.success,
    this.message,
    this.data,
  });

  factory PopularProductsModel.fromRawJson(String str) =>
      PopularProductsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PopularProductsModel.fromJson(Map<String, dynamic> json) =>
      PopularProductsModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? id;
  String? title;
  Price? price;
  String? url;
  String? mainImage;
  int? views;
  int? favorers;
  bool? isFavourite;

  Datum({
    this.id,
    this.title,
    this.price,
    this.url,
    this.mainImage,
    this.views,
    this.favorers,
    this.isFavourite,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        price: json["price"] == null ? null : Price.fromJson(json["price"]),
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

class Price {
  double? amount;
  CurrencyCode? currencyCode;

  Price({
    this.amount,
    this.currencyCode,
  });

  factory Price.fromRawJson(String str) => Price.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        amount: json["amount"]?.toDouble(),
        currencyCode: currencyCodeValues.map[json["currency_code"]]!,
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "currency_code": currencyCodeValues.reverse[currencyCode],
      };
}

enum CurrencyCode { INR, USD }

final currencyCodeValues =
    EnumValues({"INR": CurrencyCode.INR, "USD": CurrencyCode.USD});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
