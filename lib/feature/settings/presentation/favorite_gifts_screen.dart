import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import 'package:kashirons_flutter/common_widgets/custom_app_bar.dart';
import 'package:kashirons_flutter/common_widgets/custom_text_field.dart';
import 'package:kashirons_flutter/feature/brobrain_gift_list/widget/product_card.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';
import 'package:kashirons_flutter/networks/api_acess.dart';
import 'package:kashirons_flutter/networks/endpoints.dart';
import 'package:url_launcher/url_launcher.dart';

class FavoriteGiftsScreen extends StatefulWidget {
  const FavoriteGiftsScreen({super.key});

  @override
  State<FavoriteGiftsScreen> createState() => _FavoriteGiftsScreenState();
}

class _FavoriteGiftsScreenState extends State<FavoriteGiftsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    favoriteGiftsApiRx.favoriteGifts();
  }

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
                    style: TextFontStyle.textStyle14InterW500
                        .copyWith(color: Colors.white60),
                  ),
                  UIHelper.verticalSpace(16.h),

                  Expanded(
                    child: StreamBuilder(
                      stream: favoriteGiftsApiRx.dataFetcher,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        final items = snapshot.data?.data;

                        if (items == null || items.isEmpty) {
                          return const Center(
                            child: Text(
                              "No favorite gifts found",
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }

                        return GridView.builder(
                          padding: const EdgeInsets.all(12),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.w,
                            mainAxisSpacing: 10.h,
                            childAspectRatio: 100 / 150,
                          ),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final data = items[index];

                            return ProductCard(
                                imageUrl: data.images?[0].url ?? "",
                                isLoveValue: true,
                                price: data.price?.amount?.toString() ?? "0",
                                productName: data.title ?? "",
                                isBuyGiftClick: () async {
                                  final url = data.url;
                                  if (url == null || url.isEmpty) return;
                                  final uri = Uri.parse(url);
                                  if (!await launchUrl(
                                    uri,
                                    mode: LaunchMode.platformDefault,
                                  )) {
                                    debugPrint('Could not launch $url');
                                  }
                                });
                          },
                        );
                      },
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
