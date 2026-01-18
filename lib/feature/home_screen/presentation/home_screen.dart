import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import 'package:kashirons_flutter/feature/brobrain_gift_list/widget/product_card.dart';
import 'package:kashirons_flutter/feature/home_screen/model/home_api_data_model.dart' hide UpcomingSparks;
import 'package:kashirons_flutter/feature/home_screen/widget/add_new_bottomsheet.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';
import 'package:kashirons_flutter/networks/api_acess.dart';
import 'package:kashirons_flutter/networks/endpoints.dart';
import '../../../assets_helperfdg/app_fonts.dart';
import '../widget/home_app_bar.dart';
import '../widget/top_section_data.dart';
import '../widget/upcoming_birthday.dart';
import '../widget/upcoming_sparks.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    homeApiDataRx.homeApiDataApiInfo();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryBg,

      /// ============================ FAB ====================== ///
      floatingActionButton: Container(
        height: 60.h,
        width: 60.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: const Color(0xffF0F0F0).withValues(alpha: 0.4),
              blurRadius: 50,
              spreadRadius: 0,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {
            AddNewBottomSheet(context);
          },
          backgroundColor: const Color(0xFFA4161A),
          shape: const CircleBorder(),
          child: SvgPicture.asset(
            AppIcons.plusIcon,
            height: 24.h,
            width: 24.w,
          ),
        ),
      ),

      body: Column(
        children: [
          /// ============================ App bar ====================== ///
          HomeAppBar(),
          UIHelper.verticalSpace(20.h),
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: StreamBuilder<HomeApiDataModel>(
                  stream: homeApiDataRx.dataFetcher,
                  builder: (context, snapshot) {
                    // First check for connection state
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox(
                        height: 100.h,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColor.cFFFFFF,
                            strokeWidth: 2.w,
                          ),
                        ),
                      );
                    }

                    // Check for errors
                    if (snapshot.hasError) {
                      return Text(
                        "Error: ${snapshot.error}",
                        style: TextStyle(color: AppColor.cFFFFFF),
                      );
                    }

                    // Check if we have data
                    if (!snapshot.hasData) {
                      return Text(
                        "No data available",
                        style: TextStyle(color: AppColor.cFFFFFF),
                      );
                    }

                    final homeData = snapshot.data!;

                    // Check if the API call was successful
                    if (homeData.success != true) {
                      return Text(
                        homeData.message ?? "API call failed",
                        style: TextStyle(color: AppColor.cFFFFFF),
                      );
                    }

                    // Check if data object exists
                    if (homeData.data == null) {
                      return Text(
                        "No data available",
                        style: TextStyle(color: AppColor.cFFFFFF),
                      );
                    }

                    final data = homeData.data!;

                    return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// ============================ top cards  ====================== ///
                      TopSectionData(
                        birthday:data.vipBirthdaysThisMonth.toString(),
                        sparks: data.thisWeekSparks.toString(),
                        vip: data.totalVipProfiles.toString(),
                      ),
                      UIHelper.verticalSpace(20.h),
                      Text(
                        "Upcoming Sparks",
                        style: TextFontStyle.textStyle16InterW400.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColor.cFFFFFF),
                      ),
                      UIHelper.verticalSpace(8.h),

                      /// ============================ Upcoming Sparks ====================== ///
                      UpcomingSparksWidget(),
                      UIHelper.verticalSpace(8.h),
                      Text(
                        "Upcoming Birthday",
                        style: TextFontStyle.textStyle16InterW400.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColor.cFFFFFF),
                      ),
                      UIHelper.verticalSpace(12.h),

                      /// ============================ Birthday ====================== ///
                      UpcomingBirthday(),
                      UIHelper.verticalSpace(8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Popular Gift",
                            style: TextFontStyle.textStyle16InterW400.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColor.cFFFFFF),
                          ),
                          Text(
                            "View all",
                            style: TextFontStyle.textStyle16InterW400.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xffEF233C)),
                          ),
                        ],
                      ),
                      UIHelper.verticalSpace(4.h),
                      Text(
                        "Browse the most popular gifts on\nBrobrain lists",
                        style: TextFontStyle.textStyle16InterW400.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff787A83)),
                      ),
                      UIHelper.verticalSpace(16.h),

                      /// ============================ Popular Gifts ====================== ///
                      SizedBox(
                        height: 250,
                        child: ListView.builder(
                          itemCount: 4,
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            return ProductCard(
                              imageUrl: personImageUrl,
                              isLoveValue: false,
                              price: 250.toString(),
                              productName: "Smart Watch",
                              isBuyGiftClick: () {},
                            );
                            ;
                          },
                        ),
                      ),

                      //
                      // PopularGifts(
                      //   imageUrl: personImageUrl,
                      //   isLove: true,
                      //   value: 2600.toString(),
                      //   title: "Smart Watch",
                      // ),
                      UIHelper.verticalSpace(30.h),
                    ],
                  );
                }
              ),
            ),
          ))
        ],
      ),
    );
  }
}
