import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';

class BaseCard extends StatelessWidget {
  final String icon;
  final String title;
  final Widget child;
  final TextStyle? titleStyle;

  const BaseCard({
    super.key,
    required this.icon,
    required this.title,
    required this.child,
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: ShapeDecoration(
        color: const Color(0xFF2D3142),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1.w, color: Colors.transparent),
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(icon),
              UIHelper.horizontalSpace(8),
              Text(
                title,
                style: titleStyle ?? TextFontStyle.textStyle14InterW500,
              ),
            ],
          ),
          UIHelper.verticalSpace(08.h),
          const Divider(height: 1, color: Colors.white),
          UIHelper.verticalSpace(16),
          child,
        ],
      ),
    );
  }
}