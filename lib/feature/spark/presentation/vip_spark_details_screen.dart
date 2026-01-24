import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/common_widgets/custom_app_bar.dart';
import 'package:kashirons_flutter/constants/app_constants.dart';
import 'package:kashirons_flutter/feature/spark/model/interest_wise_product_model.dart';
import 'package:kashirons_flutter/feature/spark/model/spark_show_model.dart';
import 'package:kashirons_flutter/feature/spark/widget/SparkBottomCard.dart';
import 'package:kashirons_flutter/feature/spark/widget/reminder_bottom_sheet.dart';
import 'package:kashirons_flutter/feature/spark/widget/reroll_gifts_button.dart';
import 'package:kashirons_flutter/feature/spark/widget/spark_delete_dialogue.dart';
import 'package:kashirons_flutter/feature/spark/widget/spark_hading_card.dart';
import 'package:kashirons_flutter/feature/spark/widget/spark_product_card.dart';
import 'package:kashirons_flutter/helpers/all_routes.dart';
import 'package:kashirons_flutter/helpers/navigation_service.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';
import 'package:kashirons_flutter/networks/api_acess.dart';

class VipSparkDetailsScreen extends StatefulWidget {
  final String id;
  final String vip_id;

  const VipSparkDetailsScreen(
      {super.key, required this.id, required this.vip_id});

  @override
  State<VipSparkDetailsScreen> createState() => _VipSparkDetailsScreenState();
}

class _VipSparkDetailsScreenState extends State<VipSparkDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vipSparksDetailsApiRx.getVipSparksDetails(id: widget.id.toString());

    interestWiseProductApiRx.getInterestWideProducts(
        id: widget.vip_id.toString());
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;

    return Scaffold(
      backgroundColor: AppColor.primaryBg,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ============================ App bar ====================== ///
          CustomAppBar(
            title: "Spark Details",
          ),

          /// ============================ Scrollable Content ====================== ///
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// ============================ Fixed Header Section ====================== ///
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StreamBuilder<SparkShowModel>(
                          stream: vipSparksDetailsApiRx.dataFetcher,
                          builder: (context, snapshot) {
                            // 1️⃣ Loading / no data yet
                            if (!snapshot.hasData || snapshot.data == null) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            final model = snapshot.data!;
                            final data = model.data;

                            // 2️⃣ API returned but data is null
                            if (data == null || data.vip == null) {
                              return const SizedBox(); // or error widget
                            }

                            // 3️⃣ SAFE to use now
                            return SparkHadingCard(
                              title: data.title ?? '',
                              image: data.vip?.avatar ?? '',
                              name: data.vip?.name ?? '',
                              description: data.description ?? '',
                              leftDate: data.formattedDate ?? '',
                              relation: data.vip?.relation?.name ?? '',
                              leftTime: data.daysStatus ?? '',
                            );
                          },
                        ),

                        UIHelper.verticalSpace(16.h),

                        // This section stays fixed at the top
                        Container(
                          color: AppColor.primaryBg,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Gift Ideas for Mother",
                                    style: TextFontStyle.textStyle16InterW700,
                                  ),
                                  RerollButton(
                                    onTap: () {
                                      print("Reroll API called!");
                                    },
                                  ),
                                ],
                              ),
                              UIHelper.verticalSpace(8.h),
                              Divider(
                                color: Colors.white,
                                height: 3,
                              ),
                              UIHelper.verticalSpace(8.h),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// ============================ GridView Section ====================== ///
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: StreamBuilder<VipInterestWiseProductModel>(
                      stream: interestWiseProductApiRx.dataFetcher,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (snapshot.hasError) {
                          return const Center(
                              child: Text("Something went wrong"));
                        }

                        if (!snapshot.hasData ||
                            snapshot.data == null ||
                            snapshot.data!.data == null ||
                            snapshot.data!.data!.isEmpty) {
                          return const Center(child: Text("No products found"));
                        }

                        final products = snapshot.data!.data!;

                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 100 / 145,
                          ),
                          itemCount: products.length,
                          padding: const EdgeInsets.only(bottom: 16),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final data = products[index];

                            return SparkProductCard(
                              isFavorite: data.isFavourite ?? false,
                              title: data.title ?? "",
                              price:
                                  double.tryParse(data.price?.amount ?? '0') ??
                                      0.0,
                              image: data.mainImage.toString(),
                              onBuyTap: () {
                                print("Buy gift tapped for index $index");
                              },
                              id: data.productId.toString(),
                            );
                          },
                        );
                      },
                    ),
                  ),

                  /// "Surprise Flowers" Text at the bottom
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    child: Text(
                      "Surprise Flowers",
                      style: TextFontStyle.textStyle18InterW700,
                    ),
                  ),
                  SparkCard(
                    iconCircleColor: Color(0xFF009F50),
                    ifButton: true,
                    onTap: () {
                      NavigationService.navigateTo(Routes.sendFlowerCardScreen);
                    },
                    title: "Send Flowers & Card",
                    subTitle: "Deliver fresh flowers with a personalized card ",
                    buttonName: "Send Now",
                    iconName: Icons.settings,
                  ),

                  ///>>>>>>>>>>>>>>>>>>>>>> option section >>>>>>>>>>>>>>>>>>>>>>>>
                  UIHelper.verticalSpace(16),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    child: Text(
                      "Option",
                      style: TextFontStyle.textStyle18InterW700,
                    ),
                  ),
                  SparkCard(
                    iconCircleColor: Color(0xFF009F50),
                    ifButton: false,
                    onTap: () {
                      SparkDeleteDialog.showLogoutDialog(
                        context: context,
                        onLogout: () async {
                          setState(() {
                            isLoading = true;
                          });
                          bool success = await sparkDeleteApiRx.sparkDelete(
                              id: widget.id.toString());
                          if (success) {
                            setState(() {
                              isLoading = false;
                            });
                            NavigationService.navigateTo(
                                Routes.customBottomNavBar);
                          }
                          setState(() {
                            isLoading = false;
                          });
                        },
                        isLoading: isLoading,
                      );
                    },
                    title: "Delete Spark",
                    subTitle: "Remove this reminder",
                    buttonName: "Send Now",
                    iconName: Icons.delete,
                  ),
                  UIHelper.verticalSpace(16.h),
                  SparkCard(
                    iconCircleColor: Color(0xFFEB690E),
                    ifButton: true,
                    onTap: () {
                      NavigationService.navigateToWithArgs(
                          Routes.selfCareReminderScreen,
                          {"id": widget.vip_id, "spark_id": widget.id});
                      //
                      // ReminderBottomSheet.show(context,
                      //     id: widget.vip_id, spark_id: widget.id);
                      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${widget.vip_id}<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
                      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${widget.id}<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
                    },
                    title: "Remind Me",
                    subTitle:
                        "Set a reminder to receive alerts before this spark.",
                    buttonName: "Set",
                    iconName: Icons.notification_important,
                  ),
                  UIHelper.verticalSpace(16.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
