import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import 'package:kashirons_flutter/common_widgets/custom_elevated_button.dart';
import 'package:kashirons_flutter/common_widgets/custom_text_field.dart';
import 'package:kashirons_flutter/feature/auth/presentation/sign_up_screen.dart';
import 'package:kashirons_flutter/helpers/all_routes.dart';
import 'package:kashirons_flutter/helpers/navigation_service.dart';
import '../../../assets_helperfdg/app_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController passController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.authBg,
      body: SafeArea(child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20.h,),
                SvgPicture.asset(AppIcons.authPlaceHolder, height: 80.h, width: 80.w,),
                SizedBox(height: 12.h,),
                Text(
                  "Welcome Back",
                  style: TextFontStyle.textStyle12InterW300.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: AppColor.cEDEDED
                  ),
                ),
                SizedBox(height: 2.h,),
                Text(
                  "Sign in to continue",
                  style: TextFontStyle.textStyle12InterW300.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColor.cEDEDED
                  ),
                ),
                SizedBox(height: 32.h,),
                CustomTextField(
                  leftIcon: AppIcons.fieldMai,
                  hintText: "Email address",
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter an email";
                    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                        .hasMatch(value)) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h,),
                CustomTextField(
                  leftIcon: AppIcons.fieldLock,
                  hintText: "Password",
                  controller: passController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your password";
                    } else if (value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        NavigationService.navigateTo(Routes.forgotPasswordScreen);
                      },
                      child: Text(
                        'Forget Password?',
                        style: TextFontStyle.textStyle12InterW300
                            .copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor: Color(0xffD7263D),
                            color: Color(0xffD7263D),
                            fontSize: 14
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h,),
                CustomElevatedButton(text: "Sign In", onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    NavigationService.navigateTo(Routes.customBottomNavBar);
                  }
                }),
                SizedBox(height: 30.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 1.h,
                      width: 60.w,
                      color: Color(0xff787a83),
                    ),
                    SizedBox(width: 10.w,),
                    Text(
                      "Or continue with",
                      style: TextFontStyle.textStyle12InterW300.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff787a83)
                      ),
                    ),
                    SizedBox(width: 10.w,),
                    Container(
                      height: 1.h,
                      width: 60.w,
                      color: Color(0xff787a83),
                    ),
                  ],
                ),
                SizedBox(height: 30.h,),
                AuthOptionContainer(
                  logo: AppIcons.google,
                  title: "Continue with Google",
                  onTap: () {},
                ),
                SizedBox(height: 16.h,),
                AuthOptionContainer(
                  logo: AppIcons.apple,
                  title: "Continue with Apple",
                  onTap: () {},
                ),
                SizedBox(height: 20.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextFontStyle.textStyle12InterW300
                          .copyWith(
                          color: AppColor.cEDEDED,
                          fontSize: 14
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        NavigationService.navigateTo(Routes.signUpScreen);
                      },
                      child: Text(
                        'Sign Up',
                        style: TextFontStyle.textStyle12InterW300
                            .copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor: Color(0xffD7263D),
                            color: Color(0xffD7263D),
                            fontSize: 14
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h,),
                Text(
                  'By using this app, you agree to our ',
                  style: TextFontStyle.textStyle12InterW300
                      .copyWith(
                      color: AppColor.cEDEDED,
                      fontSize: 12,
                      fontWeight: FontWeight.w400
                  ),
                ),
                Text(
                  'Terms of Use and Privacy Policy',
                  style: TextFontStyle.textStyle12InterW300
                      .copyWith(
                      decoration: TextDecoration.underline,
                      decorationColor: Color(0xffD7263D),
                      color: Color(0xffD7263D),
                      fontSize: 12,
                      fontWeight: FontWeight.w400
                  ),
                ),
                SizedBox(height: 10,)


              ],
            ),
          ),
        ),
      )),
    );
  }
}

