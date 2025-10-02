

import 'package:flutter/material.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/common_widgets/custom_app_bar.dart';
import 'package:kashirons_flutter/common_widgets/custom_elevated_button.dart';
import 'package:kashirons_flutter/feature/send_flower_&_card_part/widget/delivery_card_widge.dart';
import 'package:kashirons_flutter/feature/send_flower_&_card_part/widget/grating_card_widget.dart';
import 'package:kashirons_flutter/feature/send_flower_&_card_part/widget/order_card_widget.dart';
import 'package:kashirons_flutter/feature/send_flower_&_card_part/widget/review_total_card_widget.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';

class ReviewFlowerCardOder extends StatefulWidget {
  const ReviewFlowerCardOder({
    super.key,
    required this.titleName,
    required this.description,
    required this.value,
    required this.sendToName,
    required this.deliveryAddress,
    required this.isVip,
    required this.message,
  });

  final String titleName;
  final String message;
  final String sendToName;
  final String description;
  final String deliveryAddress;
  final dynamic value;
  final bool isVip;

  @override
  State<ReviewFlowerCardOder> createState() => _ReviewFlowerCardOderState();
}

class _ReviewFlowerCardOderState extends State<ReviewFlowerCardOder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryBg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(title: "Review Order"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                children: [
                  GreetingCard(
                    message: widget.message,
                  ),
                  UIHelper.verticalSpace(16),
                  DeliveryAddressCard(
                    sendToName: widget.sendToName,
                    deliveryAddress: widget.deliveryAddress,
                    isVip: widget.isVip,
                  ),
                  UIHelper.verticalSpace(16),
                  OrderItemsCard(
                    titleName: widget.titleName,
                    description: widget.description,
                    value: widget.value,
                  ),
                  UIHelper.verticalSpace(16),
                  ReviewTotalCardWidget(flowerCardAmount: "\$70",totalAmount:  "\$70",),
                  UIHelper.verticalSpace(16),
                  CustomElevatedButton(
                    text: "Proceed to Payment - \$70",
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


