import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_image.dart';
import 'package:kashirons_flutter/common_widgets/custom_shimmer_image.dart';
import 'package:kashirons_flutter/common_widgets/shimmerClipOverImageWidget.dart';
import 'package:kashirons_flutter/constants/app_constants.dart';

import '../../spark/widget/spark_product_card.dart' show ShimmerImage;

class ChooseFlowerCard extends StatelessWidget {
  const ChooseFlowerCard({
    super.key,
    required this.titleName,
    required this.address,
    required this.isVip,
    required this.isSelected,
    required this.onTap,
    required this.value,
  });

  final String titleName;
  final String address;
  final bool isVip;
  final bool isSelected;
  final VoidCallback onTap;
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: ShapeDecoration(
          color: const Color(0xFF2D3142),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: isSelected ? 2.w : 1.w,
              color: isSelected ?  const Color(0xFFEDEDED):Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Location icon and content
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerImage(height: 100, imageUrl:PlaceholderNetworkImageUrl, placeholder:AppImages.placeholderImageItem , width: 100,),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name and VIP badge
                        Text(
                          'Send to $titleName',
                          style: TextFontStyle.textStyle16InterW700.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        // Address
                        Text(
                          address,
                          style: TextFontStyle.textStyle12InterW400.copyWith(
                            color: Colors.white70,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              value.toString(),
                              style: TextFontStyle.textStyle16InterW700.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration:  BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                color: Colors.white12
                              ),child: Center(
                              child: Text("Select",style: TextStyle(color: Colors.white),),
                            ),
                            )



                          ],
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Selection indicator
            Container(
              width: 20.w,
              height: 20.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? const Color(0xFFA4161A) : Colors.transparent,
                border: Border.all(
                  color: isSelected ? const Color(0xFFA4161A) : Colors.transparent,
                  width: 2.w,
                ),
              ),
              child: isSelected
                  ? Icon(
                Icons.check,
                size: 14.w,
                color: Colors.white,
              )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}