
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';

class SettingsItemCard extends StatelessWidget {
  const SettingsItemCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.onTap, // Add onTap callback
  });

  final String title;
  final String subtitle;
  final String icon;
  final VoidCallback? onTap; // Make it optional

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.white.withOpacity(0.1), // Custom splash color
      highlightColor: Colors.white.withOpacity(0.05), // Custom highlight color
      borderRadius: BorderRadius.circular(8), // Optional: rounded corners for ripple
      child: _buildContent(), // Extract content to separate method
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        Divider(
          height: 1,
          color: Colors.white60,
        ),
        UIHelper.verticalSpace(8.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.all(9),
                decoration: ShapeDecoration(
                  color: const Color(0xFF2D3142),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Center(
                  child: SizedBox(
                    height: 24,
                    width: 24,
                    child: SvgPicture.asset(icon),
                  ),
                )
            ),
            UIHelper.horizontalSpace(8.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextFontStyle.textStyle20InterW500.copyWith(fontSize: 18),
                ),
                SizedBox(
                  width: 280.w,
                  child: Text(
                      subtitle,
                      style: TextFontStyle.textStyle12InterW400.copyWith(color: Color(0xFF919EAB))
                  ),
                ),
              ],
            )
          ],
        ),
        UIHelper.verticalSpace(8.h),
      ],
    );
  }
}