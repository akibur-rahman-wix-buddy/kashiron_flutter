import 'package:flutter/material.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_image.dart';
import 'package:kashirons_flutter/common_widgets/custom_button.dart';
import 'package:kashirons_flutter/helpers/navigation_service.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryBg,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppImages.deleteCard),
              UIHelper.verticalSpace(16),
              Text(
                "Delete Your Account?",
                style: TextFontStyle.textStyle20InterW500,
              ),
              UIHelper.verticalSpace(16),
              SizedBox(
                  width: double.infinity,
                  child: Text(
                    textAlign: TextAlign.center,
                    "This action cannot be undone. All your VIP profiles, reminders, saved gifts, and order history will be permanently deleted. You will no longer receive notifications or have access to your account.",
                    style: TextFontStyle.textStyle14InterW500
                        .copyWith(color: Colors.white60),
                  )),
              UIHelper.verticalSpace(60),
              customButton(
                  name: "Yes, Delete My Account",
                  onCallBack: () {},
                  borderColor: Colors.transparent,
                  context: context),
              UIHelper.verticalSpace(24),
              customButton(
                  name: "Cancel",
                  onCallBack: () {
                    NavigationService.goBack;
                  },
                  color: Color(0xFF2D3142),
                  borderColor: Colors.transparent,
                  context: context),
            ],
          ),
        ),
      ),
    );
  }
}
