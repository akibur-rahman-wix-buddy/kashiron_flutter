import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:kashirons_flutter/feature/auth/presentation/forgot_otp_screen.dart';
import 'package:kashirons_flutter/feature/brobrain_gift_list/presentation/brobrain_gift_list_screen.dart';
import 'package:kashirons_flutter/feature/brobrain_gift_list/presentation/gift_details_screen.dart';
import 'package:kashirons_flutter/feature/onboarding/presentation/onboarding_screen.dart';
import 'package:kashirons_flutter/feature/send_flower_&_card_part/presentation/choose_delivery_address_send_flower_Card.dart';
import 'package:kashirons_flutter/feature/send_flower_&_card_part/presentation/choose_flower_card.dart';
import 'package:kashirons_flutter/feature/send_flower_&_card_part/presentation/send_flower_&_card_screen.dart';
import 'package:kashirons_flutter/feature/settings/presentation/favorite_gifts_screen.dart';
import 'package:kashirons_flutter/feature/settings/presentation/order_details_screen.dart';
import 'package:kashirons_flutter/feature/settings/presentation/order_history.dart';
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


  ///>>>>>>>>>>>>>>>>>>> spark section >>>>>>>>>>>>>>>>>>>>>>

  static const String sparkDetailsScreen = '/sparkDetailsScreen';
  static const String vipSparkDetailsScreen = '/vipSparkDetailsScreen';


  ///>>>>>>>>>>>>>>>>>>>>>>> send flower card section >>>>>>>>>>>>>

 static const String sendFlowerCardScreen = "/sendFlowerCardScreen";
 static const String chooseDeliveryAddressSendFlowerCard = "/chooseDeliveryAddressSendFlowerCard";
 static const String chooseSendFlowerCard = "/chooseSendFlowerCard";
 static const String productDetailScreen = "/productDetailScreen";
 static const String vipDetailsScreen = "/vipDetailsScreen";
 static const String createSparkScreen = "/createSparkScreen";


 ///>>>>>>>>>>>>>>>>>>>>>>>> settings section >>>>>>>>>>>>>>>>>>>>>>>>>>>



  static const String upcommingSparkScreen = "/upcommingSparkScreen";
  static const String brobrainGiftListScreen = "/brobrainGiftListScreen";
  static const String favoriteGiftsScreen = "/favoriteGiftsScreen";
  static const String orderHistoryScreen = "/orderHistoryScreen";
  static const String orderDetailsScreen = "/orderDetailsScreen";



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
            ? _FadedTransitionRoute(
            widget: SignUpScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => SignUpScreen());

      case Routes.signupOtpScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
            widget: SignupOtpScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => SignupOtpScreen());

      case Routes.setPasswordScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
            widget: SetPasswordScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => SetPasswordScreen());

      case Routes.vipDetailsScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
            widget: VipDetailsScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => VipDetailsScreen());

      case Routes.loginScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
            widget: LoginScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => LoginScreen());

      case Routes.forgotPasswordScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
            widget: ForgotPasswordScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => ForgotPasswordScreen());

      case Routes.createSparkScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
            widget: CreateSparkScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => CreateSparkScreen());

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
            : CupertinoPageRoute(builder: (context) => BrobrainGiftListScreen());

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
        return Platform.isAndroid
            ? _FadedTransitionRoute(
            widget: VipSparkDetailsScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => VipSparkDetailsScreen());


    ///>>>>>>>>>>>>>>>>>>>>>>> send flower card section >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


      case Routes.sendFlowerCardScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
            widget: SendFlowerCardScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => SendFlowerCardScreen());


        case Routes.chooseDeliveryAddressSendFlowerCard:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
            widget: ChooseDeliveryAddressSendFlowerCard(), settings: settings)
            : CupertinoPageRoute(builder: (context) => ChooseDeliveryAddressSendFlowerCard());


        case Routes.chooseSendFlowerCard:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
            widget: ChooseSendFlowerCard(), settings: settings)
            : CupertinoPageRoute(builder: (context) => ChooseSendFlowerCard());

        case Routes.productDetailScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
            widget: ProductDetailScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => ProductDetailScreen());




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
