import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_image.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';
import '../../../assets_helperfdg/app_fonts.dart';



class PopularGifts extends StatelessWidget {
  const PopularGifts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 232.h,
      child: ListView.builder(
        itemCount: 4,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {

          return Padding(padding: EdgeInsets.only(right: 16), child: Container(
            width: 140.w,
            height: 232.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColor.authBg,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  child: Image.asset(AppImages.demoItem, height: 120.h, width: double.infinity, fit: BoxFit.cover,),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UIHelper.verticalSpace(10.h),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "Smart Watch",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextFontStyle.textStyle16InterW400.copyWith(
                              fontSize: 14.sp,fontWeight: FontWeight.w500,
                              color: AppColor.cFFFFFF
                          ),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "\$100",
                          style: TextFontStyle.textStyle16InterW400.copyWith(
                              fontSize: 14.sp,fontWeight: FontWeight.w500,
                              color: Color(0xffEF233C)
                          ),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 12),
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 34.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xff373c51),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(AppIcons.gift, height: 14.h, width: 14.w,),
                                UIHelper.horizontalSpace(4.w),
                                Text(
                                  "Buy Gift",
                                  style: TextFontStyle.textStyle16InterW400.copyWith(
                                      fontSize: 10.sp,fontWeight: FontWeight.w500,
                                      color: AppColor.cEDEDED
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                      UIHelper.verticalSpace(10.h),
                    ],
                  ),
                )
              ],
            ),
          ),);
        },
      ),
    );
  }
}