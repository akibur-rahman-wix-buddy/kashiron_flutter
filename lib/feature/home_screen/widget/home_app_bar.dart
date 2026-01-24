import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import 'package:kashirons_flutter/common_widgets/shimmerClipOverImageWidget.dart';
import 'package:kashirons_flutter/feature/settings/model/user_infi_data_model.dart';
import 'package:kashirons_flutter/helpers/all_routes.dart';
import 'package:kashirons_flutter/helpers/navigation_service.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';
import 'package:kashirons_flutter/networks/api_acess.dart';
import '../../../assets_helperfdg/app_fonts.dart';

class HomeAppBar extends StatefulWidget {
  final dynamic user;

  const HomeAppBar({super.key, this.user});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  void initState() {
    super.initState();
  }

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
                    shimmerClipOvalWidget(
                      height: 44.h,
                      weight: 44.w,
                      networkImageLink: widget.user.avatar,
                    ),
                    UIHelper.horizontalSpace(10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello ${widget.user.name}",
                          style: TextFontStyle.textStyle16InterW400.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColor.cFFFFFF,
                          ),
                        ),
                        UIHelper.verticalSpace(4.h),
                        Text(
                          "Welcome to BroBrain",
                          style: TextFontStyle.textStyle16InterW400.copyWith(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xffd7d7d7),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    NavigationService.navigateTo(
                      Routes.notificationScreen,
                    );
                  },
                  child: SvgPicture.asset(
                    AppIcons.notificationIcon,
                    height: 36.h,
                    width: 36.w,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
