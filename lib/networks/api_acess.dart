
import 'package:kashirons_flutter/feature/add_vip_profile_part/add_vip_profile_part/data/create_vip_profile_data/rx.dart';
import 'package:kashirons_flutter/feature/add_vip_profile_part/add_vip_profile_part/data/get_vip_category_api/rx.dart';
import 'package:kashirons_flutter/feature/add_vip_profile_part/add_vip_profile_part/data/get_vip_relationship_api/rx.dart';
import 'package:kashirons_flutter/feature/add_vip_profile_part/add_vip_profile_part/model/relation_vip_data_model.dart';
import 'package:kashirons_flutter/feature/add_vip_profile_part/add_vip_profile_part/model/vip_category_data_model.dart';
import 'package:kashirons_flutter/feature/auth/data/email_send/rx.dart';
import 'package:kashirons_flutter/feature/auth/data/otp_varification/rx.dart';
import 'package:kashirons_flutter/feature/auth/data/registration_data/rx.dart';
import 'package:kashirons_flutter/feature/auth/data/reset_password/rx.dart';
import 'package:kashirons_flutter/feature/auth/data/rx_resend_code_sent/api.dart';
import 'package:kashirons_flutter/feature/auth/data/rx_resend_code_sent/rx.dart';
import 'package:kashirons_flutter/feature/auth/data/rx_sign_in/rx.dart';
import 'package:kashirons_flutter/feature/auth/data/verify_otp/rx.dart';
import 'package:kashirons_flutter/feature/settings/data/rx_logout/rx.dart';
import 'package:rxdart/rxdart.dart';

SignInApiRx signInApiRxObj = SignInApiRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

PostLogOutRX postLogOutRX = PostLogOutRX(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

SignUpRx signUpRx = SignUpRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

SignUpRx signUpRxObj = SignUpRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

OtpResendARx otpResentRx = OtpResendARx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

OtpVerificationRx otpVerificationRx = OtpVerificationRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

EmailForgetRx emailForgetRx = EmailForgetRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);


CreateVipProfileRx createVipProfileRx = CreateVipProfileRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

// OtpForgetRx otpForgetRx = OtpForgetRx(
//   empty: <String, dynamic>{},
//   dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
// );

ResetPasswordRx resetPasswordRx = ResetPasswordRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);


GetVipRelationshipRx getVipRelationshipRx = GetVipRelationshipRx(
  empty: RelationDataModel(),
  dataFetcher: BehaviorSubject<RelationDataModel>(),
);


GetVipCategoryRx getVipCategoryRx = GetVipCategoryRx(
  empty: VipCategoryDataModel(),
  dataFetcher: BehaviorSubject<VipCategoryDataModel>(),
);
