
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/common_widgets/shimmerClipOverImageWidget.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';

class SparkHadingCard extends StatelessWidget {
  const SparkHadingCard({
    super.key, required this.image, required this.name, required this.relation, required this.title, required this.leftTime, required this.leftDate, required this.description,
  });
  final String image;
  final String name;
  final String relation;
  final String title;
  final String leftTime;
  final String leftDate;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.sp),
      width: double.infinity,
      decoration: ShapeDecoration(
        color: AppColor.c2D3142,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            shimmerClipOvalWidget(
              weight: 56.w,
              height: 56.h,
              networkImageLink: image,
            ),
            UIHelper.horizontalSpace(8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,style: TextFontStyle.textStyle16InterW700,),
                UIHelper.verticalSpace(8.h),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: ShapeDecoration(
                    color: AppColor.c353A4E,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    relation,
                    style: TextFontStyle.textStyle10InterW400,
                  ),
                )
              ],
            )

          ],

        ),

        UIHelper.verticalSpace(8.h),

        Text(title,style: TextFontStyle.textStyle18InterW700,),
        UIHelper.verticalSpace(8.h),
        Text(
            '$leftTime - $leftDate',
            style: TextFontStyle.textStyle12InterW600.copyWith(color: AppColor.cF4C91E)
        ),
        UIHelper.verticalSpace(8.h),
        SizedBox(
          width: 330,
          child: Text(
              description,
              style: TextFontStyle.textStyle12InterW400                      ),
        )


      ],
    ),
    );
  }
}