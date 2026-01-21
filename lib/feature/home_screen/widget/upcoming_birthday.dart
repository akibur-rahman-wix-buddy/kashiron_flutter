import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_image.dart';
import 'package:kashirons_flutter/common_widgets/custom_container.dart';
import 'package:kashirons_flutter/common_widgets/custom_shimmer_image.dart';
import 'package:kashirons_flutter/feature/home_screen/model/home_api_data_model.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';
import '../../../assets_helperfdg/app_fonts.dart';

class UpcomingBirthday extends StatelessWidget {
  final List<UpcomingBirthdayData> upcomingBirthday;

  const UpcomingBirthday({
    super.key,
    required this.upcomingBirthday,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: upcomingBirthday.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: CustomContainer(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipOval(
                        child: ShimmerImage(
                          placeholder: AppImages.demoAvatar,
                          height: 44.h,
                          width: 44.w,
                          imageUrl: upcomingBirthday[index].avatar ?? " ",
                        ),
                      ),
                      UIHelper.horizontalSpace(10.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            upcomingBirthday[index].name.toString(),
                            style: TextFontStyle.textStyle16InterW400.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xffDFE0E5)),
                          ),
                          UIHelper.verticalSpace(4.h),
                          Text(
                            upcomingBirthday[index].relation ?? " ",
                            style: TextFontStyle.textStyle16InterW400.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xffDFE0E5)),
                          ),
                        ],
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        upcomingBirthday[index].birthdayDate ?? " ",
                        style: TextFontStyle.textStyle16InterW400.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffF4C91E)),
                      ),
                      UIHelper.verticalSpace(4.h),
                      Text(
                        upcomingBirthday[index].inDaysText ?? " ",
                        style: TextFontStyle.textStyle16InterW400.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffDFE0E5)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
