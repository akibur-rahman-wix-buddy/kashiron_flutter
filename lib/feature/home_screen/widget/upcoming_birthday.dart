import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_image.dart';
import 'package:kashirons_flutter/common_widgets/custom_container.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';
import '../../../assets_helperfdg/app_fonts.dart';



class UpcomingBirthday extends StatelessWidget {
  const UpcomingBirthday({
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
            child: CustomContainer(
                child:
                Row(
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
                            Text("Jubayer Hossain", style: TextFontStyle.textStyle16InterW400.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xffDFE0E5)
                            ),),
                            UIHelper.verticalSpace(4.h),
                            Text("Colleague", style: TextFontStyle.textStyle16InterW400.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xffDFE0E5)
                            ),),
                          ],
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Dec 28", style: TextFontStyle.textStyle16InterW400.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffF4C91E)
                        ),),
                        UIHelper.verticalSpace(4.h),
                        Text("In 12 days", style: TextFontStyle.textStyle16InterW400.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffDFE0E5)
                        ),),
                      ],
                    )
                  ],
                ),
            ),
          );
        });
  }
}


