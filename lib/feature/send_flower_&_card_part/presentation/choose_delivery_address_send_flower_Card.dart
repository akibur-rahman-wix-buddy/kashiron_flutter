import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import 'package:kashirons_flutter/common_widgets/custom_app_bar.dart';
import 'package:kashirons_flutter/common_widgets/custom_elevated_button.dart';
import 'package:kashirons_flutter/feature/send_flower_&_card_part/widget/add_address_dialouge_box.dart';
import 'package:kashirons_flutter/feature/send_flower_&_card_part/widget/choose_delivery_address_card.dart';
import 'package:kashirons_flutter/helpers/all_routes.dart';
import 'package:kashirons_flutter/helpers/navigation_service.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';

class ChooseDeliveryAddressSendFlowerCard extends StatefulWidget {
  const ChooseDeliveryAddressSendFlowerCard({super.key});

  @override
  State<ChooseDeliveryAddressSendFlowerCard> createState() => _ChooseDeliveryAddressSendFlowerCardState();
}

class _ChooseDeliveryAddressSendFlowerCardState extends State<ChooseDeliveryAddressSendFlowerCard> {
  int? selectedIndex; // Tracks which card is selected

  // Sample address data
  final List<Map<String, dynamic>> addresses = [
    {
      'titleName': 'Sarah Mitchell',
      'address': '123 Oak Street, San Francisco, CA 94102',
      'isVip': true,
    },
    {
      'titleName': 'Me',
      'address': '456 Pine Avenue, Los Angeles, CA 0210',
      'isVip': false,
    },
  ];

  void _selectAddress(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryBg,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomAppBar(
            title: "Send Flowers & Card",
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Choose Delivery Address",
                    style: TextFontStyle.textStyle16InterW700.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  UIHelper.verticalSpace(16.h),

                  // Address cards
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: addresses.length,
                    separatorBuilder: (context, index) => UIHelper.verticalSpace(12.h),
                    itemBuilder: (context, index) {
                      final address = addresses[index];
                      return ChooseDeliveryAddressCard(
                        titleName: address['titleName'],
                        address: address['address'],
                        isVip: address['isVip'],
                        isSelected: selectedIndex == index,
                        onTap: () => _selectAddress(index),
                      );
                    },
                  ),

                  /// Add New Address Button
                 UIHelper.verticalSpace(24.h),
                  _buildAddNewAddressButton(),
                  Spacer(),
                  CustomElevatedButton(text: "Continue", onPressed: (){
                    NavigationService.navigateTo(Routes.chooseSendFlowerCard);
                  })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddNewAddressButton() {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => const AddAddressDialog(),
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: ShapeDecoration(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1.w,
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              color: Colors.white,
              size: 20.w,
            ),
            UIHelper.horizontalSpace(8.w),
            Text(
              'Add New Address',
              style: TextFontStyle.textStyle16InterW700.copyWith(
                 color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}





