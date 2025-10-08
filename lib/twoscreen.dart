// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
// import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
// import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
// import 'package:kashirons_flutter/common_widgets/custom_text_field.dart';
// import 'package:kashirons_flutter/feature/add_vip_profile_part/add_vip_profile_part/widget/button_widget.dart';
// import 'package:kashirons_flutter/helpers/ui_helpers.dart';
//
// class Screen extends StatefulWidget {
//   const Screen({super.key});
//
//   @override
//   State<Screen> createState() => _ScreenState();
// }
//
// class _ScreenState extends State<Screen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.c272A36,
//       body: SingleChildScrollView(
//         padding: EdgeInsets.symmetric(horizontal: 24,vertical: 50),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(16),
//               decoration: ShapeDecoration(
//                 color: const Color(0xFF2D3142),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Select Interests',
//                       style: TextFontStyle.textStyle10InterW400.copyWith(
//                         color: const Color(0xFFEDEDED),
//                         fontSize: 18,
//                         fontFamily: 'Inter',
//                         fontWeight: FontWeight.w500,
//                         height: 1.50,
//                       ),
//                     ),
//                     Text(
//                       '0 selected',
//                       style: TextFontStyle.textStyle10InterW400.copyWith(
//                         color: const Color(0xFF787A83),
//                         fontSize: 12,
//                         fontFamily: 'Inter',
//                         fontWeight: FontWeight.w400,
//                         height: 1.50,
//                       ),
//                     )
//                   ],
//                 ),
//                 UIHelper.verticalSpace(16.h),
//
//                 CustomTextField(
//                     contentPadding: EdgeInsets.symmetric(
//                         vertical: 8.h, horizontal: 16.w),
//                     hintText: 'Search interests...',
//                     hintTextSyle:  TextFontStyle.textStyle14InterW400c787A83,
//
//                     leftIcon: AppIcons.searchicon
//
//                 ),
//                 UIHelper.verticalSpace(16.h),
//                 Text(
//                   'Show All',
//                   style: TextStyle(
//                     color: const Color(0xFFEF233C),
//                     fontSize: 14,
//                     fontFamily: 'Inter',
//                     fontWeight: FontWeight.w400,
//                     height: 1.50,
//                   ),
//                 ),
//                 UIHelper.verticalSpace(16.h),
//
//                 Text(
//                     'Lifestyle & Creative',
//                     style:  TextFontStyle.textStyle12InterW400.copyWith(
//                         fontSize: 16.sp,fontWeight: FontWeight.w500
//                     )
//                 ),
//                 UIHelper.verticalSpace(8.h),
//
//                 Row(
//                   children: [
//                     ButtonWidget(title: 'Fashion/Style'),
//                     UIHelper
//                         .horizontalSpace(10.w),
//                     ButtonWidget(title: 'Health & Beauty'),
//                   ],
//                 ),
//                 UIHelper.verticalSpace(10.h),
//
//                 Row(
//                   children: [
//                     ButtonWidget(title: 'Home & Decor'),
//                     UIHelper
//                         .horizontalSpace(10.w),
//                     ButtonWidget(title: 'Wellness'),
//                   ],
//                 ),
//                 UIHelper.verticalSpace(10.h),
//
//                 Row(
//                   children: [
//                     ButtonWidget(title: 'Spa'),
//                     UIHelper
//                         .horizontalSpace(10.w),
//                     ButtonWidget(title: 'Social Media'),
//                   ],
//                 ),
//                 UIHelper.verticalSpace(16.h),
//
//                 Text(
//                     'Hobbies & Creative',
//                     style:  TextFontStyle.textStyle12InterW400.copyWith(
//                         fontSize: 16.sp,fontWeight: FontWeight.w500
//                     )
//                 ),
//                 UIHelper.verticalSpace(8.h),
//                 Row(
//                   children: [
//                     ButtonWidget(title: 'Art'),
//                     UIHelper  .horizontalSpace(10.w),
//                     ButtonWidget(title: 'DIY'),
//                     UIHelper  .horizontalSpace(10.w),
//                     ButtonWidget(title: 'Photography'),
//                   ],
//                 ),
//                 UIHelper.verticalSpace(10.h),
//
//                 Row(
//                   children: [
//                     ButtonWidget(title: 'Music'),
//                     UIHelper  .horizontalSpace(10.w),
//                     ButtonWidget(title: 'Dance'),
//                     UIHelper  .horizontalSpace(10.w),
//                     ButtonWidget(title: 'Film/TV'),
//                   ],
//                 ),
//                 UIHelper.verticalSpace(10.h),
//                 Row(
//                   children: [
//                     ButtonWidget(title: 'Reading'),
//                     UIHelper  .horizontalSpace(10.w),
//                     ButtonWidget(title: 'Writing'),
//
//                   ],
//                 ),
//                 UIHelper.verticalSpace(16.h),
//                 Text(
//                     'Activities & Outdoors',
//                     style:  TextFontStyle.textStyle12InterW400.copyWith(
//                         fontSize: 16.sp,fontWeight: FontWeight.w500
//                     )
//                 ),
//                 UIHelper.verticalSpace(8.h),
//                 Row(
//                   children: [
//                     ButtonWidget(title: 'Travel'),
//                     UIHelper  .horizontalSpace(10.w),
//                     ButtonWidget(title: 'Beach'),
//                     UIHelper  .horizontalSpace(10.w),
//                     ButtonWidget(title: 'Camping'),
//
//                   ],
//                 ),
//                 UIHelper.verticalSpace(10.h),
//                 Row(
//                   children: [
//                     ButtonWidget(title: 'Adventure'),
//                     UIHelper  .horizontalSpace(10.w),
//                     ButtonWidget(title: 'Gardening'),
//
//
//                   ],
//                 ),
//                 UIHelper.verticalSpace(16.h),
//
//                 Text(
//                     'Food & Drink',
//                     style:  TextFontStyle.textStyle12InterW400.copyWith(
//                         fontSize: 16.sp,fontWeight: FontWeight.w500
//                     )
//                 ),
//                 UIHelper.verticalSpace(8.h),
//                 Row(
//                   children: [
//                     ButtonWidget(title: 'Cooking'),
//                     UIHelper  .horizontalSpace(10.w),
//                     ButtonWidget(title: 'Coffee/Tea'),
//
//
//                   ],
//                 ),
//                 UIHelper.verticalSpace(10.h),
//                 Row(
//                   children: [
//                     ButtonWidget(title: 'Foodie'),
//                     UIHelper  .horizontalSpace(10.w),
//                     ButtonWidget(title: 'Wine/Cocktails'),
//
//
//                   ],
//                 ),
//                 UIHelper.verticalSpace(10.h),
//                 ButtonWidget(title: 'BBQ/Grilling'),
//
//                 UIHelper.verticalSpace(16.h),
//
//                 Text(
//                     'Fitness & Sports',
//                     style:  TextFontStyle.textStyle12InterW400.copyWith(
//                         fontSize: 16.sp,fontWeight: FontWeight.w500
//                     )
//                 ),
//                 UIHelper.verticalSpace(8.h),
//
//                 Row(
//                   children: [
//                     ButtonWidget(title: 'Fitness'),
//                     UIHelper  .horizontalSpace(10.w),
//                     ButtonWidget(title: 'Running'),
//                     UIHelper  .horizontalSpace(10.w),
//                     ButtonWidget(title: 'Cycling'),
//                   ],
//                 ),
//                 UIHelper.verticalSpace(10.h),
//
//                 Row(
//                   children: [
//                     ButtonWidget(title: 'Swimming'),
//                     UIHelper  .horizontalSpace(10.w),
//                     ButtonWidget(title: 'Yoga'),
//                     UIHelper  .horizontalSpace(10.w),
//                     ButtonWidget(title: 'Tennis'),
//                   ],
//                 ),
//                 UIHelper.verticalSpace(10.h),
//
//                 Row(
//                   children: [
//                     ButtonWidget(title: 'Pickleball'),
//                     UIHelper  .horizontalSpace(10.w),
//                     ButtonWidget(title: 'Football'),
//                     UIHelper  .horizontalSpace(10.w),
//                     ButtonWidget(title: 'Golf'),
//                   ],
//                 ),
//
//                 UIHelper.verticalSpace(10.h),
//                 Row(
//                   children: [
//                     ButtonWidget(title: 'Baseball'),
//                     UIHelper  .horizontalSpace(10.w),
//                     ButtonWidget(title: 'Soccer'),
//                   ],
//                 ),
//                 UIHelper.verticalSpace(16.h),
//                 Text(
//                     'Pets',
//                     style:  TextFontStyle.textStyle12InterW400.copyWith(
//                         fontSize: 16.sp,fontWeight: FontWeight.w500
//                     )
//                 ),
//                 UIHelper.verticalSpace(8.h),
//
//                 Row(
//                   children: [
//                     ButtonWidget(title: 'Dogs'),
//                     UIHelper  .horizontalSpace(10.w),
//                     ButtonWidget(title: 'Cats'),
//                     UIHelper  .horizontalSpace(10.w),
//                     ButtonWidget(title: 'Birds'),
//                   ],
//                 ),
//
//                 UIHelper.verticalSpace(10.h),
//                 Row(
//                   children: [
//                     ButtonWidget(title: 'Fish'),
//                     UIHelper  .horizontalSpace(10.w),
//                     ButtonWidget(title: 'Reptiles'),
//                     UIHelper  .horizontalSpace(10.w),
//                     ButtonWidget(title: 'Small Pets'),
//                   ],
//                 ),
//                 UIHelper.verticalSpace(16.h),
//
//                 Text(
//                     'Entertainment & Social',
//                     style:  TextFontStyle.textStyle12InterW400.copyWith(
//                         fontSize: 16.sp,fontWeight: FontWeight.w500
//                     )
//                 ),
//                 UIHelper.verticalSpace(10.h),
//                 Row(
//                   children: [
//                     ButtonWidget(title: 'Partying'),
//                     UIHelper  .horizontalSpace(10.w),
//                     ButtonWidget(title: 'Podcasts'),
//
//                   ],
//                 ),
//
//
//
//
//               ],
//             ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
