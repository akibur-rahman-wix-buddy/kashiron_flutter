import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import 'package:kashirons_flutter/feature/send_flower_&_card_part/widget/vip_badge_widget.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';

import 'base_card_widget.dart';


class DeliveryAddressCard extends StatelessWidget {
  final String sendToName;
  final String deliveryAddress;
  final bool isVip;

  const DeliveryAddressCard({
    super.key,
    required this.sendToName,
    required this.deliveryAddress,
    required this.isVip,
  });

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      icon: AppIcons.location,
      title: "Delivery Address",
      titleStyle: TextFontStyle.textStyle14InterW500.copyWith(color: Colors.white60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name and VIP badge
          Row(
            children: [
              Text(
                'Send to $sendToName',
                style: TextFontStyle.textStyle16InterW700.copyWith(color: Colors.white),
              ),
              if (isVip) ...[
                SizedBox(width: 8.w),
                VipBadge(),
              ],
            ],
          ),
          SizedBox(height: 8.h),
          // Address
          Text(
            deliveryAddress,
            style: TextFontStyle.textStyle12InterW400.copyWith(color: Colors.white70),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}