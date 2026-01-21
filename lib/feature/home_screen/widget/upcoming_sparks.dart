import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_image.dart';
import 'package:kashirons_flutter/common_widgets/custom_container.dart';
import 'package:kashirons_flutter/common_widgets/custom_elevated_button.dart';
import 'package:kashirons_flutter/common_widgets/custom_shimmer_image.dart';
import 'package:kashirons_flutter/feature/home_screen/model/home_api_data_model.dart';
import 'package:kashirons_flutter/helpers/all_routes.dart';
import 'package:kashirons_flutter/helpers/navigation_service.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';
import '../../../assets_helperfdg/app_fonts.dart';

class UpcomingSparksWidget extends StatelessWidget {
  final List<UpcomingSpark> upcomingSparks;

  const UpcomingSparksWidget({
    super.key,
    required this.upcomingSparks,
  });

  // final dynamic positions;
  // final dynamic day;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: upcomingSparks.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: CustomContainer(
                child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        upcomingSparks[index].title.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextFontStyle.textStyle16InterW400.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: AppColor.cFFFFFF),
                      ),
                    ),
                    Text(
                      upcomingSparks[index].daysLeft.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextFontStyle.textStyle16InterW400.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff3BB515)),
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
                          child: ShimmerImage(
                            placeholder: AppImages.demoAvatar,
                            height: 20.h,
                            width: 20.w,
                            imageUrl: upcomingSparks[index].vipAvatar ?? " ",
                          ),
                        ),
                        UIHelper.horizontalSpace(8.w),
                        Text(
                          upcomingSparks[index].vipName.toString(),
                          style: TextFontStyle.textStyle16InterW400.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xffaaacb4)),
                        ),
                      ],
                    ),
                    Text(
                      upcomingSparks[index].formattedDate.toString() ?? " ",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextFontStyle.textStyle16InterW400.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffDFE0E5)),
                    ),
                  ],
                ),
                UIHelper.verticalSpace(14.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    upcomingSparks[index].description.toString() ?? " ",
                    style: TextFontStyle.textStyle16InterW400.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffaaacb4)),
                  ),
                ),
                UIHelper.verticalSpace(14.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: CustomElevatedButton(
                            padding: EdgeInsets.all(12),
                            backgroundColor: Color(0xff353A4E),
                            height: 40.h,
                            text: "View Details",
                            textStyle: TextFontStyle.textStyle10InterW400
                                .copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: AppColor.cFFFFFF),
                            onPressed: () {
                              NavigationService.navigateTo(
                                  Routes.vipSparkDetailsScreen);
                            })),
                    UIHelper.horizontalSpace(12.w),
                    Expanded(
                        child: CustomElevatedButton(
                            padding: EdgeInsets.all(12),
                            height: 40.h,
                            text: "Remind Me",
                            textStyle: TextFontStyle.textStyle10InterW400
                                .copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: AppColor.cFFFFFF),
                            onPressed: () {})),
                  ],
                )
              ],
            )),
          );
        });
  }
}
