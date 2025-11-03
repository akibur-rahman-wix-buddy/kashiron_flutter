import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/common_widgets/custom_elevated_button.dart';
import 'package:kashirons_flutter/helpers/navigation_service.dart';

import '../../../assets_helperfdg/app_fonts.dart';
import '../../../helpers/all_routes.dart';

class ForgotOtpScreen extends StatefulWidget {
  const ForgotOtpScreen({super.key});

  @override
  State<ForgotOtpScreen> createState() => _ForgotOtpScreenState();
}

class _ForgotOtpScreenState extends State<ForgotOtpScreen> {

  Timer? _timer;
  int _start = 50;
  bool _canResend = false;
  bool isLoading = false;
  dynamic otpCode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startTimer();
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
    if (_canResend)  {

      setState(() {
        isLoading = true;
      });


      setState(() {
        isLoading = false;
      });

      print("============== resend possible");
      _startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.authBg,
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h,),
            GestureDetector(
                onTap: () {
                  NavigationService.goBack;
                },
                child: Icon(Icons.arrow_back_outlined, size: 24, color: AppColor.cEDEDED,)),
            SizedBox(height: 24.h,),

            Text(
              "OTP Verification",
              textAlign: TextAlign.center,
              style:  TextFontStyle.textStyle8InterW700.copyWith(fontSize: 24.sp, fontWeight: FontWeight.w500, color: AppColor.cEDEDED),
            ),
            SizedBox(height: 4.h,),
            Text(
              "To ensure the safety and reliability of our community, please enter the 4-digit OTP sent to md@gmail.com",
              style:  TextFontStyle.textStyle8InterW700.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w400, color: Color(0xffa9a9a9)),
            ),
            SizedBox(height: 24.h,),

            OtpTextField(
              contentPadding: EdgeInsets.all(25),
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              enabled: true,
              numberOfFields: 4,
              fieldWidth: 71.92.w,
              fieldHeight: 71.92.h,
              borderRadius: BorderRadius.circular(7.38.r),
              showFieldAsBox: true,
              inputFormatters: [

              ],
              filled: true,
              fillColor:Color(0xff373B4C),
              borderWidth: 1.0.w,
              enabledBorderColor: Color(0xff373B4C),
              borderColor: Color(0xff373B4C),
              focusedBorderColor: Color(0xff373B4C),
              textStyle: TextFontStyle.textStyle8InterW700.copyWith(color: AppColor.cFFFFFF, fontSize: 24),
              onCodeChanged: (String code) {
                setState(() {
                  otpCode = code;
                });
              },
              onSubmit: (String verificationCode) {
                setState(() {
                  otpCode = verificationCode;
                });
                print("Entered OTP: $otpCode");
              },
            ),
            SizedBox(height: 18.h,),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: _canResend ? _resendCode : null,
                      child: Text(
                        'Resend Code',
                        style: TextFontStyle.textStyle8InterW700
                            .copyWith(
                          color: _canResend
                              ? Colors.grey
                              : Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    if (!_canResend)
                      Text(
                        'In $_start second${_start != 1 ? 's' : ''}',
                        style: TextFontStyle.textStyle8InterW700
                            .copyWith(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 32.h,),
            CustomElevatedButton(text: "Verify", onPressed: () {
              NavigationService.navigateTo(Routes.resetPasswordScreen);
            })

          ],
        ),
      )),

    );
  }
}
