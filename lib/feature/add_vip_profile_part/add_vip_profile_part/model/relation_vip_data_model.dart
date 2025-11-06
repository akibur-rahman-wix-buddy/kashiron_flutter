// class RelationDataModel {
//   bool? success;
//   String? message;
//   List<RelationShipData>? data;
//   int? code;
//
//   RelationDataModel({this.success, this.message, this.data, this.code});
//
//   RelationDataModel.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <RelationShipData>[];
//       json['data'].forEach((v) {
//         data!.add(new RelationShipData.fromJson(v));
//       });
//     }
//     code = json['code'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['success'] = this.success;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     data['code'] = this.code;
//     return data;
//   }
// }
//
// class RelationShipData {
//   String? category;
//   List<Relations>? relations;
//
//   RelationShipData({this.category, this.relations});
//
//   RelationShipData.fromJson(Map<String, dynamic> json) {
//     category = json['category'];
//     if (json['relations'] != null) {
//       relations = <Relations>[];
//       json['relations'].forEach((v) {
//         relations!.add(new Relations.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['category'] = this.category;
//     if (this.relations != null) {
//       data['relations'] = this.relations!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Relations {
//   int? id;
//   int? relationCategoryId;
//   String? name;
//   String? createdAt;
//   String? updatedAt;
//
//   Relations(
//       {this.id,
//         this.relationCategoryId,
//         this.name,
//         this.createdAt,
//         this.updatedAt});
//
//   Relations.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     relationCategoryId = json['relation_category_id'];
//     name = json['name'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['relation_category_id'] = this.relationCategoryId;
//     data['name'] = this.name;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }




class RelationDataModel {
  bool? success;
  String? message;
  List<RelationShipData>? data;
  int? code;

  RelationDataModel({this.success, this.message, this.data, this.code});

  factory RelationDataModel.fromJson(Map<String, dynamic> json) {
    return RelationDataModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      code: json['code'] as int?,
      data: json['data'] != null
          ? List<RelationShipData>.from(
        (json['data'] as List).map(
              (x) => RelationShipData.fromJson(x as Map<String, dynamic>),
        ),
      )
          : null,
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

class RelationShipData {
  Category? category; // Changed from String? to Category?
  List<Relations>? relations;

  RelationShipData({this.category, this.relations});

  factory RelationShipData.fromJson(Map<String, dynamic> json) {
    return RelationShipData(
      category: json['category'] != null
          ? Category.fromJson(json['category'] as Map<String, dynamic>)
          : null,
      relations: json['relations'] != null
          ? List<Relations>.from(
        (json['relations'] as List).map(
              (x) => Relations.fromJson(x as Map<String, dynamic>),
        ),
      )
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
      id: json['id'] as int?,
      name: json['name'] as String?,
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
      id: json['id'] as int?,
      relationCategoryId: json['relation_category_id'] as int?,
      name: json['name'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
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