import 'dart:convert';

class VipInterestWiseProductModel {
  bool? success;
  String? message;
  List<Datum>? data;
  int? code;

  VipInterestWiseProductModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory VipInterestWiseProductModel.fromRawJson(String str) =>
      VipInterestWiseProductModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VipInterestWiseProductModel.fromJson(Map<String, dynamic> json) =>
      VipInterestWiseProductModel(
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
  int? productId;
  dynamic sku;
  String? title;
  dynamic brand;
  Price? price;
  dynamic msrp;
  String? mainImage;
  String? sourceRef; // ADDED THIS FIELD
  dynamic reviewScore;
  dynamic reviewCount;
  List<String>? matchedKeywords;
  String? category;
  String? availability;
  String? condition;
  bool? isFavourite;

  Datum({
    this.productId,
    this.sku,
    this.title,
    this.brand,
    this.price,
    this.msrp,
    this.mainImage,
    this.sourceRef, // ADDED THIS FIELD
    this.reviewScore,
    this.reviewCount,
    this.matchedKeywords,
    this.category,
    this.availability,
    this.condition,
    this.isFavourite,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        productId: json["product_id"],
        sku: json["sku"],
        title: json["title"],
        brand: json["brand"],
        price: json["price"] == null ? null : Price.fromJson(json["price"]),
        msrp: json["msrp"],
        mainImage: json["main_image"],
        sourceRef: json["source_ref"], // ADDED THIS FIELD
        reviewScore: json["review_score"],
        reviewCount: json["review_count"],
        matchedKeywords: json["matched_keywords"] == null
            ? []
            : List<String>.from(json["matched_keywords"]!.map((x) => x)),
        category: json["category"],
        availability: json["availability"],
        condition: json["condition"],
        isFavourite: json["is_favourite"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "sku": sku,
        "title": title,
        "brand": brand,
        "price": price?.toJson(),
        "msrp": msrp,
        "main_image": mainImage,
        "source_ref": sourceRef, // ADDED THIS FIELD
        "review_score": reviewScore,
        "review_count": reviewCount,
        "matched_keywords": matchedKeywords == null
            ? []
            : List<dynamic>.from(matchedKeywords!.map((x) => x)),
        "category": category,
        "availability": availability,
        "condition": condition,
        "is_favourite": isFavourite,
      };
}

class Price {
  String? amount;
  String? currency;

  Price({
    this.amount,
    this.currency,
  });

  factory Price.fromRawJson(String str) => Price.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        amount: json["amount"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "currency": currency,
      };
}
