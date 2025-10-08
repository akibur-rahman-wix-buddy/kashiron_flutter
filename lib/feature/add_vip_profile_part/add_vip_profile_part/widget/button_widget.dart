
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final bool isSelected;

  const ButtonWidget({
    super.key,
    this.onTap,
    required this.title,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: ShapeDecoration(
          color: isSelected ? Color(0xFFEF233C) : Color(0xFF373B4C),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: isSelected ? Color(0xFFEF233C) : Color(0xFF464A5B),
            ),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          title,
          style: TextFontStyle.textStyle12InterW400.copyWith(
            fontSize: 14.sp,
            color: isSelected ? Colors.white : Colors.white70,
          ),
        ),
      ),
    );
  }
}
