import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../assets_helperfdg/app_colors.dart';
import '../assets_helperfdg/app_fonts.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final BorderSide? borderSide;
  final dynamic height;
  final dynamic width;
  final dynamic radius;
  final bool isLoading;
  final Color? circularColors;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.borderSide,
    this.textStyle,
    this.padding,
    this.height,
    this.width,
    this.radius = 8.00,
    this.isLoading = false,
    this.circularColors,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 52.h,
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          side: borderSide ?? BorderSide(color: Colors.transparent),
          elevation: 0,
          backgroundColor: backgroundColor ?? Color(0xffA4161A),
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        child: isLoading
            ? Center(
                child: SizedBox(
                height: 24.h,
                width: 24.w,
                child: CircularProgressIndicator(
                    color: circularColors ?? Colors.white),
              ))
            : Center(
                child: Text(
                  text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textStyle ??
                      TextFontStyle.textStyle12InterW600.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColor.cEDEDED),
                ),
              ),
      ),
    );
  }
}
