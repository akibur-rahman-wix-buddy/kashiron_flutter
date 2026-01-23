import 'package:kashirons_flutter/feature/add_vip_profile_part/add_vip_profile_part/data/create_vip_profile_data/rx.dart';
import 'package:kashirons_flutter/feature/add_vip_profile_part/add_vip_profile_part/data/get_vip_category_api/rx.dart';
import 'package:kashirons_flutter/feature/add_vip_profile_part/add_vip_profile_part/data/get_vip_relationship_api/rx.dart';
import 'package:kashirons_flutter/feature/add_vip_profile_part/add_vip_profile_part/model/relation_vip_data_model.dart';
import 'package:kashirons_flutter/feature/add_vip_profile_part/add_vip_profile_part/model/vip_category_data_model.dart';
import 'package:kashirons_flutter/feature/auth/data/email_send/rx.dart';
import 'package:kashirons_flutter/feature/auth/data/otp_varification/rx.dart';
import 'package:kashirons_flutter/feature/auth/data/registration_data/rx.dart';
import 'package:kashirons_flutter/feature/auth/data/reset_password/rx.dart';
import 'package:kashirons_flutter/feature/auth/data/rx_resend_code_sent/rx.dart';
import 'package:kashirons_flutter/feature/auth/data/rx_sign_in/rx.dart';
import 'package:kashirons_flutter/feature/brobrain_gift_list/data/favorite_toggle/rx.dart';
import 'package:kashirons_flutter/feature/brobrain_gift_list/data/gift_details/rx.dart';
import 'package:kashirons_flutter/feature/brobrain_gift_list/model/gift_details_model.dart';
import 'package:kashirons_flutter/feature/create_spark_and_self/data/get_all_vip_api/rx.dart';
import 'package:kashirons_flutter/feature/create_spark_and_self/data/self_care_reminder/rx.dart';
import 'package:kashirons_flutter/feature/create_spark_and_self/model/get_all_vip_data_model.dart';
import 'package:kashirons_flutter/feature/home_screen/data/home_data_rx/%20rx.dart';
import 'package:kashirons_flutter/feature/home_screen/model/home_api_data_model.dart';
import 'package:kashirons_flutter/feature/notification/data/notification_toggle/rx.dart';
import 'package:kashirons_flutter/feature/notification/data/rx.dart';
import 'package:kashirons_flutter/feature/notification/model/notification_screen_model.dart';
import 'package:kashirons_flutter/feature/settings/data/change_password_api/rx.dart';
import 'package:kashirons_flutter/feature/settings/data/delete_user/rx.dart';
import 'package:kashirons_flutter/feature/settings/data/favorite_gifts/rx.dart';
import 'package:kashirons_flutter/feature/settings/data/get_user_profile_data_api/rx.dart';
import 'package:kashirons_flutter/feature/settings/data/rx_logout/rx.dart';
import 'package:kashirons_flutter/feature/settings/data/upcoming_sparks/rx.dart';
import 'package:kashirons_flutter/feature/settings/data/update_profile_api/rx.dart';
import 'package:kashirons_flutter/feature/settings/model/favorite_gifts_model.dart';
import 'package:kashirons_flutter/feature/settings/model/upcomng_sparks.dart';
import 'package:kashirons_flutter/feature/settings/model/user_infi_data_model.dart';
import 'package:kashirons_flutter/feature/spark/data/interesert_wise_product/rx.dart';
import 'package:kashirons_flutter/feature/spark/data/spark_delete/rx.dart';
import 'package:kashirons_flutter/feature/spark/data/vip_spark_details/rx.dart';
import 'package:kashirons_flutter/feature/spark/model/interest_wise_product_model.dart';
import 'package:kashirons_flutter/feature/spark/model/spark_show_model.dart';
import 'package:kashirons_flutter/feature/vip_profile/data/get_vip_profile/rx.dart';
import 'package:kashirons_flutter/feature/vip_profile/data/get_vip_profile_list/rx.dart';
import 'package:kashirons_flutter/feature/vip_profile/data/spark_create/rx.dart';
import 'package:kashirons_flutter/feature/vip_profile/model/vip_profile_list_model.dart';
import 'package:kashirons_flutter/feature/vip_profile/model/vip_profile_model.dart';
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

UpdateProfileRx updateProfileRx = UpdateProfileRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

ChangePasswordRx changePasswordRx = ChangePasswordRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

GetVipRelationshipRx getVipRelationshipRx = GetVipRelationshipRx(
  empty: RelationDataModel(),
  dataFetcher: BehaviorSubject<RelationDataModel>(),
);

HomeApiDataRx homeApiDataRx = HomeApiDataRx(
  empty: HomeApiDataModel(),
  dataFetcher: BehaviorSubject<HomeApiDataModel>(),
);

GetVipCategoryRx getVipCategoryRx = GetVipCategoryRx(
  empty: VipCategoryDataModel(),
  dataFetcher: BehaviorSubject<VipCategoryDataModel>(),
);
GetUserProfileRx getUserProfileRx = GetUserProfileRx(
  empty: GetUserProfileModelData(),
  dataFetcher: BehaviorSubject<GetUserProfileModelData>(),
);
GetVipProfileListApiRx getVipProfileListApiRx = GetVipProfileListApiRx(
  empty: VipProfileListModel(),
  dataFetcher: BehaviorSubject<VipProfileListModel>(),
);

GetVipProfileApiRx getVipProfileApiRx = GetVipProfileApiRx(
  empty: VipProfileModel(),
  dataFetcher: BehaviorSubject<VipProfileModel>(),
);

SparkCreateApiRx sparkCreateApiRx = SparkCreateApiRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

SelfReminderApiRx selfReminderApiRx = SelfReminderApiRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

DeleteUserApiRx deleteUserApiRx = DeleteUserApiRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

SparkDeleteApiRx sparkDeleteApiRx = SparkDeleteApiRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

FavoriteToggleApiRx favoriteToggleApiRx = FavoriteToggleApiRx(
  empty: <String, dynamic>{},
  dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
);

// NotificationToggleApiRx notificationToggleApiRx = NotificationToggleApiRx(
//   empty: <String, dynamic>{},
//   dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
// );

final notificationToggleApiRx = NotificationToggleApiRx();

GetAllVipRx getAllVipRx = GetAllVipRx(
  empty: GetAllVipModelData(),
  dataFetcher: BehaviorSubject<GetAllVipModelData>(),
);

NotificationScreenApiRx notificationScreenApiRx = NotificationScreenApiRx(
  empty: NotificationScreenModel(),
  dataFetcher: BehaviorSubject<NotificationScreenModel>(),
);

UpcomingSparksApiRx upcomingSparksApiRx = UpcomingSparksApiRx(
  empty: UpcomingSparksModel(),
  dataFetcher: BehaviorSubject<UpcomingSparksModel>(),
);

FavoriteGiftsApiRx favoriteGiftsApiRx = FavoriteGiftsApiRx(
  empty: FavouriteGiftsModel(),
  dataFetcher: BehaviorSubject<FavouriteGiftsModel>(),
);

VipSparksDetailsApiRx vipSparksDetailsApiRx = VipSparksDetailsApiRx(
  empty: SparkShowModel(),
  dataFetcher: BehaviorSubject<SparkShowModel>(),
);

InterestWiseProductApiRx interestWiseProductApiRx = InterestWiseProductApiRx(
  empty: VipInterestWiseProductModel(),
  dataFetcher: BehaviorSubject<VipInterestWiseProductModel>(),
);

GiftDetailsApiRx giftDetailsApiRx = GiftDetailsApiRx(
  empty: GiftDetailsModel(),
  dataFetcher: BehaviorSubject<GiftDetailsModel>(),
);
