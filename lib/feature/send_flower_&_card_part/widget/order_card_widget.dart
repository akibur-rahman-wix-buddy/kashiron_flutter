import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_image.dart';
import 'package:kashirons_flutter/common_widgets/custom_shimmer_image.dart';
import 'package:kashirons_flutter/constants/app_constants.dart';
import 'package:kashirons_flutter/feature/send_flower_&_card_part/widget/base_card_widget.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';


class OrderItemsCard extends StatelessWidget {
  final String titleName;
  final String description;
  final dynamic value;

  const OrderItemsCard({
    super.key,
    required this.titleName,
    required this.description,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      icon: AppIcons.orderBox,
      title: "Order Items",
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image and content
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerImage(
                  height: 100,
                  imageUrl: PlaceholderNetworkImageUrl,
                  placeholder: AppImages.placeholderImageItem,
                  width: 100,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Send to $titleName',
                        style: TextFontStyle.textStyle14InterW500.copyWith(color: Colors.white),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        description,
                        style: TextFontStyle.textStyle12InterW400.copyWith(color: Colors.white70),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            value.toString(),
                            style: TextFontStyle.textStyle16InterW700.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}