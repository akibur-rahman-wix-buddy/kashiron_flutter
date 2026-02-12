import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_image.dart';
import 'package:kashirons_flutter/common_widgets/custom_container.dart';
import 'package:kashirons_flutter/common_widgets/custom_elevated_button.dart';
import 'package:kashirons_flutter/common_widgets/custom_shimmer_image.dart';
import 'package:kashirons_flutter/feature/home_screen/widget/set_reminder_bottomSheet.dart';
import 'package:kashirons_flutter/helpers/all_routes.dart';
import 'package:kashirons_flutter/helpers/navigation_service.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';
import '../../../assets_helperfdg/app_fonts.dart';

class UpcomingSparksWidget extends StatelessWidget {
  final dynamic upcomingSparks;

  const UpcomingSparksWidget({
    super.key,
    required this.upcomingSparks,
  });

  final String baseImageUrl = "https://admin.brobrainapp.com/";

  String _getFullImageUrl(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) {
      return "";
    }

    if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      return imagePath;
    }

    return baseImageUrl + imagePath;
  }

  @override
  Widget build(BuildContext context) {
    // First, flatten the list of all sparks from all date groups
    List<dynamic> allSparks = [];
    List<String> sparkDates = [];

    for (var dateGroup in upcomingSparks) {
      if (dateGroup.sparks != null && dateGroup.sparks!.isNotEmpty) {
        for (var spark in dateGroup.sparks!) {
          allSparks.add(spark);
          // Get the formatted date for this spark (Today/Tomorrow/Date)
          if (dateGroup.isToday == true) {
            sparkDates.add("Today");
          } else if (dateGroup.isTomorrow == true) {
            sparkDates.add("Tomorrow");
          } else {
            sparkDates.add(dateGroup.date ?? "");
          }
        }
      }
    }

    if (allSparks.isEmpty) {
      return Center(
        child: Text(
          "No upcoming sparks",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: allSparks.length,
      itemBuilder: (context, index) {
        final spark = allSparks[index];
        final dateText = sparkDates[index];

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
                        spark.title?.toString() ?? "No Title",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextFontStyle.textStyle16InterW400.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: AppColor.cFFFFFF,
                        ),
                      ),
                    ),
                    Text(
                      spark.daysLeft?.toString() ?? "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextFontStyle.textStyle16InterW400.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff3BB515),
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
                          child: ShimmerImage(
                            placeholder: AppImages.demoAvatar,
                            height: 20.h,
                            width: 20.w,
                            imageUrl: _getFullImageUrl(
                              spark.vip?.avatar ?? spark.createdBy?.avatar,
                            ),
                          ),
                        ),
                        UIHelper.horizontalSpace(8.w),
                        Text(
                          spark.vip?.name?.toString() ?? "My Self",
                          style: TextFontStyle.textStyle16InterW400.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xffaaacb4),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      dateText, // Use the calculated date text
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextFontStyle.textStyle16InterW400.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xffDFE0E5),
                      ),
                    ),
                  ],
                ),
                UIHelper.verticalSpace(14.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    spark.description?.toString() ?? "No Description",
                    style: TextFontStyle.textStyle16InterW400.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xffaaacb4),
                    ),
                  ),
                ),
                UIHelper.verticalSpace(14.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomElevatedButton(
                        padding: const EdgeInsets.all(12),
                        backgroundColor: const Color(0xff353A4E),
                        height: 40.h,
                        text: "View Details",
                        textStyle: TextFontStyle.textStyle10InterW400.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: AppColor.cFFFFFF,
                        ),
                        onPressed: () {
                          // FIX: Add null checks for vip and vip.id
                          String? vipId;
                          if (spark.vip != null && spark.vip.id != null) {
                            vipId = spark.vip.id.toString();
                          }

                          NavigationService.navigateToWithArgs(
                            Routes.vipSparkDetailsScreen,
                            {
                              "id": spark.id?.toString() ?? "0",
                              "vip_id": vipId ?? "0",
                            },
                          );
                        },
                      ),
                    ),
                    UIHelper.horizontalSpace(12.w),
                    Expanded(
                      child: CustomElevatedButton(
                        padding: const EdgeInsets.all(12),
                        height: 40.h,
                        text: "Remind Me",
                        textStyle: TextFontStyle.textStyle10InterW400.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: AppColor.cFFFFFF,
                        ),
                        onPressed: () {
                          setReminderBottomSheet(context,
                              title: spark.title,
                              image: spark.vip == null
                                  ? spark.createdBy.avatar
                                  : spark.vip.avatar,
                              date: upcomingSparks[index].date,
                              time: spark.time,
                              id: spark.id.toString(),
                              isEdit: false);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
