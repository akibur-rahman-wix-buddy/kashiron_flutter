// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
// import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
// import 'package:kashirons_flutter/common_widgets/custom_elevated_button.dart';
// import '../../../assets_helperfdg/app_fonts.dart';
// import '../../../common_widgets/custom_text_field.dart';
// import '../../../helpers/navigation_service.dart';
// import '../widget/set_pass_success.dart';
//
// class SetPasswordScreen extends StatefulWidget {
//   const SetPasswordScreen({super.key, required this.setToken, required this.email});
// final String setToken;
// final String email;
//
//   @override
//   State<SetPasswordScreen> createState() => _SetPasswordScreenState();
// }
//
// class _SetPasswordScreenState extends State<SetPasswordScreen> {
//
//   TextEditingController confirmController = TextEditingController();
//   TextEditingController passController = TextEditingController();
//   bool passObscure = true;
//   bool confirmObscure = true;
//   bool isChecked = false;
//   final _formKey = GlobalKey<FormState>();
//
//
//   @override
//   void initState() {
//     print(">>>>>>>>>>>>>>>>>>>>>>.this is token value ${widget.setToken.toString()}");
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.authBg,
//
//       body: SafeArea(child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//
//               SizedBox(height: 20.h,),
//               GestureDetector(
//                   onTap: () {
//                     NavigationService.goBack;
//                   },
//                   child: Icon(Icons.arrow_back_outlined, size: 24, color: AppColor.cEDEDED,)),
//              SizedBox(height: 24.h,),
//               Text("Setup Password", style: TextFontStyle.textStyle16InterW400.copyWith(
//                   fontSize: 24,
//                   fontWeight: FontWeight.w600,
//                   color: AppColor.cEDEDED
//               ),),
//               SizedBox(height: 4.h,),
//               Text("Secure your account for future logins", textAlign: TextAlign.start, style: TextFontStyle.textStyle16InterW400.copyWith(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w400,
//                   color: Color(0xffa9a9a9)
//               ),),
//               SizedBox(height: 24.h,),
//               CustomTextField (
//                 height: 52,
//                 isPassword: true,
//                 controller: passController,
//                 obscureText: passObscure,
//                 leftIcon: AppIcons.fieldLock,
//                 toggleVisibility: () {
//                   setState(() {
//                     passObscure == true?  passObscure = false : passObscure = true;
//                   });
//                 },
//                 hintText: "Password",
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return "Please enter your password";
//                   } else if (value.length < 6) {
//                     return "Password must be at least 6 characters";
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16.h,),
//               CustomTextField(
//                 height: 52,
//                 leftIcon: AppIcons.fieldLock,
//                 obscureText: confirmObscure,
//                 controller: confirmController,
//                 toggleVisibility: () {
//                   setState(() {
//                     confirmObscure == true?  confirmObscure = false : confirmObscure = true;
//                   });
//                 },
//                 isPassword: true,
//                 hintText: "Confirm Password",
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return "Please enter your password";
//                   } else if (value.length < 6) {
//                     return "Password must be at least 6 characters";
//                   } else if (passController.text != confirmController.text) {
//                     return "Password Mismatch";
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 32.h,),
//               CustomElevatedButton(text: "Continue", onPressed: () {
//                 showDialog(
//                   context: context,
//                   builder: (context) => SetPassSuccess(
//                     onCreateAccount: () {
//
//                     },
//                   ),
//                 );
//               })
//             ],
//           ),
//         ),
//       )),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import 'package:kashirons_flutter/common_widgets/custom_elevated_button.dart';
import 'package:kashirons_flutter/feature/auth/widget/reset_success.dart';
import 'package:kashirons_flutter/helpers/all_routes.dart';
import 'package:kashirons_flutter/networks/api_acess.dart';
import '../../../assets_helperfdg/app_fonts.dart';
import '../../../common_widgets/custom_text_field.dart';
import '../../../helpers/navigation_service.dart';
import '../widget/set_pass_success.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key, required this.setToken, required this.email, required this.isForget});
  final String setToken;
  final String email;
  final bool isForget;

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  TextEditingController confirmController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool passObscure = true;
  bool confirmObscure = true;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    print(">>>>>>>>>>>>>>>>>>>>>>.this is token value ${widget.setToken.toString()}");
    super.initState();
  }

  @override
  void dispose() {
    passController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _setPasswordApiCall();
    }
  }

  void _setPasswordApiCall() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 2));

      // TODO: Replace with your actual API call
      await resetPasswordRx.resetPasswordInfo(
        setToken: widget.setToken,
        email: widget.email,
        password: passController.text,
        password_confirmation: confirmController.text
      );

      // If API call is successful, show success dialog
      if (mounted) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) =>widget.isForget? ResetPassSuccess(
            onCreateAccount: () {
              NavigationService.navigateToUntilReplacement(Routes.loginScreen);
            },
          ):SetPassSuccess(
            onCreateAccount: () {
              NavigationService.navigateToUntilReplacement(Routes.customBottomNavBar);
            },
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Failed to set password: $e"),
              backgroundColor: Colors.red,
            )
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your password";
    } else if (value.length < 8) {
      return "Password must be at least 8 characters";
    } else if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(value)) {
      return "Password must contain uppercase, lowercase and numbers";
    }
    return null;
  }

  String? _confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please confirm your password";
    } else if (value.length < 8) {
      return "Password must be at least 8 characters";
    } else if (passController.text != confirmController.text) {
      return "Password does not match";
    }
    return null;
  }

  Widget _buildPasswordStrengthIndicator() {
    if (passController.text.isEmpty) return const SizedBox();

    final password = passController.text;
    int strength = 0;

    if (password.length >= 8) strength++;
    if (RegExp(r'[a-z]').hasMatch(password)) strength++;
    if (RegExp(r'[A-Z]').hasMatch(password)) strength++;
    if (RegExp(r'\d').hasMatch(password)) strength++;
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) strength++;

    Color color = Colors.red;
    String text = 'Weak';

    if (strength >= 4) {
      color = Colors.green;
      text = 'Strong';
    } else if (strength >= 3) {
      color = Colors.orange;
      text = 'Medium';
    }

    return Container(
      margin: EdgeInsets.only(top: 8.h),
      child: Row(
        children: [
          Expanded(
            child: LinearProgressIndicator(
              value: strength / 5,
              backgroundColor: Colors.grey[300],
              color: color,
              minHeight: 8,
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.authBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                GestureDetector(
                  onTap: () {
                    NavigationService.goBack;
                  },
                  child: Icon(Icons.arrow_back_outlined, size: 24, color: AppColor.cEDEDED),
                ),
                SizedBox(height: 24.h),
                Text(
                  "Setup Password",
                  style: TextFontStyle.textStyle16InterW400.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColor.cEDEDED
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "Secure your account for future logins",
                  textAlign: TextAlign.start,
                  style: TextFontStyle.textStyle16InterW400.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xffa9a9a9)
                  ),
                ),
                SizedBox(height: 12.h),
                _buildPasswordStrengthIndicator(),

                SizedBox(height: 24.h),

                CustomTextField(
                  height: 52,
                  isPassword: true,
                  controller: passController,
                  obscureText: passObscure,
                  leftIcon: AppIcons.fieldLock,
                  toggleVisibility: () {
                    setState(() {
                      passObscure = !passObscure;
                    });
                  },
                  hintText: "Password",
                  validator: _passwordValidator,
                  onChanged: (value) {
                    setState(() {}); // Rebuild to update strength indicator
                  },
                ),

                SizedBox(height: 16.h),
                CustomTextField(
                  height: 52,
                  leftIcon: AppIcons.fieldLock,
                  obscureText: confirmObscure,
                  controller: confirmController,
                  toggleVisibility: () {
                    setState(() {
                      confirmObscure = !confirmObscure;
                    });
                  },
                  isPassword: true,
                  hintText: "Confirm Password",
                  validator: _confirmPasswordValidator,
                ),
                SizedBox(height: 32.h),
                CustomElevatedButton(
                  text: isLoading ? "Setting Password..." : "Continue",
                  onPressed: (){
                    isLoading ? null : _submitForm();
                  },
                ),

                // Password requirements
                Container(
                  margin: EdgeInsets.only(top: 16.h),
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Password must contain:",
                        style: TextStyle(
                          color: AppColor.cEDEDED,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      _buildRequirement("At least 8 characters", passController.text.length >= 8),
                      _buildRequirement("One uppercase letter", RegExp(r'[A-Z]').hasMatch(passController.text)),
                      _buildRequirement("One lowercase letter", RegExp(r'[a-z]').hasMatch(passController.text)),
                      _buildRequirement("One number", RegExp(r'\d').hasMatch(passController.text)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRequirement(String text, bool isMet) {
    return Row(
      children: [
        Icon(
          isMet ? Icons.check_circle : Icons.circle_outlined,
          size: 14,
          color: isMet ? Colors.green : Colors.grey,
        ),
        SizedBox(width: 6.w),
        Text(
          text,
          style: TextStyle(
            color: isMet ? Colors.green : Colors.grey,
            fontSize: 11.sp,
          ),
        ),
      ],
    );
  }
}