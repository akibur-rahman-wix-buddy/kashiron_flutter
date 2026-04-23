import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import 'package:kashirons_flutter/common_widgets/custom_container.dart';
import 'package:kashirons_flutter/feature/vip_profile/model/vip_profile_model.dart';
import 'package:kashirons_flutter/helpers/all_routes.dart';
import 'package:kashirons_flutter/helpers/navigation_service.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';
import '../../../assets_helperfdg/app_fonts.dart';

void AddNewBottomSheet(
  BuildContext context,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Color(0xff2d3142),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Wrap(
          children: [
            CustomContainer(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Add New",
                        style: TextFontStyle.textStyle16InterW400.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColor.cEDEDED),
                      ),
                      GestureDetector(
                        onTap: () {
                          NavigationService.goBack;
                        },
                        child: SvgPicture.asset(
                          AppIcons.cross,
                          height: 20.h,
                          width: 20.w,
                        ),
                      )
                    ],
                  ),
                  UIHelper.verticalSpace(20.h),
                  GestureDetector(
                    onTap: () {
                      NavigationService.navigateToWithArgs(
                          Routes.addVipProfilePartScreen, {
                        "isEdit": false,
                      });
                    },
                    child: CustomContainer(
                        color: Color(0xff353a4e),
                        borderRadius: 8,
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              AppIcons.userAdd,
                              height: 22.h,
                              width: 22.w,
                            ),
                            UIHelper.horizontalSpace(8.w),
                            Text(
                              "Add VIP Profile",
                              style: TextFontStyle.textStyle16InterW400
                                  .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.cEDEDED),
                            ),
                          ],
                        )),
                  ),
                  UIHelper.verticalSpace(10.h),
                  GestureDetector(
                    onTap: () {
                      NavigationService.navigateTo(
                          Routes.createSparkAndSelfScreen);
                    },
                    child: CustomContainer(
                        color: Color(0xff353a4e),
                        borderRadius: 8,
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              AppIcons.fieldCalander,
                              height: 22.h,
                              width: 22.w,
                            ),
                            UIHelper.horizontalSpace(8.w),
                            Text(
                              "Create Spark",
                              style: TextFontStyle.textStyle16InterW400
                                  .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.cEDEDED),
                            ),
                          ],
                        )),
                  ),
                  UIHelper.verticalSpace(10.h),
                  GestureDetector(
                    onTap: () {
                      NavigationService.navigateToWithArgs(
                          Routes.selfCareReminderScreen, {});
                    },
                    child: CustomContainer(
                        color: Color(0xff353a4e),
                        borderRadius: 8,
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              AppIcons.selfCare,
                              height: 22.h,
                              width: 22.w,
                            ),
                            UIHelper.horizontalSpace(8.w),
                            Text(
                              "Self-Care Spark",
                              style: TextFontStyle.textStyle16InterW400
                                  .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.cEDEDED),
                            ),
                          ],
                        )),
                  ),
                  UIHelper.verticalSpace(10.h),
                ],
              ),
              padding: EdgeInsets.all(20),
            )
          ],
        ),
      );
    },
  );
}
