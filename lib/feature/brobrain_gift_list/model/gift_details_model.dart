import 'dart:convert';

class GiftDetailsModel {
  bool? success;
  String? message;
  Data? data;
  int? code;

  GiftDetailsModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory GiftDetailsModel.fromRawJson(String str) =>
      GiftDetailsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GiftDetailsModel.fromJson(Map<String, dynamic> json) =>
      GiftDetailsModel(
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
  int? id;
  dynamic sku;
  dynamic asin;
  int? listingId;
  dynamic gtin;
  dynamic mpn;
  String? title;
  dynamic brand;
  String? shortDescription;
  String? longDescriptionMd;
  int? productCategoryId;
  String? price;
  String? priceCurrency;
  dynamic msrp;
  dynamic retailerName;
  dynamic retailerCountry;
  dynamic affiliateNetwork;
  dynamic affiliateProgramId;
  dynamic affiliateBaseUrl;
  dynamic affiliateDeeplink;
  dynamic deeplinkParams;
  String? availability;
  String? condition;
  dynamic secondhandSource;
  dynamic reviewScore;
  dynamic reviewCount;
  dynamic badges;
  String? moderationStatus;
  String? sourceType;
  String? sourceRef;
  dynamic size;
  dynamic color;
  dynamic ageRange;
  dynamic dimensions;
  dynamic weight;
  dynamic notes;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  ProductCategory? productCategory;
  Image? primaryImage;
  List<Image>? images;

  Data({
    this.id,
    this.sku,
    this.asin,
    this.listingId,
    this.gtin,
    this.mpn,
    this.title,
    this.brand,
    this.shortDescription,
    this.longDescriptionMd,
    this.productCategoryId,
    this.price,
    this.priceCurrency,
    this.msrp,
    this.retailerName,
    this.retailerCountry,
    this.affiliateNetwork,
    this.affiliateProgramId,
    this.affiliateBaseUrl,
    this.affiliateDeeplink,
    this.deeplinkParams,
    this.availability,
    this.condition,
    this.secondhandSource,
    this.reviewScore,
    this.reviewCount,
    this.badges,
    this.moderationStatus,
    this.sourceType,
    this.sourceRef,
    this.size,
    this.color,
    this.ageRange,
    this.dimensions,
    this.weight,
    this.notes,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.productCategory,
    this.primaryImage,
    this.images,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        sku: json["sku"],
        asin: json["asin"],
        listingId: json["listing_id"],
        gtin: json["gtin"],
        mpn: json["mpn"],
        title: json["title"],
        brand: json["brand"],
        shortDescription: json["short_description"],
        longDescriptionMd: json["long_description_md"],
        productCategoryId: json["product_category_id"],
        price: json["price"],
        priceCurrency: json["price_currency"],
        msrp: json["msrp"],
        retailerName: json["retailer_name"],
        retailerCountry: json["retailer_country"],
        affiliateNetwork: json["affiliate_network"],
        affiliateProgramId: json["affiliate_program_id"],
        affiliateBaseUrl: json["affiliate_base_url"],
        affiliateDeeplink: json["affiliate_deeplink"],
        deeplinkParams: json["deeplink_params"],
        availability: json["availability"],
        condition: json["condition"],
        secondhandSource: json["secondhand_source"],
        reviewScore: json["review_score"],
        reviewCount: json["review_count"],
        badges: json["badges"],
        moderationStatus: json["moderation_status"],
        sourceType: json["source_type"],
        sourceRef: json["source_ref"],
        size: json["size"],
        color: json["color"],
        ageRange: json["age_range"],
        dimensions: json["dimensions"],
        weight: json["weight"],
        notes: json["notes"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        productCategory: json["product_category"] == null
            ? null
            : ProductCategory.fromJson(json["product_category"]),
        primaryImage: json["primary_image"] == null
            ? null
            : Image.fromJson(json["primary_image"]),
        images: json["images"] == null
            ? []
            : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sku": sku,
        "asin": asin,
        "listing_id": listingId,
        "gtin": gtin,
        "mpn": mpn,
        "title": title,
        "brand": brand,
        "short_description": shortDescription,
        "long_description_md": longDescriptionMd,
        "product_category_id": productCategoryId,
        "price": price,
        "price_currency": priceCurrency,
        "msrp": msrp,
        "retailer_name": retailerName,
        "retailer_country": retailerCountry,
        "affiliate_network": affiliateNetwork,
        "affiliate_program_id": affiliateProgramId,
        "affiliate_base_url": affiliateBaseUrl,
        "affiliate_deeplink": affiliateDeeplink,
        "deeplink_params": deeplinkParams,
        "availability": availability,
        "condition": condition,
        "secondhand_source": secondhandSource,
        "review_score": reviewScore,
        "review_count": reviewCount,
        "badges": badges,
        "moderation_status": moderationStatus,
        "source_type": sourceType,
        "source_ref": sourceRef,
        "size": size,
        "color": color,
        "age_range": ageRange,
        "dimensions": dimensions,
        "weight": weight,
        "notes": notes,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "product_category": productCategory?.toJson(),
        "primary_image": primaryImage?.toJson(),
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
      };
}

class Image {
  int? id;
  int? productId;
  dynamic thumbnailUrl;
  dynamic mediumUrl;
  dynamic largeUrl;
  String? imageUrl;
  int? isPrimary;
  String? type;
  int? rank;
  int? width;
  int? height;
  DateTime? createdAt;
  DateTime? updatedAt;

  Image({
    this.id,
    this.productId,
    this.thumbnailUrl,
    this.mediumUrl,
    this.largeUrl,
    this.imageUrl,
    this.isPrimary,
    this.type,
    this.rank,
    this.width,
    this.height,
    this.createdAt,
    this.updatedAt,
  });

  factory Image.fromRawJson(String str) => Image.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        productId: json["product_id"],
        thumbnailUrl: json["thumbnail_url"],
        mediumUrl: json["medium_url"],
        largeUrl: json["large_url"],
        imageUrl: json["image_url"],
        isPrimary: json["is_primary"],
        type: json["type"],
        rank: json["rank"],
        width: json["width"],
        height: json["height"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "thumbnail_url": thumbnailUrl,
        "medium_url": mediumUrl,
        "large_url": largeUrl,
        "image_url": imageUrl,
        "is_primary": isPrimary,
        "type": type,
        "rank": rank,
        "width": width,
        "height": height,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class ProductCategory {
  int? id;
  String? name;
  String? status;

  ProductCategory({
    this.id,
    this.name,
    this.status,
  });

  factory ProductCategory.fromRawJson(String str) =>
      ProductCategory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      ProductCategory(
        id: json["id"],
        name: json["name"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
      };
}
