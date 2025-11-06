class VipCategoryDataModel {
  bool? success;
  String? message;
  List<Data>? data;
  int? code;

  VipCategoryDataModel({this.success, this.message, this.data, this.code});

  VipCategoryDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    return data;
  }
}

class Data {
  String? category;
  List<Interests>? interests;

  Data({this.category, this.interests});

  Data.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    if (json['interests'] != null) {
      interests = <Interests>[];
      json['interests'].forEach((v) {
        interests!.add(new Interests.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    if (this.interests != null) {
      data['interests'] = this.interests!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Interests {
  int? id;
  int? interestCategoryId;
  String? name;
  String? createdAt;
  String? updatedAt;

  Interests(
      {this.id,
        this.interestCategoryId,
        this.name,
        this.createdAt,
        this.updatedAt});

  Interests.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    interestCategoryId = json['interest_category_id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['interest_category_id'] = this.interestCategoryId;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
