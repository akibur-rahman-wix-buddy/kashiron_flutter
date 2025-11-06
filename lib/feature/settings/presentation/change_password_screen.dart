import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import 'package:kashirons_flutter/common_widgets/custom_app_bar.dart';
import 'package:kashirons_flutter/common_widgets/custom_button.dart';
import 'package:kashirons_flutter/common_widgets/custom_text_field.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  // Controllers
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // Global form key
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSaveChange() {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      // Simulate network call or API request
      Future.delayed(const Duration(seconds: 2), () {
        setState(() => isLoading = false);

        log("✅ Current Password: ${currentPasswordController.text}");
        log("✅ New Password: ${newPasswordController.text}");
        log("✅ Confirm Password: ${confirmPasswordController.text}");

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password changed successfully!')),
        );

        // Clear fields after success
        currentPasswordController.clear();
        newPasswordController.clear();
        confirmPasswordController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColor.primaryBg,
      body: Column(
        children: [
          /// App Bar
          const CustomAppBar(title: "Change Password"),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UIHelper.verticalSpace(26.h),

                      Text(
                        "Secure Your Account",
                        style: TextFontStyle.textStyle16InterW700,
                      ),
                      UIHelper.verticalSpace(16.h),

                      Text(
                        "Protect your account by updating your password. Enter your current password and set a new one to keep your Brobrain account safe.",
                        style: TextFontStyle.textStyle12InterW400.copyWith(
                          color: Colors.white60,
                        ),
                      ),

                      UIHelper.verticalSpace(20.h),

                      /// Current Password
                      Text(
                        "Current Password",
                        style: TextFontStyle.textStyle14InterW500,
                      ),
                      UIHelper.verticalSpace(8.h),
                      CustomTextField(
                        leftIcon: AppIcons.fieldLock,
                        hintText: "Enter Current Password",
                        controller: currentPasswordController,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your current password";
                          } else if (value.length < 6) {
                            return "Password must be at least 6 characters";
                          }
                          return null;
                        },
                      ),

                      UIHelper.verticalSpace(16.h),

                      /// New Password
                      Text(
                        "New Password",
                        style: TextFontStyle.textStyle14InterW500,
                      ),
                      UIHelper.verticalSpace(8.h),
                      CustomTextField(
                        leftIcon: AppIcons.fieldLock,
                        hintText: "Enter New Password",
                        controller: newPasswordController,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a new password";
                          } else if (value.length < 6) {
                            return "Password must be at least 6 characters";
                          } else if (value == currentPasswordController.text) {
                            return "New password cannot be the same as current password";
                          }
                          return null;
                        },
                      ),

                      UIHelper.verticalSpace(16.h),

                      /// Confirm Password
                      Text(
                        "Confirm Password",
                        style: TextFontStyle.textStyle14InterW500,
                      ),
                      UIHelper.verticalSpace(8.h),
                      CustomTextField(
                        leftIcon: AppIcons.fieldLock,
                        hintText: "Re-enter New Password",
                        controller: confirmPasswordController,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please confirm your password";
                          } else if (value != newPasswordController.text) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                      ),
                      UIHelper.verticalSpace(200.h),

                      /// Save Change Button
                      customButton(
                        name: isLoading ? "Saving..." : "Save Change",
                        borderColor: Colors.transparent,
                        height: 45,
                        onCallBack: (){
                          isLoading ? null : _onSaveChange();
                        },
                        context: context,
                      ),

                      UIHelper.verticalSpace(20.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
