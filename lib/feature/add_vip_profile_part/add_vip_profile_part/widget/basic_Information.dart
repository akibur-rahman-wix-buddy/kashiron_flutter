//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
// import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
// import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
// import 'package:kashirons_flutter/common_widgets/custom_text_field.dart';
// import 'package:kashirons_flutter/helpers/ui_helpers.dart';
//
// class BasicInformationSection extends StatefulWidget {
//   final String? selectedRelationship;
//   final GlobalKey relationshipFieldKey;
//   final VoidCallback onTapRelationship;
//
//   const BasicInformationSection({
//     super.key,
//     required this.selectedRelationship,
//     required this.relationshipFieldKey,
//     required this.onTapRelationship,
//   });
//
//   @override
//   State<BasicInformationSection> createState() =>
//       _BasicInformationSectionState();
// }
//
// class _BasicInformationSectionState extends State<BasicInformationSection> {
//   bool isAnniversaryOn = false;
//   TextEditingController anniversaryController = TextEditingController();
//
//   @override
//   void dispose() {
//     anniversaryController.dispose();
//     super.dispose();
//   }
//
//   /// Opens date picker and sets anniversary date
//   void _pickDate() async {
//     DateTime? pickedDate = await showDatePicker(
//
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime(2100),
//     );
//
//     if (pickedDate != null) {
//       setState(() {
//
//         anniversaryController.text =
//         '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final isWifeSelected = widget.selectedRelationship == 'Wife';
//
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(16.sp),
//       decoration: ShapeDecoration(
//         color: AppColor.c2D3142,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12.r),
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Section title
//           SizedBox(
//             width: 304.w,
//             child: Text(
//               'Basic Information',
//               style: TextFontStyle.textStyle10InterW400.copyWith(
//                 fontSize: 18.sp,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//           UIHelper.verticalSpace(16.h),
//
//           // Full name field
//           Text(
//             'Full name',
//             style: TextFontStyle.textStyle10InterW400.copyWith(
//               fontSize: 16.sp,
//               fontWeight: FontWeight.w400,
//             ),
//           ),
//           UIHelper.verticalSpace(6.h),
//           CustomTextField(
//             contentPadding:
//             EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
//             hintText: 'Enter full name',
//             hintTextSyle: TextFontStyle.textStyle10InterW400.copyWith(
//               color: const Color(0xFF787A83),
//               fontSize: 14.sp,
//             ),
//             rightIcon: AppIcons.usericon,
//           ),
//           UIHelper.verticalSpace(12.h),
//
//           // Relationship field
//           Text(
//             'Relationship',
//             style: TextFontStyle.textStyle10InterW400.copyWith(
//               fontSize: 16.sp,
//               fontWeight: FontWeight.w400,
//             ),
//           ),
//           UIHelper.verticalSpace(6.h),
//           CustomTextField(
//             key: widget.relationshipFieldKey,
//             readOnly: true,
//             contentPadding:
//             EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
//             hintText: widget.selectedRelationship ?? 'Select relationship',
//             hintTextSyle: TextFontStyle.textStyle10InterW400.copyWith(
//               fontSize: 14.sp,
//               fontWeight: FontWeight.w400,
//             ),
//             height: 48,
//             rightIconWidget: InkWell(
//               onTap: widget.onTapRelationship,
//               child: Transform.scale(
//                 scale: 0.60,
//                 child: SvgPicture.asset(AppIcons.drwopdwonicon),
//               ),
//             ),
//           ),
//
//           // ======================== Wife Section ========================
//           if (isWifeSelected) ...[
//             UIHelper.verticalSpace(12.h),
//
//             // 1️⃣ First TextField → toggle switch
//             CustomTextField(
//               contentPadding:
//               EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
//               hintText: 'Add Anniversary Option',
//               hintTextSyle: TextFontStyle.textStyle10InterW400.copyWith(
//                 color: const Color(0xFF787A83),
//                 fontSize: 14.sp,
//               ),
//               readOnly: true,
//               rightIconWidget: CupertinoSwitch(
//                 inactiveThumbColor: AppColor.c772738,
//                 value: isAnniversaryOn,
//                 activeColor: AppColor.cB5273E,
//                 trackColor: AppColor.c272A36,
//                 onChanged: (val) {
//                   setState(() {
//                     isAnniversaryOn = val;
//                   });
//                 },
//               ),
//             ),
//
//             // 2️⃣ Second TextField → only visible when toggle is ON
//             if (isAnniversaryOn) ...[
//               UIHelper.verticalSpace(12.h),
//               CustomTextField(
//                 controller: anniversaryController,
//                 contentPadding:
//                 EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
//                 hintText: 'day/month/year',
//                 hintTextSyle: TextFontStyle.textStyle10InterW400.copyWith(
//                   color: const Color(0xFF787A83),
//                   fontSize: 14.sp,
//                 ),
//                 readOnly: true,
//                 onTap: _pickDate,
//                 rightIconWidget: InkWell(
//                   onTap: _pickDate,
//                   child: Transform.scale(
//                     scale: 0.45,
//                     child: SvgPicture.asset(
//                       AppIcons.calendar,
//                       height: 20,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ],
//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import 'package:kashirons_flutter/common_widgets/custom_text_field.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';

class BasicInformationSection extends StatefulWidget {
  final String? selectedRelationship;
  final GlobalKey relationshipFieldKey;
  final VoidCallback onTapRelationship;

  const BasicInformationSection({
    super.key,
    required this.selectedRelationship,
    required this.relationshipFieldKey,
    required this.onTapRelationship,
  });

  @override
  State<BasicInformationSection> createState() =>
      _BasicInformationSectionState();
}

class _BasicInformationSectionState extends State<BasicInformationSection> {
  bool isAnniversaryOn = false;
  TextEditingController anniversaryController = TextEditingController();

  @override
  void dispose() {
    anniversaryController.dispose();
    super.dispose();
  }

  /// Opens date picker and sets anniversary date
  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: AppColor.c373B4C,
              onPrimary: Colors.white,
              surface: AppColor.c2D3142,
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: AppColor.c2D3142,
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        anniversaryController.text =
            DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isWifeSelected = widget.selectedRelationship == 'Wife';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.sp),
      decoration: ShapeDecoration(
        color: AppColor.c2D3142,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title
          SizedBox(
            width: 304.w,
            child: Text(
              'Basic Information',
              style: TextFontStyle.textStyle10InterW400.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          UIHelper.verticalSpace(16.h),

          // Full name field
          Text(
            'Full name',
            style: TextFontStyle.textStyle10InterW400.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          UIHelper.verticalSpace(6.h),
          CustomTextField(
            contentPadding:
            EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
            hintText: 'Enter full name',
            hintTextSyle: TextFontStyle.textStyle10InterW400.copyWith(
              color: const Color(0xFF787A83),
              fontSize: 14.sp,
            ),
            rightIcon: AppIcons.usericon,
          ),
          UIHelper.verticalSpace(12.h),

          ///========================= Relationship field =====================///
          Text(
            'Relationship',
            style: TextFontStyle.textStyle10InterW400.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          UIHelper.verticalSpace(6.h),
          CustomTextField(
            key: widget.relationshipFieldKey,
            readOnly: true,
            contentPadding:
            EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
            hintText: widget.selectedRelationship ?? 'Select relationship',
            hintTextSyle: TextFontStyle.textStyle10InterW400.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            height: 48,
            rightIconWidget: InkWell(
              onTap: widget.onTapRelationship,
              child: Transform.scale(
                scale: 0.60,
                child: SvgPicture.asset(AppIcons.drwopdwonicon),
              ),
            ),
          ),

          /// ======================== Wife Section ========================
          if (isWifeSelected) ...[
            UIHelper.verticalSpace(12.h),

            // 1️⃣ First TextField → toggle switch
            CustomTextField(
              contentPadding:
              EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
              hintText: 'Add Anniversary Option',
              hintTextSyle: TextFontStyle.textStyle10InterW400.copyWith(
                color: const Color(0xFF787A83),
                fontSize: 14.sp,
              ),
              readOnly: true,
              rightIconWidget: CupertinoSwitch(
                inactiveThumbColor: AppColor.c772738,
                value: isAnniversaryOn,
                activeColor: AppColor.cB5273E,
                trackColor: AppColor.c272A36,
                onChanged: (val) {
                  setState(() {
                    isAnniversaryOn = val;
                  });
                },
              ),
            ),
            ///========================== Second TextField ======================//
            if (isAnniversaryOn) ...[
              UIHelper.verticalSpace(12.h),
              CustomTextField(
                controller: anniversaryController,
                contentPadding:
                EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                hintText: 'dd/mm/yyyy',
                hintTextSyle: TextFontStyle.textStyle10InterW400.copyWith(
                  color: const Color(0xFF787A83),
                  fontSize: 14.sp,
                ),
                readOnly: true,
                onTap: _pickDate,
                rightIconWidget: InkWell(
                  onTap: _pickDate,
                  child: Transform.scale(
                    scale: 0.45,
                    child: SvgPicture.asset(
                      AppIcons.calendar,
                      height: 20,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
}
