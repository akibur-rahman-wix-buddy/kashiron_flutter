// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
// import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
// import 'package:kashirons_flutter/common_widgets/custom_app_bar.dart';
// import 'package:kashirons_flutter/common_widgets/custom_elevated_button.dart';
// import 'package:kashirons_flutter/feature/send_flower_&_card_part/widget/add_address_dialouge_box.dart';
// import 'package:kashirons_flutter/feature/send_flower_&_card_part/widget/choose_delivery_address_card.dart';
// import 'package:kashirons_flutter/feature/send_flower_&_card_part/widget/choose_flower_card.dart';
// import 'package:kashirons_flutter/helpers/ui_helpers.dart';
//
// class ChooseSendFlowerCard extends StatefulWidget {
//   const ChooseSendFlowerCard({super.key});
//
//   @override
//   State<ChooseSendFlowerCard> createState() => _ChooseSendFlowerCardState();
// }
//
// class _ChooseSendFlowerCardState extends State<ChooseSendFlowerCard> {
//   int? selectedIndex; // Tracks which card is selected
//
//   // Sample address data
//   final List<Map<String, dynamic>> addresses = [
//     {
//       'titleName': 'Sarah Mitchell',
//       'address': '123 Oak Street, San Francisco, CA 94102',
//       'isVip': true,
//     },
//     {
//       'titleName': 'Me',
//       'address': '456 Pine Avenue, Los Angeles, CA 0210',
//       'isVip': false,
//     },
//   ];
//
//   void _selectAddress(int index) {
//     setState(() {
//       selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.primaryBg,
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const CustomAppBar(
//               title: "Send Flowers & Card",
//             ),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Choose the perfect flower for your VIP.",
//                       style: TextFontStyle.textStyle16InterW700.copyWith(
//                         color: Colors.white,
//                       ),
//                     ),
//                     UIHelper.verticalSpace(16.h),
//
//                     // Address cards
//                     ListView.separated(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemCount: addresses.length,
//                       separatorBuilder: (context, index) => UIHelper.verticalSpace(12.h),
//                       itemBuilder: (context, index) {
//                         final address = addresses[index];
//                         return ChooseFlowerCard(
//                           titleName: address['titleName'],
//                           address: address['address'],
//                           isVip: address['isVip'],
//                           isSelected: selectedIndex == index,
//                           onTap: () => _selectAddress(index),
//                         );
//                       },
//                     ),
//
//                     // Add New Address Button
//                     UIHelper.verticalSpace(24.h),
//                     Spacer(),
//                     CustomElevatedButton(text: "Continue", onPressed: (){})
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
// }
//
//
//
//
//



import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/common_widgets/custom_app_bar.dart';
import 'package:kashirons_flutter/common_widgets/custom_elevated_button.dart';
import 'package:kashirons_flutter/feature/send_flower_&_card_part/presentation/flower_review_order.dart';
import 'package:kashirons_flutter/feature/send_flower_&_card_part/widget/choose_flower_card.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';

class ChooseSendFlowerCard extends StatefulWidget {
  const ChooseSendFlowerCard({super.key});

  @override
  State<ChooseSendFlowerCard> createState() => _ChooseSendFlowerCardState();
}

class _ChooseSendFlowerCardState extends State<ChooseSendFlowerCard> {
  /// Multiple selected indexes
  List<int> selectedIndexes = [];

  /// Sample address data
  final List<Map<String, dynamic>> addresses = [
    {
      'titleName': 'Sarah Mitchell',
      'address': '123 Oak Street, San Francisco, CA 94102',
      "value":70,
      'isVip': true,
    },
    {
      'titleName': 'Me',
      'address': '456 Pine Avenue, Los Angeles, CA 0210',
      'isVip': false,
      "value":75,
    },
    {
      'titleName': 'John Wick',
      "value":100,
      'address': '789 Maple Road, New York, NY 10001',
      'isVip': true,
    },
  ];

  void _toggleAddress(int index) {
    setState(() {
      if (selectedIndexes.contains(index)) {
        selectedIndexes.remove(index);
      } else {
        selectedIndexes.add(index);
      }
    });
  }

  void _onContinue() {
    final selectedNames = selectedIndexes
        .map((i) => addresses[i]['titleName'] as String)
        .toList();
final selectedValue = selectedIndexes.map((item)=> addresses[item]["value"]).toList();
    final totalValue = selectedValue.fold<num>(0, (sum, item) => sum + item);


    Get.to(ReviewFlowerCardOder(
      message: 'Congratulations! You deserve all the beautiful things in life.',
      isVip: true,
      deliveryAddress: "dhaka bangladesh ",
      value: 112,
      sendToName: "Sarah Mitchell",
      description: "this is description",
      titleName: " this is title",
    ));
    // Or you can print
    debugPrint("Selected Names: $selectedNames");
    debugPrint("Selected value : $selectedValue");
    debugPrint("Selected total value : $totalValue");
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
                    "Choose the perfect flower for your VIP.",
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
                    separatorBuilder: (context, index) =>
                        UIHelper.verticalSpace(12.h),
                    itemBuilder: (context, index) {
                      final address = addresses[index];
                      return ChooseFlowerCard(
                        value: address["value"],
                        titleName: address['titleName'],
                        address: address['address'],
                        isVip: address['isVip'],
                        isSelected: selectedIndexes.contains(index),
                        onTap: () => _toggleAddress(index),
                      );
                    },
                  ),

                  const Spacer(),

                  // Continue Button
                  CustomElevatedButton(
                    text: "Continue",
                    onPressed: _onContinue,
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
