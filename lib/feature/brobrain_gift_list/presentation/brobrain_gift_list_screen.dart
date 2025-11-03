
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import 'package:kashirons_flutter/common_widgets/custom_app_bar.dart';
import 'package:kashirons_flutter/common_widgets/custom_text_field.dart';
import 'package:kashirons_flutter/feature/brobrain_gift_list/widget/product_card.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';

class BrobrainGiftListScreen extends StatefulWidget {
  const BrobrainGiftListScreen({super.key});

  @override
  State<BrobrainGiftListScreen> createState() => _BrobrainGiftListScreenState();
}

class _BrobrainGiftListScreenState extends State<BrobrainGiftListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryBg,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// App Bar
          CustomAppBar(
            title: "Brobrain Giftlist",
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

          /// Category Horizontal List
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
                      // Define tap action here (e.g., select category)
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Selected Category ${index + 1}")),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2D3142),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 1,
                          color: Color(0xFF32374C),
                        ),
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 7.h,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Category ${index + 1}',
                        style: TextFontStyle.textStyle12InterW400,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          UIHelper.verticalSpace(16.h),

          /// Most Popular Section
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [


                    ///>>>>>>>>>>>>> here is the mose popular section >>>>>>>>>>>>>>>>>>
                    BrobrainRowCard(
                      title: "Most Popular",
                      onCLickViewAll: (){},
                    ),
                    UIHelper.verticalSpace(16.h),

                    /// Horizontal Gifts List with fixed height
                    SizedBox(
                      height: 230.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return ProductCard(isLoveValue: false,price: 250.toString(),productName: "Smart Watch", isBuyGiftClick: () {  },);
                        },
                      ),
                    ),

                    UIHelper.verticalSpace(8.h),

                    ///>>>>>>>>>>>>> here is women  section >>>>>>>>>>>>>>>>>>


                    BrobrainRowCard(
                      title: "For Women",
                      onCLickViewAll: (){},
                    ),
                    UIHelper.verticalSpace(8.h),

                    /// Horizontal Gifts List with fixed height
                    SizedBox(
                      height: 230.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return ProductCard(isLoveValue: false,price: 250.toString(),productName: "Smart Watch", isBuyGiftClick: () {  },);
                        },
                      ),
                    ),


                    UIHelper.verticalSpace(16.h),
                    ///>>>>>>>>>>>>> here is women  section >>>>>>>>>>>>>>>>>>


                    BrobrainRowCard(
                      title: "For wan",
                      onCLickViewAll: (){},
                    ),
                    UIHelper.verticalSpace(8.h),

                    /// Horizontal Gifts List with fixed height
                    SizedBox(
                      height: 230.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return ProductCard(isLoveValue: false,price: 250.toString(),productName: "Smart Watch", isBuyGiftClick: () {  },);
                        },
                      ),
                    ),
                    UIHelper.verticalSpace(16.h),
                    ///>>>>>>>>>>>>> here is Baby section >>>>>>>>>>>>>>>>>>


                    BrobrainRowCard(
                      title: "Baby",
                      onCLickViewAll: (){},
                    ),
                    UIHelper.verticalSpace(8.h),

                    /// Horizontal Gifts List with fixed height
                    SizedBox(
                      height: 230.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return ProductCard(isLoveValue: false,price: 260.toString(),productName: "Smart Watch", isBuyGiftClick: () {  },);
                        },
                      ),
                    ),





                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BrobrainRowCard extends StatelessWidget {
  const BrobrainRowCard({
    super.key, required this.title, required this.onCLickViewAll,
  });
final String title;
final VoidCallback onCLickViewAll;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextFontStyle.textStyle18InterW700,
        ),
        TextButton(
          onPressed: onCLickViewAll,
          child: Text(
            "View all",
            style: TextFontStyle.textStyle18InterW700,
          ),
        ),
      ],
    );
  }
}