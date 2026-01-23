class GetUserProfileModelData {
  bool? success;
  String? message;
  Data? data;
  int? code;

  GetUserProfileModelData({this.success, this.message, this.data, this.code});

  GetUserProfileModelData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['code'] = code;
    return data;
  }
}

class Data {
  User? user;

  Data({this.user});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      user: json != null ? User.fromJson(json) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data.addAll(user!.toJson());
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
  String? phone;
  String? dateOfBirth;
  String? description;
  String? streetAddress;
  String? country;
  String? city;
  String? zipCode;
  String? emailVerifiedAt;
  String? otp;
  String? otpCreatedAt;
  String? otpExpiresAt;
  String? status;
  bool? isAdmin;
  String? stripeAccountId;
  String? stripeCustomerId;
  String? paymentMethodId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  User({
    this.id,
    this.userType,
    this.avatar,
    this.name,
    this.email,
    this.phone,
    this.dateOfBirth,
    this.description,
    this.streetAddress,
    this.country,
    this.city,
    this.zipCode,
    this.emailVerifiedAt,
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
    this.deletedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      userType: json['user_type'],
      avatar: json['avatar'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      dateOfBirth: json['date_of_birth'],
      description: json['description'],
      streetAddress: json['street_address'],
      country: json['country'],
      city: json['city'],
      zipCode: json['zip_code'],
      emailVerifiedAt: json['email_verified_at'],
      otp: json['otp'],
      otpCreatedAt: json['otp_created_at'],
      otpExpiresAt: json['otp_expires_at'],
      status: json['status'],
      isAdmin: json['is_admin'],
      stripeAccountId: json['stripe_account_id'],
      stripeCustomerId: json['stripe_customer_id'],
      paymentMethodId: json['payment_method_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_type'] = userType;
    data['avatar'] = avatar;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['date_of_birth'] = dateOfBirth;
    data['description'] = description;
    data['street_address'] = streetAddress;
    data['country'] = country;
    data['city'] = city;
    data['zip_code'] = zipCode;
    data['email_verified_at'] = emailVerifiedAt;
    data['otp'] = otp;
    data['otp_created_at'] = otpCreatedAt;
    data['otp_expires_at'] = otpExpiresAt;
    data['status'] = status;
    data['is_admin'] = isAdmin;
    data['stripe_account_id'] = stripeAccountId;
    data['stripe_customer_id'] = stripeCustomerId;
    data['payment_method_id'] = paymentMethodId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
