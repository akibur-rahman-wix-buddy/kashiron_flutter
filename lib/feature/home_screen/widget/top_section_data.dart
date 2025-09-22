import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';
import '../../../assets_helperfdg/app_fonts.dart';




class TopSectionData extends StatelessWidget {
  final String vip;
  final String sparks;
  final String birthday;

  const TopSectionData({
    super.key, required this.vip, required this.sparks, required this.birthday,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        Expanded(
          child: Container(
            height: 150.h,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColor.authBg
            ),
            child: Padding(
              padding:  EdgeInsets.symmetric(vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppIcons.totalVip, height: 40.h, width: 40.w,),
                  Text(
                    "$vip",
                    style: TextFontStyle.textStyle16InterW400.copyWith(fontSize: 24,fontWeight: FontWeight.w500, color: AppColor.cFFFFFF),
                  ),
                  Text(
                    "Total VIP\nProfile’s",
                    textAlign: TextAlign.center,
                    style: TextFontStyle.textStyle16InterW400.copyWith(fontSize: 12,fontWeight: FontWeight.w400, color: Color(0xffDFE0E5)),
                  ),
                ],
              ),
            ),
          ),
        ),
        UIHelper.horizontalSpace(16.w),
        Expanded(
          child: Container(
            height: 150.h,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColor.authBg
            ),
            child: Padding(
              padding:  EdgeInsets.symmetric(vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppIcons.weeksSparks, height: 40.h, width: 40.w,),
                  Text(
                    "$sparks",
                    style: TextFontStyle.textStyle16InterW400.copyWith(fontSize: 24,fontWeight: FontWeight.w500, color: AppColor.cFFFFFF),
                  ),
                  Text(
                    "This week\nSparks",
                    textAlign: TextAlign.center,
                    style: TextFontStyle.textStyle16InterW400.copyWith(fontSize: 12,fontWeight: FontWeight.w400, color: Color(0xffDFE0E5)),
                  ),
                ],
              ),
            ),
          ),
        ),
        UIHelper.horizontalSpace(16.w),
        Expanded(
          child: Container(
            height: 150.h,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColor.authBg
            ),
            child: Padding(
              padding:  EdgeInsets.symmetric(vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppIcons.monthsBirthday, height: 40.h, width: 40.w,),
                  Text(
                    "$birthday",
                    style: TextFontStyle.textStyle16InterW400.copyWith(fontSize: 24,fontWeight: FontWeight.w500, color: AppColor.cFFFFFF),
                  ),
                  Text(
                    "Birthday’s\nThis Month",
                    textAlign: TextAlign.center,
                    style: TextFontStyle.textStyle16InterW400.copyWith(fontSize: 12,fontWeight: FontWeight.w400, color: Color(0xffDFE0E5)),
                  ),
                ],
              ),
            ),
          ),
        ),

      ],
    );
  }
}
