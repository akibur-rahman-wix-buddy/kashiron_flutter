import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_image.dart';
import 'package:kashirons_flutter/common_widgets/custom_app_bar.dart';
import 'package:kashirons_flutter/common_widgets/custom_shimmer_image.dart';
import 'package:kashirons_flutter/common_widgets/custom_text_field.dart';
import 'package:kashirons_flutter/feature/brobrain_gift_list/widget/product_card.dart';
import 'package:kashirons_flutter/feature/settings/widget/order_history_card.dart';
import 'package:kashirons_flutter/helpers/all_routes.dart';
import 'package:kashirons_flutter/helpers/navigation_service.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';
import 'package:kashirons_flutter/networks/endpoints.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {

List<String> category = [ "All","Delivered","Pending"];
int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryBg,
      body: Column(
        children: [
          /// App Bar
          CustomAppBar(
            title: "Order History",
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
                    "Your Gift Order History",
                    style: TextFontStyle.textStyle18InterW700,
                  ),
                  UIHelper.verticalSpace(16.h),

                  /// Description
                  Text(
                    "Track all your past and current gift orders from Brobrain. Review details and stay updated with the delivery status anytime.",
                    style: TextFontStyle.textStyle14InterW500.copyWith(color: Colors.white60),
                  ),
                  UIHelper.verticalSpace(16.h),

                  /// Category Horizontal List
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      height: 45.h,
                      child: ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: category.length,
                        itemBuilder: (context, index) {
                          bool isSelected = selectedCategoryIndex == index;

                          return Padding(
                            padding: EdgeInsets.all(5.h),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  selectedCategoryIndex = index;
                                });
                                // Add your category filter logic here
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isSelected ? const Color(0xFF4A5065) : const Color(0xFF2D3142),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 1,
                                    color: isSelected ? Colors.white : const Color(0xFF32374C),
                                  ),
                                  borderRadius: BorderRadius.circular(30.r),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.w,
                                  vertical: 7.h,
                                ),
                              ),
                              child: Text(
                                category[index],
                                style: TextFontStyle.textStyle12InterW400.copyWith(
                                  color: isSelected ? Colors.white : Colors.white70, // Optional: change text color too
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  UIHelper.verticalSpace(8.h),

               Expanded(
                 child: ListView.builder(
                   itemCount: 10,
                   shrinkWrap: true,
                   primary: false,
                   itemBuilder: (context,index) {
                     return OrderHistoryCard(
                       onTap: (){
                         NavigationService.navigateTo(Routes.orderDetailsScreen);
                       },
                       price: "205",
                       orderDateTime: "15 July 2025, 10:00 AM",
                       orderId: "#BOK 782 085",
                       status:"Pending",
                       productName: "Smart Watch",
                     );
                   }
                 ),
               )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
