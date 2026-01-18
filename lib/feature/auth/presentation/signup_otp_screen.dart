import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/common_widgets/custom_elevated_button.dart';
import 'package:kashirons_flutter/helpers/navigation_service.dart';
import 'package:kashirons_flutter/helpers/toast.dart';
import 'package:kashirons_flutter/networks/api_acess.dart';

import '../../../assets_helperfdg/app_fonts.dart';
import '../../../helpers/all_routes.dart';

class SignupOtpScreen extends StatefulWidget {
  const SignupOtpScreen({super.key, required this.email, required this.isForgetScreen});
  final String email;
  final bool isForgetScreen;

  @override
  State<SignupOtpScreen> createState() => _SignupOtpScreenState();
}

class _SignupOtpScreenState extends State<SignupOtpScreen> {
  Timer? _timer;
  int _start = 50;
  bool _canResend = false;
  bool isLoading = false;
  bool isReSendLoading = false;
  String? otpCode;
  bool _hasOtpError = false;
  final int _requiredOtpLength = 6;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _canResend = false;
      _start = 50;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _canResend = true;
        });
        timer.cancel();
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  void _resendCode() async {
    if (_canResend) {
      setState(() {
        isReSendLoading = true;
      });


     bool success =  await otpResentRx.otpSentInfo(email: widget.email,action:"email_verification" );
      setState(() {
        isReSendLoading = false;
      });

      if(success){
        ToastUtil.showShortToast('OTP sent successfully');
        _startTimer();
      }


    }
  }

  Future<void> _verifyOtp() async {
    // Validate OTP
    if (otpCode == null || otpCode!.isEmpty) {
      setState(() {
        _hasOtpError = true;
      });
      ToastUtil.showShortToast('Please enter OTP');
      return;
    }


    setState(() {
      isLoading= true;
    });

   bool success =   await otpVerificationRx.otpVerification(email: widget.email.toString(), otp: otpCode,action: widget.isForgetScreen?"forgot_password":"email_verification") ;
    if(success){
      print("><>>>>>>>>>>>>>>>>>>> success");
      NavigationService.navigateToWithArgs(Routes.setPasswordScreen, {
        "isForget":widget.isForgetScreen,
        "email":widget.email.toString(),
        "setToken":otpVerificationRx.setToken.toString()
      });
      setState(() {
        isLoading= false;
      });
    }

    // Clear any previous errors
    setState(() {
      _hasOtpError = false;
    });

    setState(() {
      isLoading= false;
    });
    // TODO: Implement your OTP verification API call here

    // For now, navigate to next screen
    print("Entered OTP: $otpCode");
    // NavigationService.navigateTo(Routes.setPasswordScreen);
  }

  void _onOtpChanged(String code) {
    setState(() {
      otpCode = code;
      // Clear error when user starts typing
      if (code.isNotEmpty) {
        _hasOtpError = false;
      }
    });
  }

  void _onOtpCompleted(String verificationCode) {
    setState(() {
      otpCode = verificationCode;
      _hasOtpError = false;
    });
    print("Completed OTP: $otpCode");

    // Auto-submit when OTP is completed
    // if (verificationCode.length == _requiredOtpLength) {
    //   _verifyOtp();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.authBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.h),
                GestureDetector(
                  onTap: () {
                    NavigationService.goBack;
                  },
                  child: Icon(
                    Icons.arrow_back_outlined,
                    size: 24,
                    color: AppColor.cEDEDED,
                  ),
                ),
                SizedBox(height: 24.h),
            
                Text(
                  "OTP Verification",
                  style: TextFontStyle.textStyle8InterW700.copyWith(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColor.cEDEDED,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "To ensure the safety and reliability of our community, please enter the 4-digit OTP sent to ${widget.email.toString()}",
                  style: TextFontStyle.textStyle8InterW700.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xffa9a9a9),
                  ),
                ),
                SizedBox(height: 24.h),
            
                // OTP Field with Error Handling
                Column(
                  children: [
                    OtpTextField(
                      contentPadding: EdgeInsets.all(0),
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
            alignment: Alignment.topCenter,
                      enabled: true,
                      numberOfFields: _requiredOtpLength,
                      fieldWidth: 45.92.w,
                      fieldHeight: 45.92.h,
                      borderRadius: BorderRadius.circular(7.38.r),
                      showFieldAsBox: true,
                      filled: true,
                      fillColor: _hasOtpError ? Colors.red.withOpacity(0.1) : Color(0xff373B4C),
                      borderWidth: 1.0.w,
                      enabledBorderColor: _hasOtpError ? Colors.red : Color(0xff373B4C),
                      borderColor: _hasOtpError ? Colors.red : Color(0xff373B4C),
                      focusedBorderColor: _hasOtpError ? Colors.red : Color(0xffA4161A),
                      textStyle: TextFontStyle.textStyle8InterW700.copyWith(
                        color: AppColor.cFFFFFF,
                        fontSize: 22,
                      ),
                      onCodeChanged: _onOtpChanged,
                      onSubmit: _onOtpCompleted,
                    ),
            
                    // Error message
                    if (_hasOtpError)
                      Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: Row(
                          children: [
                            Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 16.sp,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              'OTP is required',
                              style: TextFontStyle.textStyle8InterW700.copyWith(
                                color: Colors.red,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
            
                SizedBox(height: 18.h),
            
                // Resend Code Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: _canResend ? _resendCode : null,
                          child: Text(
                            isReSendLoading ?"Resending Code ...":'Resend Code',
                            style: TextFontStyle.textStyle8InterW700.copyWith(
                              color: _canResend ? Color(0xffA4161A) : Colors.grey,
                              fontSize: 14.sp,
                              decoration: _canResend ? TextDecoration.underline : TextDecoration.none,
                            ),
                          ),
                        ),
                        SizedBox(width: 5.w),
                        if (!_canResend)
                          Text(
                            'In $_start second${_start != 1 ? 's' : ''}',
                            style: TextFontStyle.textStyle8InterW700.copyWith(
                              color: Colors.white70,
                              fontSize: 14.sp,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
            
                SizedBox(height: 32.h),
            
                // Verify Button
                CustomElevatedButton(
            
                  text: "Verify",
                  onPressed: _verifyOtp,
                  isLoading: isLoading,
                ),
            
                // OTP Info
                SizedBox(height: 16.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Colors.blue,
                            size: 16.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'OTP Information',
                            style: TextFontStyle.textStyle8InterW700.copyWith(
                              color: AppColor.cEDEDED,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        '• Enter the 4-digit OTP sent to your email\n• OTP will expire after 50 seconds\n• Make sure to enter all 4 digits',
                        style: TextFontStyle.textStyle8InterW700.copyWith(
                          color: Colors.grey,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
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
}