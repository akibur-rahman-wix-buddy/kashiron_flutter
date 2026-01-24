import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import 'package:kashirons_flutter/common_widgets/custom_app_bar.dart';
import 'package:kashirons_flutter/common_widgets/custom_text_field.dart';
import 'package:kashirons_flutter/feature/vip_profile/model/vip_profile_list_model.dart';
import 'package:kashirons_flutter/feature/vip_profile/widget/vip_list_shimmer.dart';
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
  int selectedIndex = 0;

  List vipListAll = [];
  List vipListFiltered = [];

  @override
  void initState() {
    super.initState();

    getVipProfileListApiRx.getVipProfileList();
    searchTextController.addListener(() {
      filterVipList(searchTextController.text);
    });
  }

  void filterVipList(String query) {
    final allCategory = getVipProfileListApiRx.dataFetcher.value.data
        ?.firstWhere((item) => item.name == "All", orElse: null);

    if (allCategory != null) {
      setState(() {
        vipListAll = allCategory.vips;
        if (query.isEmpty) {
          vipListFiltered = vipListAll;
        } else {
          vipListFiltered = vipListAll
              .where((vip) => vip.name
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()))
              .toList();
        }
      });
    }
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
            actionButton: GestureDetector(
                onTap: () {
                  NavigationService.navigateTo(Routes.addVipProfilePartScreen);
                },
                child: Icon(Icons.add, color: Colors.white, size: 30)),
          ),
          StreamBuilder(
              stream: getVipProfileListApiRx.dataFetcher,
              builder: (context, snapshot) {
                final data = snapshot.data?.data ?? [];
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const VipListShimmer();
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Something went wrong',
                      style: TextFontStyle.textStyle14InterW400c787A83
                          .copyWith(color: Colors.redAccent),
                    ),
                  );
                }

                if (data.isEmpty) {
                  return const VipListShimmer();
                }

                final allDataCategory = data.firstWhere(
                  (item) => item.name == "All",
                  orElse: () => Datum(name: "All", vips: []),
                );

                final allDataLength = allDataCategory.vips?.length ?? 0;

                if (vipListAll.isEmpty) {
                  vipListAll = allDataCategory.vips ?? [];
                  vipListFiltered = vipListAll;
                }

                return Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "You have ${allDataLength.toString()} VIPs in your list",
                            style: TextFontStyle.textStyle12InterW400,
                          ),
                          UIHelper.verticalSpace(16.h),

                          CustomTextField(
                            controller: searchTextController,
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
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.all(5.h),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedIndex = index;
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content:
                                                Text(data[index].name ?? " ")),
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
                                          data[index].name ?? " ",
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
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: selectedIndex == 0
                                ? vipListFiltered.length
                                : data[selectedIndex].vips.length ?? 0,
                            itemBuilder: (context, index) {
                              final listData = selectedIndex == 0
                                  ? vipListFiltered
                                  : data[selectedIndex].vips ?? [];

                              final vip = listData[index];

                              return Column(
                                children: [
                                  vipProfileAddToSparkCard(
                                    onCardTap: () {
                                      NavigationService.navigateToWithArgs(
                                          Routes.vipDetailsScreen,
                                          {"id": vip.id.toString()});
                                    },
                                    type: vip.relation?.name ?? "",
                                    // null-safe
                                    name: vip.name ?? "",
                                    birthdayDate:
                                        vip.anniversaryDate?.toString() ?? "",
                                    onAddSparkTap: () {},
                                    sparkNumber:
                                        vip.sparkCount?.toString() ?? "0",
                                    buttonName: 'Add Heads-Up',
                                    imageUrl: vip.avatar ?? "",
                                  ),
                                  UIHelper.verticalSpace(8.h),
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
