class GetUserProfileModelData {
  bool? success;
  String? message;
  Data? data;
  int? code;

  GetUserProfileModelData({this.success, this.message, this.data, this.code});

  GetUserProfileModelData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['code'] = this.code;
    return data;
  }
}

class Data {
  User? user;

  Data({this.user});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? userType;
  String? avatar;
  String? name;
  String? email;
  String? emailVerifiedAt;
  Null? phone;
  String? dateOfBirth;
  Null? description;
  Null? streetAddress;
  Null? country;
  Null? city;
  Null? zipCode;
  Null? otp;
  Null? otpCreatedAt;
  Null? otpExpiresAt;
  String? status;
  bool? isAdmin;
  Null? stripeAccountId;
  Null? stripeCustomerId;
  Null? paymentMethodId;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  User(
      {this.id,
        this.userType,
        this.avatar,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.phone,
        this.dateOfBirth,
        this.description,
        this.streetAddress,
        this.country,
        this.city,
        this.zipCode,
        this.otp,
        this.otpCreatedAt,
        this.otpExpiresAt,
        this.status,
        this.isAdmin,
        this.stripeAccountId,
        this.stripeCustomerId,
        this.paymentMethodId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userType = json['user_type'];
    avatar = json['avatar'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    phone = json['phone'];
    dateOfBirth = json['date_of_birth'];
    description = json['description'];
    streetAddress = json['street_address'];
    country = json['country'];
    city = json['city'];
    zipCode = json['zip_code'];
    otp = json['otp'];
    otpCreatedAt = json['otp_created_at'];
    otpExpiresAt = json['otp_expires_at'];
    status = json['status'];
    isAdmin = json['is_admin'];
    stripeAccountId = json['stripe_account_id'];
    stripeCustomerId = json['stripe_customer_id'];
    paymentMethodId = json['payment_method_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_type'] = this.userType;
    data['avatar'] = this.avatar;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['phone'] = this.phone;
    data['date_of_birth'] = this.dateOfBirth;
    data['description'] = this.description;
    data['street_address'] = this.streetAddress;
    data['country'] = this.country;
    data['city'] = this.city;
    data['zip_code'] = this.zipCode;
    data['otp'] = this.otp;
    data['otp_created_at'] = this.otpCreatedAt;
    data['otp_expires_at'] = this.otpExpiresAt;
    data['status'] = this.status;
    data['is_admin'] = this.isAdmin;
    data['stripe_account_id'] = this.stripeAccountId;
    data['stripe_customer_id'] = this.stripeCustomerId;
    data['payment_method_id'] = this.paymentMethodId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
