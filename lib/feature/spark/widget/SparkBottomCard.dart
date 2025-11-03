

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/common_widgets/custom_button.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';

class SparkCard extends StatelessWidget {
  const SparkCard({
    super.key, required this.iconName, required this.title, required this.subTitle, required this.buttonName, required this.onTap, required this.ifButton, required this.iconCircleColor,
  });
  final IconData iconName;
  final String title;
  final String subTitle;
  final String buttonName;
  final Color iconCircleColor;
  final VoidCallback onTap;
  final bool ifButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16),
      width: double.infinity,
      decoration: ShapeDecoration(
        color: const Color(0xFF2D3142),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container( // circle icon ✅ fine
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconCircleColor,
                  shape: BoxShape.circle,
                ),
                child:  Center(
                  child: Icon(iconName , color: Colors.white, size: 25),
                ),
              ),
              UIHelper.horizontalSpace(8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextFontStyle.textStyle14InterW500),
                  SizedBox(
                    width: 150.w,
                    child: Text(
                      subTitle,
                      style: TextFontStyle.textStyle12InterW400.copyWith(color: AppColor.c919EAB),
                    ),
                  ),
                ],
              ),
            ],
          ),
          ifButton?  customButton(
            borderColor: Colors.transparent,
              name: buttonName,
              onCallBack:onTap,
              context: context,
              minWidth: 90.w,
              height: 35,
              color: iconCircleColor
          ):SizedBox.shrink(),
        ],
      )
      ,
    );
  }
}