class FavouriteGiftsModel {
  bool? success;
  String? message;
  List<FavouriteGift>? data;
  int? code;

  FavouriteGiftsModel({this.success, this.message, this.data, this.code});

  factory FavouriteGiftsModel.fromJson(Map<String, dynamic> json) {
    return FavouriteGiftsModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? (json['data'] as List)
              .map((item) => FavouriteGift.fromJson(item))
              .toList()
          : null,
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['code'] = code;
    return data;
  }
}

class FavouriteGift {
  int? id;
  String? title;
  String? description;
  Price? price;
  String? url;
  int? quantity;
  int? views;
  int? numFavorers;
  List<String>? tags;
  List<String>? materials;
  bool? isPersonalizable;
  List<Image>? images;

  FavouriteGift({
    this.id,
    this.title,
    this.description,
    this.price,
    this.url,
    this.quantity,
    this.views,
    this.numFavorers,
    this.tags,
    this.materials,
    this.isPersonalizable,
    this.images,
  });

  factory FavouriteGift.fromJson(Map<String, dynamic> json) {
    return FavouriteGift(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'] != null ? Price.fromJson(json['price']) : null,
      url: json['url'],
      quantity: json['quantity'],
      views: json['views'],
      numFavorers: json['num_favorers'],
      tags: json['tags'] != null ? List<String>.from(json['tags']) : null,
      materials: json['materials'] != null
          ? List<String>.from(json['materials'])
          : null,
      isPersonalizable: json['is_personalizable'],
      images: json['images'] != null
          ? (json['images'] as List)
              .map((item) => Image.fromJson(item))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    if (price != null) {
      data['price'] = price!.toJson();
    }
    data['url'] = url;
    data['quantity'] = quantity;
    data['views'] = views;
    data['num_favorers'] = numFavorers;
    data['tags'] = tags;
    data['materials'] = materials;
    data['is_personalizable'] = isPersonalizable;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Price {
  double? amount;
  String? currencyCode;

  Price({this.amount, this.currencyCode});

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      amount: json['amount']?.toDouble(),
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

class Image {
  int? imageId;
  int? rank;
  String? url;
  int? width;
  int? height;

  Image({
    this.imageId,
    this.rank,
    this.url,
    this.width,
    this.height,
  });

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      imageId: json['image_id'],
      rank: json['rank'],
      url: json['url'],
      width: json['width'],
      height: json['height'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image_id'] = imageId;
    data['rank'] = rank;
    data['url'] = url;
    data['width'] = width;
    data['height'] = height;
    return data;
  }
}
