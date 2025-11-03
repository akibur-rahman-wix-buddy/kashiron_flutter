import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import 'package:kashirons_flutter/common_widgets/custom_elevated_button.dart';
import 'package:kashirons_flutter/common_widgets/custom_text_field.dart';
import 'package:kashirons_flutter/helpers/all_routes.dart';
import 'package:kashirons_flutter/helpers/navigation_service.dart';
import 'package:kashirons_flutter/helpers/toast.dart';
import '../../../assets_helperfdg/app_fonts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final TextEditingController firstController = TextEditingController();
  final TextEditingController lastController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
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
                  "Create Account",
                  style: TextFontStyle.textStyle12InterW300.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: AppColor.cEDEDED
                  ),
                ),
                SizedBox(height: 2.h,),
                Text(
                  "Sign up to get started",
                  style: TextFontStyle.textStyle12InterW300.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColor.cEDEDED
                  ),
                ),
                SizedBox(height: 32.h,),
                CustomTextField(
                  leftIcon: AppIcons.fieldProfile,
                  hintText: "First Name",
                  controller: firstController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a first name";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h,),
                CustomTextField(
                  leftIcon: AppIcons.fieldProfile,
                  hintText: "Last Name",
                  controller: lastController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a last name";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h,),
                CustomTextField(
                  leftIcon: AppIcons.fieldMai,
                  hintText: "Email",
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
                  leftIcon: AppIcons.fieldCalander,
                  hintText: "Date of Birth",
                  controller: dateController,
                  readOnly: true,
                  onTap: () async {

                    FocusScope.of(context)
                        .requestFocus(FocusNode()); // Close keyboard if open

                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1970),
                      lastDate: DateTime(2100),
                    );

                    if (pickedDate != null) {
                      dateController.text =
                      "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a date of birth";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h,),
                CustomElevatedButton(text: "Create Account", onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    NavigationService.navigateTo(Routes.signupOtpScreen);
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
                      'Already have an account? ',
                      style: TextFontStyle.textStyle12InterW300
                          .copyWith(
                          color: AppColor.cEDEDED,
                          fontSize: 14
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        NavigationService.navigateTo(Routes.loginScreen);
                      },
                      child: Text(
                        'Sign In',
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

class AuthOptionContainer extends StatelessWidget {
  final dynamic logo;
  final dynamic title;
  final VoidCallback onTap;
  const AuthOptionContainer({
    super.key,required this.logo,required this.title, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xff373b4c),
          borderRadius: BorderRadius.circular(8)
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(logo, height: 24.h, width: 24.w,),
              SizedBox(width: 10.w,),
              Text(
                title,
                style: TextFontStyle.textStyle12InterW300.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColor.cEDEDED
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
