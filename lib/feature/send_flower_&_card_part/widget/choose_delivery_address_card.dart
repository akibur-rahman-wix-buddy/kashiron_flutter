import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';

class ChooseDeliveryAddressCard extends StatelessWidget {
  const ChooseDeliveryAddressCard({
    super.key,
    required this.titleName,
    required this.address,
    required this.isVip,
    required this.isSelected,
    required this.onTap,
  });

  final String titleName;
  final String address;
  final bool isVip;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: ShapeDecoration(
          color: const Color(0xFF2D3142),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: isSelected ? 2.w : 1.w,
              color: isSelected ?  const Color(0xFFEDEDED):Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Location icon and content
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFA4161A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        AppIcons.location,
                        height: 25.h,
                        width: 25.w,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name and VIP badge
                        Row(
                          children: [
                            Text(
                              'Send to $titleName',
                              style: TextFontStyle.textStyle16InterW700.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            if (isVip) ...[
                              SizedBox(width: 8.w),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 5.h,
                                ),
                                decoration: ShapeDecoration(
                                  color: const Color(0x1E1994E0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                ),
                                child: Text(
                                  'VIP',
                                  style: TextFontStyle.textStyle10InterW400.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.lightBlueAccent,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        SizedBox(height: 8.h),
                        // Address
                        Text(
                          address,
                          style: TextFontStyle.textStyle12InterW400.copyWith(
                            color: Colors.white70,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Selection indicator
            Container(
              width: 20.w,
              height: 20.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? const Color(0xFFA4161A) : Colors.transparent,
                border: Border.all(
                  color: isSelected ? const Color(0xFFA4161A) : Colors.transparent,
                  width: 2.w,
                ),
              ),
              child: isSelected
                  ? Icon(
                Icons.check,
                size: 14.w,
                color: Colors.white,
              )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}