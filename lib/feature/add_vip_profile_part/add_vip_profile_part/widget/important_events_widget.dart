
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import 'package:kashirons_flutter/common_widgets/custom_text_field.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';

class ImportantEventsWidget extends StatefulWidget {
  final String title;

  const ImportantEventsWidget({
    super.key,
    required this.title,
  });

  @override
  State<ImportantEventsWidget> createState() => _ImportantEventsWidgetState();
}

class _ImportantEventsWidgetState extends State<ImportantEventsWidget> {
  final TextEditingController _dateController = TextEditingController();

  Future<void> _pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme:  ColorScheme.dark(
              primary: AppColor.c373B4C,
              onPrimary: Colors.white,
              surface: AppColor.c2D3142
              ,
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
        _dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
          // Title
          SizedBox(
            width: 304.w,
            child: Text(
              widget.title,
              style: TextFontStyle.textStyle10InterW400.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          UIHelper.verticalSpace(16.h),

          // Birthday date label
          Text(
            'Birthday date',
            style: TextFontStyle.textStyle10InterW400.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          UIHelper.verticalSpace(6.h),

          // Date picker field
          CustomTextField(
            controller: _dateController,
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
                  child: SvgPicture.asset(AppIcons.calendar,height: 20.h,))
            ),
          ),

          UIHelper.verticalSpace(12.h),

          // Notes label
          Text(
            'Special Notes (Optional)',
            style: TextFontStyle.textStyle10InterW400.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          UIHelper.verticalSpace(6.h),

          // Notes field
          CustomTextField(
            maxLines: 7,
            contentPadding:
            EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
            hintText: 'Add any special notes or anything...',
            hintTextSyle: TextFontStyle.textStyle14InterW400c787A83,
          ),
        ],
      ),
    );
  }
}
