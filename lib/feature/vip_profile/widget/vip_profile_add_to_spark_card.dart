import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/common_widgets/custom_button.dart';
import 'package:kashirons_flutter/common_widgets/shimmerClipOverImageWidget.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';
import 'package:kashirons_flutter/networks/endpoints.dart';

class vipProfileAddToSparkCard extends StatelessWidget {
  const vipProfileAddToSparkCard({
    super.key, required this.name, required this.type, required this.birthdayDate, required this.sparkNumber, required this.onAddSparkTap, required this.onCardTap, required this.buttonName,
  });
  final String name;
  final String type;
  final String birthdayDate;
  final String sparkNumber;
  final String buttonName;
  final VoidCallback onAddSparkTap;
  final VoidCallback onCardTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCardTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: ShapeDecoration(
          color: const Color(0xFF2D3142),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),child: Column(
        children: [
          Row(
            children: [
              shimmerClipOvalWidget(
                height: 50.h,
                weight: 50.w,
                networkImageLink:personImageUrl ,
              ),
              UIHelper.horizontalSpace(8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,style: TextFontStyle.textStyle20InterW500.copyWith(fontSize: 18),),

                  UIHelper.verticalSpace(8.h),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: ShapeDecoration(
                      color: const Color(0xFF373B4C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                        type,
                        style: TextFontStyle.textStyle10InterW400
                    ),
                  )
                ],
              )
            ],
          ),
          UIHelper.verticalSpace(8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.calendar_month,color: Colors.white,),
                  UIHelper.horizontalSpace(8.w),
                  Text("Birthday: ${birthdayDate}",style: TextFontStyle.textStyle10InterW400,)
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                decoration: ShapeDecoration(
                  color: const Color(0xFF2D3142),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      color: const Color(0xFF373B4C),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 6,
                  children: [
                    Text(
                        sparkNumber,
                        textAlign: TextAlign.center,
                        style: TextFontStyle.textStyle12InterW600.copyWith(color: Color(0xFFEF233C),)
                    ),
                    Text(
                        'spark',
                        style: TextFontStyle.textStyle12InterW600
                    ),
                  ],
                ),
              )
            ],
          ),
          UIHelper.verticalSpace(8.h),
          customButton(name: buttonName,icon:Icon(Icons.add,color: Colors.white,) ,color: Color(0xFF373B4C),height: 44.h, onCallBack: onAddSparkTap, context: context)
        ],
      ),
      ),
    );
  }
}