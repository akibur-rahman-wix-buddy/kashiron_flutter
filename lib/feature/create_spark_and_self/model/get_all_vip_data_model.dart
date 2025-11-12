class GetAllVipModelData {
  bool? success;
  String? message;
  List<Data>? data;
  int? code;

  GetAllVipModelData({this.success, this.message, this.data, this.code});

  factory GetAllVipModelData.fromJson(Map<String, dynamic> json) {
    return GetAllVipModelData(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? (json['data'] as List).map((v) => Data.fromJson(v)).toList()
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

class Data {
  Category? category;
  List<Relations>? relations;

  Data({this.category, this.relations});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      category: json['category'] != null
          ? Category.fromJson(json['category'])
          : null,
      relations: json['relations'] != null
          ? (json['relations'] as List).map((v) => Relations.fromJson(v)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (relations != null) {
      data['relations'] = relations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  int? id;
  String? name;

  Category({this.id, this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Relations {
  int? id;
  int? relationCategoryId;
  String? name;
  String? createdAt;
  String? updatedAt;

  Relations({
    this.id,
    this.relationCategoryId,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory Relations.fromJson(Map<String, dynamic> json) {
    return Relations(
      id: json['id'],
      relationCategoryId: json['relation_category_id'],
      name: json['name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['relation_category_id'] = relationCategoryId;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}