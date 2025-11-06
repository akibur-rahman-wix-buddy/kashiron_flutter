import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_image.dart';
import 'package:kashirons_flutter/common_widgets/custom_elevated_button.dart';


import '../../../assets_helperfdg/app_fonts.dart';

class ResetPassSuccess extends StatelessWidget {
  final VoidCallback onCreateAccount;

  const ResetPassSuccess({
    super.key,
    required this.onCreateAccount,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0,
      backgroundColor: AppColor.authBg,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(AppImages.resetSuccess, width: 120.w, height: 120.h,),
            const SizedBox(height: 16),
            Text(
              "Password Updated!",
              style: TextFontStyle.textStyle16InterW400.copyWith(fontSize: 24,fontWeight: FontWeight.w500, color: AppColor.cEDEDED),
            ),
            const SizedBox(height: 10),
            Text(
              "Your password has been changed. You’re all set to log in now.",
              textAlign: TextAlign.center,
              style: TextFontStyle.textStyle16InterW400.copyWith(
                color: Color(0xffa9a9a9),
              ),
            ),
            const SizedBox(height: 24),
            CustomElevatedButton(text: "Login Now", onPressed: onCreateAccount),
            const SizedBox(height: 16),

          ],
        ),
      ),
    );
  }
}