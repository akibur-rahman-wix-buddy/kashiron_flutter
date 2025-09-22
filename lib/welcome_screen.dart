import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'assets_helperfdg/app_colors.dart';
import 'assets_helperfdg/app_image.dart';
import 'assets_helperfdg/app_lottie.dart';
import 'helpers/ui_helpers.dart';



final class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.authBg,
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            UIHelper.verticalSpace(12.h),
            //Image.asset(AppImages.splashImage, height: 327.h, width: double.infinity, fit: BoxFit.contain,),
            Expanded(child: SizedBox()),
            Lottie.asset(
              AppLottie.splash_loading,
              height: 200.h,
              width: 265.w
            ),
            UIHelper.verticalSpace(35.h),
          ],
        ),
      ))
    );
  }
}
