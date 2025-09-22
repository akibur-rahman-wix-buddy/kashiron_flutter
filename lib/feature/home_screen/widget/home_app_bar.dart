import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_image.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';
import '../../../assets_helperfdg/app_fonts.dart';


class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 124.h,
      width: double.infinity,
      color: AppColor.authBg,
      child: Column(
        children: [
          UIHelper.verticalSpace(60.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipOval(
                      child: Image.asset(AppImages.demoAvatar, height: 44.h, width: 44.w, fit: BoxFit.cover,),
                    ),
                    UIHelper.horizontalSpace(10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Hello Jubayer", style: TextFontStyle.textStyle16InterW400.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColor.cFFFFFF
                        ),),
                        UIHelper.verticalSpace(4.h),
                        Text("Welcome to BroBrain", style: TextFontStyle.textStyle16InterW400.copyWith(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffd7d7d7)
                        ),),
                      ],
                    )
                  ],
                ),
                SvgPicture.asset(AppIcons.notificationIcon, height: 36.h, width: 36.w,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
