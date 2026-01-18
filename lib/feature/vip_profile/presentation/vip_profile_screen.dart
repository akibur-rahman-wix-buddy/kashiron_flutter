import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import 'package:kashirons_flutter/common_widgets/custom_app_bar.dart';
import 'package:kashirons_flutter/common_widgets/custom_text_field.dart';
import 'package:kashirons_flutter/feature/vip_profile/widget/vip_profile_add_to_spark_card.dart';
import 'package:kashirons_flutter/helpers/all_routes.dart';
import 'package:kashirons_flutter/helpers/navigation_service.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';
import 'package:kashirons_flutter/networks/api_acess.dart';

class VipProfileScreen extends StatefulWidget {
  const VipProfileScreen({super.key});

  @override
  State<VipProfileScreen> createState() => _VipProfileScreenState();
}

class _VipProfileScreenState extends State<VipProfileScreen> {
  TextEditingController searchTextController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVipProfileListApiRx.getVipProfileList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryBg,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(
            prefixIcon: SvgPicture.asset(
              AppIcons.profileElements,
              height: 24,
              width: 24,
            ),
            title: "VIP Profile",
            actionButton: Icon(Icons.add, color: Colors.white, size: 30),
          ),

          // Wrap the content with Expanded
          StreamBuilder(
              stream: getVipProfileListApiRx.dataFetcher,
              builder: (context, snapshot) {
                final data = snapshot.data?.data ?? [];

                return Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "You have 12 VIPs in your list",
                            style: TextFontStyle.textStyle12InterW400,
                          ),
                          UIHelper.verticalSpace(16.h),

                          /// Search section
                          CustomTextField(
                            hintText: "Search VIP name…",
                            leftIcon: AppIcons.search,
                          ),
                          UIHelper.verticalSpace(16.h),

                          Row(
                            children: [
                              SvgPicture.asset(AppIcons.filter),
                              UIHelper.horizontalSpace(8.w),
                              Text(
                                "Filter by relationship",
                                style: TextFontStyle.textStyle14InterW500,
                              ),
                              UIHelper.horizontalSpace(16.h),
                            ],
                          ),

                          /// Category section
                          UIHelper.verticalSpace(8.h),
                          SizedBox(
                            height: 45.h,
                            child: ListView.builder(
                              primary: false,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.all(5.h),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Selected Category ${index + 1}")),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF2D3142),
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                          width: 1,
                                          color: Color(0xFF32374C),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(30.r),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 20.w,
                                        vertical: 7.h,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.category,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 6.w),
                                        Text(
                                          'Category ${index + 1}',
                                          style: TextFontStyle
                                              .textStyle12InterW400
                                              .copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          /// Card section
                          UIHelper.verticalSpace(16.h),

                          ListView.builder(
                            itemCount: data[0].vips!.length,
                            shrinkWrap: true,
                            physics:
                                const NeverScrollableScrollPhysics(), // Add this
                            primary: false,
                            padding: EdgeInsets.zero,

                            itemBuilder: (context, index) {
                              final familyData = data[0].vips;

                              return Column(
                                children: [
                                  vipProfileAddToSparkCard(
                                    onCardTap: () {
                                      NavigationService.navigateTo(
                                          Routes.vipDetailsScreen);
                                    },
                                    type: familyData![index]
                                        .relation!
                                        .name
                                        .toString(),
                                    name: familyData[index].name.toString(),
                                    birthdayDate: familyData[index]
                                        .anniversaryDate
                                        .toString(),
                                    onAddSparkTap: () {},
                                    sparkNumber:
                                        familyData[index].sparkCount.toString(),
                                    buttonName: 'Add Heads-Up',
                                    imageUrl:
                                        familyData[index].avatar.toString(),
                                  ),
                                  UIHelper.verticalSpace(
                                      8.h), // Add spacing between cards
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
