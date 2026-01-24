import 'dart:convert';

class SearchProductsModel {
  bool? success;
  String? message;
  List<Datum>? data;

  SearchProductsModel({
    this.success,
    this.message,
    this.data,
  });

  factory SearchProductsModel.fromRawJson(String str) =>
      SearchProductsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchProductsModel.fromJson(Map<String, dynamic> json) =>
      SearchProductsModel(
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
  String? currencyCode;

  Price({
    this.amount,
    this.currencyCode,
  });

  factory Price.fromRawJson(String str) => Price.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        amount: json["amount"]?.toDouble(),
        currencyCode: json["currency_code"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "currency_code": currencyCode,
      };
}
