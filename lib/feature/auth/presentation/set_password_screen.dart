import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import 'package:kashirons_flutter/common_widgets/custom_elevated_button.dart';
import '../../../assets_helperfdg/app_fonts.dart';
import '../../../common_widgets/custom_text_field.dart';
import '../../../helpers/navigation_service.dart';
import '../widget/set_pass_success.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {

  TextEditingController confirmController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool passObscure = true;
  bool confirmObscure = true;
  bool isChecked = false;
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
              Text("Setup Password", style: TextFontStyle.textStyle16InterW400.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: AppColor.cEDEDED
              ),),
              SizedBox(height: 4.h,),
              Text("Secure your account for future logins", textAlign: TextAlign.start, style: TextFontStyle.textStyle16InterW400.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xffa9a9a9)
              ),),
              SizedBox(height: 24.h,),
              CustomTextField (
                height: 52,
                isPassword: true,
                controller: passController,
                obscureText: passObscure,
                leftIcon: AppIcons.fieldLock,
                toggleVisibility: () {
                  setState(() {
                    passObscure == true?  passObscure = false : passObscure = true;
                  });
                },
                hintText: "Password",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your password";
                  } else if (value.length < 6) {
                    return "Password must be at least 6 characters";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h,),
              CustomTextField(
                height: 52,
                leftIcon: AppIcons.fieldLock,
                obscureText: confirmObscure,
                controller: confirmController,
                toggleVisibility: () {
                  setState(() {
                    confirmObscure == true?  confirmObscure = false : confirmObscure = true;
                  });
                },
                isPassword: true,
                hintText: "Confirm Password",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your password";
                  } else if (value.length < 6) {
                    return "Password must be at least 6 characters";
                  } else if (passController.text != confirmController.text) {
                    return "Password Mismatch";
                  }
                  return null;
                },
              ),
              SizedBox(height: 32.h,),
              CustomElevatedButton(text: "Continue", onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => SetPassSuccess(
                    onCreateAccount: () {

                    },
                  ),
                );
              })
            ],
          ),
        ),
      )),
    );
  }
}
