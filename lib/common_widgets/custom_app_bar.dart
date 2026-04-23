// // import 'package:flutter/material.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
// // import 'package:kashirons_flutter/helpers/navigation_service.dart';
// // import 'package:kashirons_flutter/helpers/ui_helpers.dart';
// //
// // import '../assets_helperfdg/app_colors.dart';
// //
// // class CustomAppBar extends StatelessWidget {
// //   const CustomAppBar({super.key,  this.title});
// //   final String? title;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return  Container(
// //
// //
// //       width: double.infinity,
// //       decoration: BoxDecoration(
// //         color: AppColor.c2D3142
// //       ),
// //       child: Column(
// //         children: [
// //           UIHelper.verticalSpace(10.h),
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //           children: [
// //             ElevatedButton(
// //               onPressed: () {
// //                 NavigationService.goBack; // <-- make sure it's a method call
// //               },
// //               style: ElevatedButton.styleFrom(
// //                 shape: const CircleBorder(),
// //                 padding: const EdgeInsets.all(12),
// //                 backgroundColor: Colors.transparent, // or AppColor.cEDEDED.withOpacity(0.1)
// //                 elevation: 0, // remove shadow if you want flat style
// //               ),
// //               child: Icon(
// //                 Icons.arrow_back_outlined,
// //                 size: 24,
// //                 color: AppColor.cEDEDED,
// //               ),
// //             ),
// //
// //
// //             Text(title ??"",style: TextFontStyle.textStyle8InterW700,),
// //             SizedBox(
// //               width: 50,
// //             )
// //           ],
// //           ),
// //           UIHelper.verticalSpace(8.h)
// //         ],
// //       ),
// //     );
// //   }
// // }
//
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
// import 'package:kashirons_flutter/helpers/navigation_service.dart';
// import 'package:kashirons_flutter/helpers/ui_helpers.dart';
//
// import '../assets_helperfdg/app_colors.dart';
//
// class CustomAppBar extends StatelessWidget {
//   const CustomAppBar({
//     super.key,
//     this.title,
//     this.actionButton,
//     this.prefixIcon, // Custom prefix icon widget
//     this.enableBack = true, // Control back functionality
//   });
//
//   final String? title;
//   final Widget? actionButton;
//   final Widget? prefixIcon; // Custom prefix icon widget
//   final bool enableBack; // Whether back button should work
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//           color: AppColor.c2D3142
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           UIHelper.verticalSpace(10.h),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               // Prefix icon or back button
//               _buildPrefixWidget(context),
//
//               // Title
//               Text(title ?? "", style: TextFontStyle.textStyle8InterW700),
//
//               // Action button or empty space
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: actionButton ?? SizedBox(width: 50.w),
//               ),
//             ],
//           ),
//           UIHelper.verticalSpace(8.h),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildPrefixWidget(BuildContext context) {
//     // If custom prefix icon is provided, use it
//     if (prefixIcon != null) {
//       return Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: prefixIcon!,
//         ),
//       );
//     }
//
//     // Otherwise, show back button with optional functionality
//     return ElevatedButton(
//       onPressed: enableBack ? () {
//         NavigationService.goBack;
//       } : null, // If enableBack is false, button will be disabled
//       style: ElevatedButton.styleFrom(
//         shape: const CircleBorder(),
//         padding: const EdgeInsets.all(12),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       child: Icon(
//         Icons.arrow_back_outlined,
//         size: 24,
//         color: enableBack ? AppColor.cEDEDED : AppColor.cEDEDED.withOpacity(0.5),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/helpers/navigation_service.dart';

import '../assets_helperfdg/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.actionButton,
    this.prefixIcon,
    this.enableBack = true,
    this.backgroundColor = const Color(0xFF2C2F3C),
    this.elevation = 0,
  });

  final String? title;
  final Widget? actionButton;
  final Widget? prefixIcon;
  final bool enableBack;
  final Color backgroundColor;
  final double elevation;

  @override
  Size get preferredSize => Size.fromHeight(60.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: elevation,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Prefix icon or back button
          _buildPrefixWidget(context),

          // Title
          Expanded(
            child: Center(
              child: Text(
                title ?? "",
                style: TextFontStyle.textStyle8InterW700,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),

          // Action button or empty space
          actionButton ?? SizedBox(width: 50.w),
        ],
      ),
    );
  }

  Widget _buildPrefixWidget(BuildContext context) {
    if (prefixIcon != null) {
      return prefixIcon!;
    }

    return IconButton(
      icon: Icon(
        Icons.arrow_back_outlined,
        size: 24,
        color:
            enableBack ? AppColor.cEDEDED : AppColor.cEDEDED.withOpacity(0.5),
      ),
      onPressed: enableBack
          ? () {
              NavigationService.goBack;
              // Or use: Navigator.pop(context);
            }
          : null,
    );
  }
}
