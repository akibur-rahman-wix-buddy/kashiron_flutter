import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import 'package:kashirons_flutter/common_widgets/custom_elevated_button.dart';
import '../../../assets_helperfdg/app_fonts.dart';
import '../../../common_widgets/custom_text_field.dart';
import '../../../helpers/all_routes.dart';
import '../../../helpers/navigation_service.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.authBg,

      body: SafeArea(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 20.h,),
              GestureDetector(
                  onTap: () {
                    NavigationService.goBack;
                  },
                  child: Icon(Icons.arrow_back_outlined, size: 24, color: AppColor.cEDEDED,)),
              SizedBox(height: 24.h,),
              Text("Forgot Password", style: TextFontStyle.textStyle16InterW400.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: AppColor.cEDEDED
              ),),
              SizedBox(height: 4.h,),
              Text("Enter your email to reset your password and get back to making change", textAlign: TextAlign.start, style: TextFontStyle.textStyle16InterW400.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xffa9a9a9)
              ),),
              SizedBox(height: 24.h,),
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
              SizedBox(height: 32.h,),
              CustomElevatedButton(text: "Continue", onPressed: () {
                if (_formKey.currentState!.validate()) {
                  NavigationService.navigateTo(Routes.forgotOtpScreen);
                }
              })
            ],
          ),
        ),
      )),
    );
  }
}
