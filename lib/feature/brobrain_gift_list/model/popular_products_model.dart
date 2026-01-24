import 'dart:convert';

class PopularProductsModel {
  bool? success;
  String? message;
  List<Product>? data;

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

// Remove the CurrencyCode enum and EnumValues class entirely
// They are causing the error because they don't include all possible currency codes
