import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import '../../../assets_helperfdg/app_fonts.dart';



  class OnboardingButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final BorderSide? borderSide;
  final dynamic height;
  final dynamic width;
  final dynamic radius;

  const OnboardingButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.borderSide, this.textStyle,
    this.padding,
    this.height,
    this.width,
    this.radius = 30.00,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height?? 52.h,
      width: width?? double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          side:borderSide?? BorderSide(color: Colors.transparent),
          elevation: 0,
          backgroundColor:backgroundColor?? Color(0xffA4161A),
          padding: padding ?? EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(AppIcons.btnIcon, height: 32.h, width: 32.w,),
            Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textStyle??TextFontStyle.textStyle14InterW500.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 32.h, width: 32.w,)
          ],
        ),
      ),
    );
  }
}





