import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/common_widgets/custom_elevated_button.dart';
import 'package:kashirons_flutter/common_widgets/custom_shimmer_image.dart';
import 'package:kashirons_flutter/common_widgets/shimmerClipOverImageWidget.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';
import 'package:kashirons_flutter/networks/endpoints.dart';

class UpcommingSparkCard extends StatelessWidget {
  const UpcommingSparkCard({
    super.key,
    required this.titleName,
    required this.relationship,
    required this.image,
    required this.day,
    required this.date,
    required this.description,
    required this.saveOnTap,
    required this.cancelOnTap,
  });

  final String titleName;
  final String relationship;
  final String image;
  final String day;
  final String date;
  final String description;
  final VoidCallback saveOnTap;
  final VoidCallback cancelOnTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: ShapeDecoration(
        color: const Color(0xFF2D3142),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                titleName,
                style: TextFontStyle.textStyle20InterW500,
              ),
              Text(
                day,
                style: TextFontStyle.textStyle12InterW400
                    .copyWith(color: Color(0xFF3AB415)),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerImage(
                      imageUrl: image,
                      placeholder: personImageUrl,
                      height: 15.h,
                      width: 15.w),
                  UIHelper.horizontalSpace(8.w),
                  Text(
                    relationship,
                    style: TextFontStyle.textStyle12InterW400
                        .copyWith(color: Colors.white60),
                  )
                ],
              ),
              Text(
                date,
                style: TextFontStyle.textStyle12InterW400,
              )
            ],
          ),
          UIHelper.verticalSpace(8.h),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              description,
              style: TextFontStyle.textStyle12InterW400,
            ),
          ),
          UIHelper.verticalSpace(16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomElevatedButton(
                padding: EdgeInsets.all(0),
                backgroundColor: Color(0xFF373B4C),
                width: 140.w,
                height: 48.0,
                text: "Cancel",
                onPressed: cancelOnTap,
              ),
              CustomElevatedButton(
                padding: EdgeInsets.all(0),
                width: 140.w,
                text: "Save",
                height: 48.0,
                onPressed: saveOnTap,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
