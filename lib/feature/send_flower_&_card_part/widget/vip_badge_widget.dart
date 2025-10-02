import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';


class VipBadge extends StatelessWidget {
  const VipBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: ShapeDecoration(
        color: const Color(0x1E1994E0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      child: Text(
        'VIP',
        style: TextFontStyle.textStyle10InterW400.copyWith(
          fontWeight: FontWeight.w500,
          color: Colors.lightBlueAccent,
        ),
      ),
    );
  }
}