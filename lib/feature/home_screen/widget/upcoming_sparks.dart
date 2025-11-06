import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_image.dart';
import 'package:kashirons_flutter/common_widgets/custom_container.dart';
import 'package:kashirons_flutter/common_widgets/custom_elevated_button.dart';
import 'package:kashirons_flutter/helpers/all_routes.dart';
import 'package:kashirons_flutter/helpers/navigation_service.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';
import '../../../assets_helperfdg/app_fonts.dart';



class UpcomingSparks extends StatelessWidget {
  const UpcomingSparks({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 2,
        itemBuilder: (context, index) {

          return  Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: CustomContainer(child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Meeting with Boss",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextFontStyle.textStyle16InterW400.copyWith(fontSize: 20,fontWeight: FontWeight.w400, color: AppColor.cFFFFFF),
                      ),
                    ),
                    Text(
                      "Today",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextFontStyle.textStyle16InterW400.copyWith(
                          fontSize: 12,fontWeight: FontWeight.w500,
                          color: Color(0xff3BB515)
                      ),
                    ),
                  ],
                ),
                UIHelper.verticalSpace(4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ClipOval(
                          child: Image.asset(AppImages.demoAvatar, height: 20.h, width: 20.w, fit: BoxFit.cover,),
                        ),
                        UIHelper.horizontalSpace(8.w),
                        Text(
                          "Boss",
                          style: TextFontStyle.textStyle16InterW400.copyWith(fontSize: 12,fontWeight: FontWeight.w400, color: Color(0xffaaacb4)),
                        ),
                      ],
                    ),
                    Text(
                      "23 August 2025",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextFontStyle.textStyle16InterW400.copyWith(
                          fontSize: 12,fontWeight: FontWeight.w400,
                          color: Color(0xffDFE0E5)
                      ),
                    ),
                  ],
                ),
                UIHelper.verticalSpace(14.h),
                Text(
                  "A quick reminder you set stay prepared, stay on track, and never miss what truly matters.",
                  style: TextFontStyle.textStyle16InterW400.copyWith(
                      fontSize: 12,fontWeight: FontWeight.w400,
                      color: Color(0xffaaacb4)
                  ),
                ),
                UIHelper.verticalSpace(14.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: CustomElevatedButton(
                        padding: EdgeInsets.all(12),
                        backgroundColor: Color(0xff353A4E),
                        height: 40.h,
                        text: "View Details",
                        textStyle: TextFontStyle.textStyle10InterW400.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: AppColor.cFFFFFF
                        ),
                        onPressed: () {
                          NavigationService.navigateTo(Routes.vipSparkDetailsScreen);
                        })
                    ),
                    UIHelper.horizontalSpace(12.w),
                    Expanded(child: CustomElevatedButton(
                        padding: EdgeInsets.all(12),
                        height: 40.h,
                        text: "Remind Me",
                        textStyle: TextFontStyle.textStyle10InterW400.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: AppColor.cFFFFFF
                        ),
                        onPressed: () {})
                    ),
                  ],
                )

              ],
            )),
          );
        });
  }
}


