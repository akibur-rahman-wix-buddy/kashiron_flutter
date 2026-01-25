import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:kashirons_flutter/feature/add_vip_profile_part/add_vip_profile_part/presentation/add_vip_profile_part_screen.dart';
import 'package:kashirons_flutter/feature/auth/presentation/forgot_otp_screen.dart';
import 'package:kashirons_flutter/feature/brobrain_gift_list/presentation/brobrain_gift_list_screen.dart';
import 'package:kashirons_flutter/feature/brobrain_gift_list/presentation/gift_details_screen.dart';
import 'package:kashirons_flutter/feature/create_spark_and_self/presentation/create_spark_and_self_screen.dart';
import 'package:kashirons_flutter/feature/create_spark_and_self/presentation/self_care_reminder.dart';
import 'package:kashirons_flutter/feature/notification/presentation/notification_screen.dart';
import 'package:kashirons_flutter/feature/notification_settings/presentation/settings_notification_screen.dart';
import 'package:kashirons_flutter/feature/onboarding/presentation/onboarding_screen.dart';
import 'package:kashirons_flutter/feature/send_flower_&_card_part/presentation/choose_delivery_address_send_flower_Card.dart';
import 'package:kashirons_flutter/feature/send_flower_&_card_part/presentation/choose_flower_card.dart';
import 'package:kashirons_flutter/feature/send_flower_&_card_part/presentation/send_flower_&_card_screen.dart';
import 'package:kashirons_flutter/feature/settings/presentation/change_password_screen.dart';
import 'package:kashirons_flutter/feature/settings/presentation/delete_account_screen.dart';
import 'package:kashirons_flutter/feature/settings/presentation/edit_profile_screen.dart';
import 'package:kashirons_flutter/feature/settings/presentation/favorite_gifts_screen.dart';
import 'package:kashirons_flutter/feature/settings/presentation/order_details_screen.dart';
import 'package:kashirons_flutter/feature/settings/presentation/order_history.dart';
import 'package:kashirons_flutter/feature/settings/presentation/privecy_policy_screen.dart';
import 'package:kashirons_flutter/feature/settings/presentation/terms_condition_screen.dart';
import 'package:kashirons_flutter/feature/settings/presentation/upcomming_spark_screen.dart';
import 'package:kashirons_flutter/feature/spark/presentation/spark_details_screen.dart';
import 'package:kashirons_flutter/feature/spark/presentation/vip_spark_details_screen.dart';
import 'package:kashirons_flutter/feature/vip_profile/presentation/create_spark_screen.dart';
import 'package:kashirons_flutter/feature/vip_profile/presentation/vip_details_screen.dart';

import '../feature/auth/presentation/forgot_password_screen.dart';
import '../feature/auth/presentation/login_screen.dart';
import '../feature/auth/presentation/reset_password_screen.dart';
import '../feature/auth/presentation/set_password_screen.dart';
import '../feature/auth/presentation/sign_up_screen.dart';
import '../feature/auth/presentation/signup_otp_screen.dart';
import '../feature/bottom_nav_bar.dart';

final class Routes {
  static final Routes _routes = Routes._internal();

  Routes._internal();

  static Routes get instance => _routes;

  // ################## Auth User ##################
  static const String onboardingScreen = '/onboardingScreen';
  static const String signUpScreen = '/signUpScreen';
  static const String loginScreen = '/loginScreen';
  static const String signupOtpScreen = '/signupOtpScreen';
  static const String forgotOtpScreen = '/forgotOtpScreen';
  static const String setPasswordScreen = '/setPasswordScreen';
  static const String forgotPasswordScreen = '/forgotPasswordScreen';
  static const String resetPasswordScreen = '/resetPasswordScreen';

  // ################## all ##################
  static const String customBottomNavBar = '/customBottomNavBar';
  static const String notificationScreen = '/notificationScreen';

  ///>>>>>>>>>>>>>>>>>>> spark section >>>>>>>>>>>>>>>>>>>>>>

  static const String sparkDetailsScreen = '/sparkDetailsScreen';
  static const String vipSparkDetailsScreen = '/vipSparkDetailsScreen';

  ///>>>>>>>>>>>>>>>>>>>>>>> send flower card section >>>>>>>>>>>>>

  static const String sendFlowerCardScreen = "/sendFlowerCardScreen";
  static const String chooseDeliveryAddressSendFlowerCard =
      "/chooseDeliveryAddressSendFlowerCard";
  static const String chooseSendFlowerCard = "/chooseSendFlowerCard";
  static const String productDetailScreen = "/productDetailScreen";
  static const String vipDetailsScreen = "/vipDetailsScreen";
  static const String createSparkScreen = "/createSparkScreen";
  static const String addVipProfilePartScreen = "/addVipProfilePartScreen";

  ///>>>>>>>>>>>>>>>>>>>>>>>> settings section >>>>>>>>>>>>>>>>>>>>>>>>>>>

  static const String upcommingSparkScreen = "/upcommingSparkScreen";
  static const String brobrainGiftListScreen = "/brobrainGiftListScreen";
  static const String favoriteGiftsScreen = "/favoriteGiftsScreen";
  static const String orderHistoryScreen = "/orderHistoryScreen";
  static const String orderDetailsScreen = "/orderDetailsScreen";
  static const String createSparkAndSelfScreen = "/createSparkAndSelfScreen";
  static const String selfCareReminderScreen = "/selfCareReminderScreen";
  static const String editProfileScreen = "/editProfileScreen";
  static const String changePasswordScreen = "/changePasswordScreen";
  static const String settingsNotificationScreen =
      "/settingsNotificationScreen";
  static const String termsAndConditionScreen = "/termsAndConditionScreen";
  static const String privacyPolicyScreen = "/privacyPolicyScreen";
  static const String deleteAccountScreen = "/deleteAccountScreen";
}

final class RouteGenerator {
  static final RouteGenerator _routeGenerator = RouteGenerator._internal();

  RouteGenerator._internal();

  static RouteGenerator get instance => _routeGenerator;

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      /// ========================== Auth ==================== ///

      case Routes.onboardingScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: OnboardingScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => OnboardingScreen());

      case Routes.signUpScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(widget: SignUpScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => SignUpScreen());

      case Routes.selfCareReminderScreen:
        final Map args = settings.arguments as Map;

        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: SelfCareReminderScreen(
                  id: args["id"],
                  spark_id: args["spark_id"],
                ),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => SelfCareReminderScreen(
                      id: args["id"],
                      spark_id: args["spark_id"],
                    ));

      case Routes.signupOtpScreen:
        final Map args = settings.arguments as Map;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: SignupOtpScreen(
                  email: args["email"],
                  isForgetScreen: args["isForgetScreen"],
                ),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => SignupOtpScreen(
                  email: args["email"],
                  isForgetScreen: args["isForgetScreen"],
                ),
              );

      case Routes.privacyPolicyScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: PrivacyPolicyScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => PrivacyPolicyScreen());

      case Routes.editProfileScreen:
        final Map args = settings.arguments as Map;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: EditProfileScreen(
                  data: args["data"],
                ),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => EditProfileScreen(data: args["data"]));

      case Routes.deleteAccountScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: DeleteAccountScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => DeleteAccountScreen());

      case Routes.addVipProfilePartScreen:
        final args = settings.arguments as Map;

        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: AddVipProfilePartScreen(
                  isEdit: args['isEdit'],
                  data: args["data"],
                ),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => AddVipProfilePartScreen(
                  isEdit: args['isEdit'],
                  data: args["data"],
                ),
              );

      case Routes.settingsNotificationScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: SettingsNotificationScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => SettingsNotificationScreen());

      case Routes.setPasswordScreen:
        final Map args = settings.arguments as Map;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: SetPasswordScreen(
                  setToken: args["setToken"],
                  email: args["email"],
                  isForget: args["isForget"],
                ),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => SetPasswordScreen(
                    setToken: args["setToken"],
                    email: args["email"],
                    isForget: args["isForget"]));

      case Routes.vipDetailsScreen:
        final Map args = settings.arguments as Map;

        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: VipDetailsScreen(
                  id: args["id"],
                ),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => VipDetailsScreen(
                      id: args["id"],
                    ));

      case Routes.loginScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(widget: LoginScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => LoginScreen());

      case Routes.forgotPasswordScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ForgotPasswordScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => ForgotPasswordScreen());

      case Routes.changePasswordScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ChangePasswordScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => ChangePasswordScreen());

      case Routes.termsAndConditionScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: TermsAndConditionScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => TermsAndConditionScreen());

      case Routes.createSparkAndSelfScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: CreateSparkAndSelfScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => CreateSparkAndSelfScreen());

      case Routes.createSparkScreen:
        final Map args = settings.arguments as Map;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: CreateSparkScreen(
                  id: args["id"],
                ),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => CreateSparkScreen(
                      id: args["id"],
                    ));

      case Routes.forgotOtpScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ForgotOtpScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => ForgotOtpScreen());

      case Routes.resetPasswordScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ResetPasswordScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => ResetPasswordScreen());

      case Routes.upcommingSparkScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: UpcommingSparkScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => UpcommingSparkScreen());

      case Routes.brobrainGiftListScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: BrobrainGiftListScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => BrobrainGiftListScreen());

      case Routes.favoriteGiftsScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: FavoriteGiftsScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => FavoriteGiftsScreen());

      case Routes.orderHistoryScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: OrderHistoryScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => OrderHistoryScreen());

      case Routes.orderDetailsScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: OrderDetailsScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => OrderDetailsScreen());

      /// ================================= All ================================== ///

      case Routes.customBottomNavBar:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: CustomBottomNavBar(), settings: settings)
            : CupertinoPageRoute(builder: (context) => CustomBottomNavBar());

      /// ================================= spark section ================================== ///

      case Routes.sparkDetailsScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: SparkDetailsScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => SparkDetailsScreen());

      case Routes.vipSparkDetailsScreen:
        final Map args = settings.arguments as Map;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: VipSparkDetailsScreen(
                  id: args["id"],
                  vip_id: args["vip_id"],
                ),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => VipSparkDetailsScreen(
                      id: args["id"],
                      vip_id: args["vip_id"],
                    ));

      ///>>>>>>>>>>>>>>>>>>>>>>> send flower card section >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

      case Routes.sendFlowerCardScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: SendFlowerCardScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => SendFlowerCardScreen());

      case Routes.chooseDeliveryAddressSendFlowerCard:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ChooseDeliveryAddressSendFlowerCard(),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => ChooseDeliveryAddressSendFlowerCard());

      case Routes.chooseSendFlowerCard:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ChooseSendFlowerCard(), settings: settings)
            : CupertinoPageRoute(builder: (context) => ChooseSendFlowerCard());

      case Routes.productDetailScreen:
        final Map args = settings.arguments as Map;

        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ProductDetailScreen(
                  id: args["id"],
                ),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => ProductDetailScreen(
                      id: args["id"],
                    ));

      case Routes.notificationScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: NotificationScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => NotificationScreen());

      default:
        return null;
    }
  }
}

//  weenAnimationBuilder(
//   child: Widget,
//   tween: Tween<double>(begin: 0, end: 1),
//   duration: Duration(milliseconds: 1000),
//   curve: Curves.bounceIn,
//   builder: (BuildContext context, double _val, Widget child) {
//     return Opacity(
//       opacity: _val,
//       child: Padding(
//         padding: EdgeInsets.only(top: _val * 50),
//         child: child
//       ),
//     );
//   },
// );

class _FadedTransitionRoute extends PageRouteBuilder {
  final Widget widget;
  @override
  final RouteSettings settings;

  _FadedTransitionRoute({required this.widget, required this.settings})
      : super(
          settings: settings,
          reverseTransitionDuration: const Duration(milliseconds: 1),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionDuration: const Duration(milliseconds: 1),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.ease,
              ),
              child: child,
            );
          },
        );
}

class ScreenTitle extends StatelessWidget {
  final Widget widget;

  const ScreenTitle({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: .5, end: 1),
      duration: const Duration(milliseconds: 500),
      curve: Curves.bounceIn,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: child,
        );
      },
      child: widget,
    );
  }
}
