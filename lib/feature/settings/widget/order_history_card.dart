
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_image.dart';
import 'package:kashirons_flutter/common_widgets/custom_shimmer_image.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';
import 'package:kashirons_flutter/networks/endpoints.dart';

class OrderHistoryCard extends StatelessWidget {
  const OrderHistoryCard({
    super.key, required this.productName, required this.price, required this.orderDateTime, required this.orderId, required this.status, required this.onTap,
  });


  final String productName;
  final String price;
  final String orderDateTime;
  final String orderId;
  final String status;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsetsGeometry.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: ShapeDecoration(
          color: const Color(0xFF2D3142),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ShimmerImage(imageUrl: personImageUrl, placeholder: AppImages.placeholderImageItem, height: 56, width: 72),
                  UIHelper.horizontalSpace(8.w),
                  SizedBox(
                    height: 70,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(productName,style: TextFontStyle.textStyle16InterW700,),
                        Text("\$$price",style: TextFontStyle.textStyle16InterW700.copyWith(color: Color(0xFFEF233C)),)
                      ],
                    ),
                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: ShapeDecoration(
                  color: const Color(0x21FFA144),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),child: Text(status,style: TextFontStyle.textStyle14InterW500,),
              )
            ],
          ),
          UIHelper.verticalSpace(16.h),
          Divider(color: Colors.white,height: 2,),
          UIHelper.verticalSpace(16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Order Date",style: TextFontStyle.textStyle14InterW500,),
              Text(orderDateTime,style: TextFontStyle.textStyle14InterW500,),
            ],
          ), UIHelper.verticalSpace(8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Order ID",style: TextFontStyle.textStyle14InterW500,),
              Text(orderId,style: TextFontStyle.textStyle14InterW500,),
            ],
          )
        ],
      ),
      ),
    );
  }
}





