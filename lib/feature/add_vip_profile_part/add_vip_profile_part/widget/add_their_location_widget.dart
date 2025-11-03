import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/common_widgets/custom_text_field.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';

class AddTheirLocationWidget extends StatelessWidget {
  final bool isOn;
  final ValueChanged<bool> onSwitchChanged;
  final TextEditingController streemController;
  final TextEditingController countryController;
  final TextEditingController cityController;
  final TextEditingController zipcodeController;
  final TextEditingController phoneController;

  const AddTheirLocationWidget({
    Key? key,
    required this.isOn,
    required this.onSwitchChanged,
    required this.streemController,
    required this.countryController,
    required this.cityController,
    required this.zipcodeController,
    required this.phoneController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.sp),
      decoration: ShapeDecoration(
        color: const Color(0xFF2D3142),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add their Location Address',
                style: TextFontStyle.textStyle10InterW400.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              CupertinoSwitch(
                inactiveThumbColor: AppColor.c772738,
                value: isOn,
                activeColor: AppColor.cB5273E,
                trackColor: AppColor.c272A36,
                onChanged: onSwitchChanged,
              ),
            ],
          ),
          UIHelper.verticalSpace(6.h),
          Text(
            'In case you’d like to send a gift or\nsurprise, you can optionally add the\nVIP’s location address now.',
            style: TextFontStyle.textStyle14InterW400c787A83.copyWith(
              color: const Color(0xFF919EAB),
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              height: 1.50,
            ),
          ),

          // ======================= FORM FIELDS =======================
          if (isOn) ...[
            UIHelper.verticalSpace(16.h),
            Text(
              'Street Address',
              style: TextFontStyle.textStyle14InterW400c787A83.copyWith(
                color: const Color(0xFFEDEDED),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.50,
              ),
            ),
            UIHelper.verticalSpace(6.h),
            CustomTextField(
              controller: streemController,
              contentPadding:
              EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
            ),
            UIHelper.verticalSpace(12.h),
            Text(
              'Country',
              style: TextFontStyle.textStyle14InterW400c787A83.copyWith(
                color: const Color(0xFFEDEDED),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.50,
              ),
            ),
            UIHelper.verticalSpace(6.h),
            CustomTextField(
              controller: countryController,
              contentPadding:
              EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
            ),
            UIHelper.verticalSpace(12.h),
            Text(
              'City',
              style: TextFontStyle.textStyle14InterW400c787A83.copyWith(
                color: const Color(0xFFEDEDED),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.50,
              ),
            ),
            UIHelper.verticalSpace(6.h),
            CustomTextField(
              controller: cityController,
              contentPadding:
              EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
            ),
            UIHelper.verticalSpace(12.h),
            Text(
              'ZIP Code',
              style: TextFontStyle.textStyle14InterW400c787A83.copyWith(
                color: const Color(0xFFEDEDED),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.50,
              ),
            ),
            UIHelper.verticalSpace(6.h),
            CustomTextField(
              controller: zipcodeController,
              contentPadding:
              EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
            ),
            UIHelper.verticalSpace(12.h),
            Text(
              'Phone Number',
              style: TextFontStyle.textStyle14InterW400c787A83.copyWith(
                color: const Color(0xFFEDEDED),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.50,
              ),
            ),
            UIHelper.verticalSpace(6.h),
            CustomTextField(
              controller: phoneController,
              contentPadding:
              EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
            ),
          ],
          // ===========================================================
        ],
      ),
    );
  }
}