import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import 'package:kashirons_flutter/common_widgets/custom_app_bar.dart';
import 'package:kashirons_flutter/common_widgets/custom_text_field.dart';
import 'package:kashirons_flutter/feature/brobrain_gift_list/widget/product_card.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';

class FavoriteGiftsScreen extends StatefulWidget {
  const FavoriteGiftsScreen({super.key});

  @override
  State<FavoriteGiftsScreen> createState() => _FavoriteGiftsScreenState();
}

class _FavoriteGiftsScreenState extends State<FavoriteGiftsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryBg,
      body: Column(
        children: [
          /// App Bar
          CustomAppBar(
            title: "Favorite Gifts",
          ),
          UIHelper.verticalSpace(16.h),

          /// Search Field
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: CustomTextField(
              hintText: "Search for gifts...",
              leftIcon: AppIcons.search,
            ),
          ),
          UIHelper.verticalSpace(16.h),

          /// Content Section
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Header
                  Text(
                    "Your Favorite Gifts Items",
                    style: TextFontStyle.textStyle18InterW700,
                  ),
                  UIHelper.verticalSpace(16.h),

                  /// Description
                  Text(
                    "All the gifts you've saved from the Brobrain gift lists are displayed here. You can review them anytime and purchase whenever you're ready.",
                    style: TextFontStyle.textStyle14InterW500.copyWith(color: Colors.white60),
                  ),
                  UIHelper.verticalSpace(16.h),

                  /// Grid View - Properly Centered
                  Expanded(
                    child: Center(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.w,
                          mainAxisSpacing: 10.h,
                          childAspectRatio: 100 / 150,
                        ),
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return ProductCard(
                            isLoveValue: false,
                            price: 250.toString(),
                            productName: "Smart Watch",
                            isBuyGiftClick: () {},
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}