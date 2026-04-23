import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import 'package:kashirons_flutter/feature/brobrain_gift_list/widget/product_card.dart';
import 'package:kashirons_flutter/feature/home_screen/model/home_api_data_model.dart'
    hide UpcomingSparks, UpcomingBirthday;
import 'package:kashirons_flutter/feature/home_screen/widget/add_new_bottomsheet.dart';
import 'package:kashirons_flutter/feature/home_screen/widget/dashboard_shimmer.dart';
import 'package:kashirons_flutter/helpers/all_routes.dart';
import 'package:kashirons_flutter/helpers/navigation_service.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';
import 'package:kashirons_flutter/networks/api_acess.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
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
    getUserProfileRx.getProfileApiData();
    super.initState();
  }

  void _onViewAllTap() {
    NavigationService.navigateTo(Routes.brobrainGiftListScreen);
    // Or show a snackbar/dialog for now
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text('View all popular gifts'),
    //     duration: Duration(seconds: 2),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryBg,
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
          StreamBuilder(
            stream: getUserProfileRx.dataFetcher,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return homeAppBarShimmer();
              }

              if (snapshot.hasError) {
                return homeAppBarShimmer();
              }

              if (!snapshot.hasData ||
                  snapshot.data == null ||
                  snapshot.data!.data == null ||
                  snapshot.data!.data!.user == null) {
                return homeAppBarShimmer();
              }

              final user = snapshot.data!.data!.user!;

              return HomeAppBar(
                user: user,
              );
            },
          ),
          UIHelper.verticalSpace(20.h),
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: StreamBuilder<HomeApiDataModel>(
                  stream: homeApiDataRx.dataFetcher,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: DashboardShimmer(),
                      );
                    }

                    if (!snapshot.hasData) {
                      return Center(child: DashboardShimmer());
                    }

                    final homeData = snapshot.data!;

                    if (homeData.success != true) {
                      return Text(
                        homeData.message ?? "API call failed",
                        style: TextStyle(color: AppColor.cFFFFFF),
                      );
                    }

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
                        TopSectionData(
                          birthday: data.vipBirthdaysThisMonth.toString(),
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
                        UpcomingSparksWidget(
                          upcomingSparks:
                              data.upcomingSparks?.original?.data ?? [],
                        ),
                        UIHelper.verticalSpace(8.h),
                        Text(
                          "Upcoming Birthday",
                          style: TextFontStyle.textStyle16InterW400.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColor.cFFFFFF),
                        ),
                        UIHelper.verticalSpace(12.h),
                        UpcomingBirthday(
                          upcomingBirthday: data.upcomingBirthdays!,
                        ),
                        UIHelper.verticalSpace(8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Popular Gift",
                              style: TextFontStyle.textStyle16InterW400
                                  .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.cFFFFFF),
                            ),
                            GestureDetector(
                              onTap: _onViewAllTap,
                              child: Text(
                                "View all",
                                style: TextFontStyle.textStyle16InterW400
                                    .copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xffEF233C)),
                              ),
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
                        SizedBox(
                          height: 252.h,
                          child: ListView.builder(
                            itemCount:
                                data.popularGifts!.original?.data?.length ?? 0,
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              return ProductCard(
                                id: data.popularGifts?.original?.data?[index].id
                                    .toString(),
                                imageUrl: data.popularGifts?.original
                                        ?.data?[index].mainImage ??
                                    " ",
                                isLoveValue: data.popularGifts?.original
                                        ?.data?[index].isFavourite ??
                                    false,
                                price: data.popularGifts?.original?.data?[index]
                                        .price?.amount
                                        .toString() ??
                                    " ",
                                productName: data.popularGifts?.original
                                        ?.data?[index].title ??
                                    " ",
                                isBuyGiftClick: () async {
                                  final url = data
                                      .popularGifts?.original?.data?[index].url;

                                  if (url == null || url.isEmpty) return;

                                  final uri = Uri.parse(url);

                                  if (!await launchUrl(
                                    uri,
                                    mode: LaunchMode.externalApplication,
                                  )) {
                                    debugPrint('Could not launch $url');
                                  }
                                },
                              );
                            },
                          ),
                        ),
                        UIHelper.verticalSpace(30.h),
                      ],
                    );
                  }),
            ),
          ))
        ],
      ),
    );
  }
}

Widget homeAppBarShimmer() {
  return Container(
    height: 124.h,
    width: double.infinity,
    color: const Color(0xFF2E3445), // same dark background
    child: Column(
      children: [
        SizedBox(height: 60.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade700,
                    highlightColor: Colors.grey.shade500,
                    child: Container(
                      height: 44.h,
                      width: 44.w,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade700,
                        highlightColor: Colors.grey.shade500,
                        child: Container(
                          height: 12.h,
                          width: 110.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade700,
                        highlightColor: Colors.grey.shade500,
                        child: Container(
                          height: 10.h,
                          width: 140.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Shimmer.fromColors(
                baseColor: Colors.grey.shade700,
                highlightColor: Colors.grey.shade500,
                child: Container(
                  height: 36.h,
                  width: 36.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
