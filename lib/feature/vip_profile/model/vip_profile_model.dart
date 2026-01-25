import 'dart:convert';

VipProfileModel vipProfileModelFromJson(String str) =>
    VipProfileModel.fromJson(json.decode(str));

String vipProfileModelToJson(VipProfileModel data) =>
    json.encode(data.toJson());

class VipProfileModel {
  final bool? success;
  final String? message;
  final VipDataInfo? data;
  final int? code;

  VipProfileModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory VipProfileModel.fromJson(Map<String, dynamic> json) {
    return VipProfileModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] != null ? VipDataInfo.fromJson(json["data"]) : null,
      code: json["code"],
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
        "code": code,
      };
}

class VipDataInfo {
  final int id;
  final String name;
  final String avatar;
  final Relation relation;

  final String? anniversaryDate;
  final String? dateOfBirth;

  final String specialNotes;
  final String? streetAddress;
  final String? country;
  final String? city;
  final String? zipCode;
  final String? phone;

  final List<Relation> selectedInterest;

  final int sparkCount;
  final List<dynamic> sparks;
  final String birthday;
  final String daysUntilBirthday;

  VipDataInfo({
    required this.id,
    required this.name,
    required this.avatar,
    required this.relation,
    this.anniversaryDate,
    this.dateOfBirth,
    required this.specialNotes,
    this.streetAddress,
    this.country,
    this.city,
    this.zipCode,
    this.phone,
    required this.selectedInterest,
    required this.sparkCount,
    required this.sparks,
    required this.birthday,
    required this.daysUntilBirthday,
  });

  factory VipDataInfo.fromJson(Map<String, dynamic> json) {
    return VipDataInfo(
      id: json["id"],
      name: json["name"] ?? "",
      avatar: json["avatar"] ?? "",
      relation: Relation.fromJson(json["relation"]),
      anniversaryDate: json["anniversary_date"],
      dateOfBirth: json["date_of_birth"],
      specialNotes: json["special_notes"] ?? "",
      streetAddress: json["street_address"],
      country: json["country"],
      city: json["city"],
      zipCode: json["zip_code"],
      phone: json["phone"],
      selectedInterest: json["selected_interest"] != null
          ? List<Relation>.from(
              json["selected_interest"].map(
                (x) => Relation.fromJson(x),
              ),
            )
          : [],
      sparkCount: json["spark_count"] ?? 0,
      sparks: json["sparks"] != null ? List<dynamic>.from(json["sparks"]) : [],
      birthday: json["birthday"] ?? "",
      daysUntilBirthday: json["days_until_birthday"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatar": avatar,
        "relation": relation.toJson(),
        "anniversary_date": anniversaryDate,
        "date_of_birth": dateOfBirth,
        "special_notes": specialNotes,
        "street_address": streetAddress,
        "country": country,
        "city": city,
        "zip_code": zipCode,
        "phone": phone,
        "selected_interest": selectedInterest.map((e) => e.toJson()).toList(),
        "spark_count": sparkCount,
        "sparks": sparks,
        "birthday": birthday,
        "days_until_birthday": daysUntilBirthday,
      };
}

class Relation {
  final int id;
  final String name;

  Relation({
    required this.id,
    required this.name,
  });

  factory Relation.fromJson(Map<String, dynamic> json) {
    return Relation(
      id: json["id"],
      name: json["name"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
