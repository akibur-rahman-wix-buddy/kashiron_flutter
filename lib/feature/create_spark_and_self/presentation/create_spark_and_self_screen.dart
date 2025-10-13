import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import 'package:kashirons_flutter/common_widgets/custom_app_bar.dart';
import 'package:kashirons_flutter/common_widgets/custom_text_field.dart';
import 'package:kashirons_flutter/feature/create_spark_and_self/widget/vip_dropdown_list.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';
import 'package:kashirons_flutter/common_widgets/custom_elevated_button.dart';

class CreateSparkAndSelfScreen extends StatefulWidget {
  const CreateSparkAndSelfScreen({Key? key}) : super(key: key);

  @override
  State<CreateSparkAndSelfScreen> createState() =>
      _CreateSparkAndSelfScreenState();
}

class _CreateSparkAndSelfScreenState extends State<CreateSparkAndSelfScreen> {
  TextEditingController sparkTitleTextController = TextEditingController();
  TextEditingController sparkDescriptionController = TextEditingController();
  TextEditingController sparkTitleController = TextEditingController();
  TextEditingController vipProfileController = TextEditingController();
  String? _selectedOption;
  final GlobalKey _textFieldKey = GlobalKey();

  TextEditingController dateController = TextEditingController();
  DateTime? selectedDate;

  TextEditingController timeController = TextEditingController();
  TimeOfDay? selectedTime;

  ///>>>>>>>>>>>>>>>>>>> here is the time picker >>>>>>>>>>>>>>>>>>>>>>
  Future<void> _selectTime() async {
    print("⏰ Time picker tapped!");

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColor.c2D3142,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColor.c2D3142,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedTime = picked;
        timeController.text =
            "${picked.hourOfPeriod}:${picked.minute.toString().padLeft(2, '0')} ${picked.period.name.toUpperCase()}";
      });
    }
  }

  ///>>>>>>>>>>>>>>>>>>> here is the date picker >>>>>>>>>>>>>>>>>>>>>>
  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColor.c2D3142, // Change primary color
              onPrimary: Colors.white, // Text color on primary
              onSurface: Colors.black, // Text color on surface
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColor.c2D3142, // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        // Format the date as mm/dd/yyyy
        dateController.text =
            "${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryBg,
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: Container(
        padding: EdgeInsets.all(16.w),
        margin: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          color: const Color(0xFF141824),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UIHelper.verticalSpace(16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomElevatedButton(
                  padding: EdgeInsets.all(0),
                  backgroundColor: Color(0xFF373B4C),
                  width: 140.w,
                  text: "Cancel",
                  onPressed: () {},
                ),
                CustomElevatedButton(
                  padding: EdgeInsets.all(0),
                  width: 140.w,
                  text: "Save",
                  onPressed: () {
                    log(">>>>>>>>>>>>>>>>>>>> VIP Profile: ${vipProfileController.text}");
                    log(">>>>>>>>>>>>>>>>>>>> Spark Title: ${sparkTitleController.text}");
                    log(">>>>>>>>>>>>>>>>>>>> Description: ${sparkDescriptionController.text}");
                    log(">>>>>>>>>>>>>>>>>>>> Date: ${dateController.text}");
                    log(">>>>>>>>>>>>>>>>>>>> Time: ${timeController.text}");
                    log(">>>>>>>>>>>>>>>>>>>> Gift Suggestion Needed: ${_selectedOption ?? 'Not selected'}");
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: "Create Spark",
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(8.w),
                        padding: EdgeInsets.all(16.w),
                        decoration: ShapeDecoration(
                          color: const Color(0xFF2D3142),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  color: Colors.grey,
                                ),
                                UIHelper.horizontalSpace(08),
                                SizedBox(
                                  width: 270.w,
                                  child: Text(
                                    "Set a Spark to remember important tasks and special moments with your VIPs.",
                                    style: TextFontStyle.textStyle14InterW400
                                        .copyWith(color: Color(0xFF787A83)),
                                  ),
                                ),
                              ],
                            ),
                            UIHelper.verticalSpace(16.h),
                            Text(
                              "Select VIP profile",
                              style: TextFontStyle.textStyle16InterW700,
                            ),
                            UIHelper.verticalSpace(16.h),
                            // VIP Dropdown Field
                            ValueListenableBuilder<TextEditingValue>(
                              valueListenable: vipProfileController,
                              builder: (context, value, child) {
                                return CustomTextField(
                                  key: _textFieldKey,
                                  hintText: vipProfileController.text.isEmpty
                                      ? "Choose a VIP"
                                      : vipProfileController.text,
                                  hintTextSyle: TextFontStyle.textStyle12InterW400.copyWith(
                                    fontSize: 14,
                                    color: Colors.white60,
                                  ),
                                  rightIcon: AppIcons.downArrow,
                                  onRightTap: () {
                                    VipDropdown.show(
                                      context: context,
                                      controller: vipProfileController,
                                      textFieldKey: _textFieldKey,
                                      onVipSelected: () {
                                        print('VIP selected: ${vipProfileController.text}');
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                            UIHelper.verticalSpace(16.h),
                            Text(
                              "Spark Title",
                              style: TextFontStyle.textStyle16InterW700,
                            ),
                            UIHelper.verticalSpace(16.h),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xff373b4c),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              padding: EdgeInsets.all(16.w),
                              child: CustomTextField(
                                borderColor: Colors.transparent,
                                height: 120.h,
                                hintText:
                                "Write any extra details, instructions, or context for this sparks…",
                                controller: sparkTitleController,
                                maxLength: 500,
                              ),
                            ),
                            UIHelper.verticalSpace(16.h),
                            Text(
                              "Gift Suggestion Needed?",
                              style: TextFontStyle.textStyle16InterW700,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Radio(
                                  activeColor: Colors.white,
                                  fillColor: MaterialStateProperty.resolveWith<Color>(
                                        (states) {
                                      if (states.contains(MaterialState.selected)) {
                                        return Colors.white; // Active color
                                      }
                                      return Colors.grey; // Inactive color
                                    },
                                  ),
                                  value: 'yes',
                                  groupValue: _selectedOption,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedOption = value;
                                    });
                                  },
                                ),
                                Text(
                                  'Yes',
                                  style: TextStyle(color: Colors.white, fontSize: 18),
                                ),
                                Radio(
                                  activeColor: Colors.white,
                                  fillColor: MaterialStateProperty.resolveWith<Color>(
                                        (states) {
                                      if (states.contains(MaterialState.selected)) {
                                        return Colors.white; // Active color
                                      }
                                      return Colors.grey; // Inactive color
                                    },
                                  ),
                                  value: 'no',
                                  groupValue: _selectedOption,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedOption = value;
                                    });
                                  },
                                ),
                                Text(
                                  'No',
                                  style: TextStyle(color: Colors.white, fontSize: 18),
                                ),
                              ],
                            ),
                            Text(
                              "If Yes, we'll connect this spark with gift suggestions later.",
                              style: TextFontStyle.textStyle14InterW400
                                  .copyWith(color: Colors.white60),
                            ),
                            UIHelper.verticalSpace(16.h),
                            Text(
                              "Date",
                              style: TextFontStyle.textStyle16InterW700,
                            ),
                            UIHelper.verticalSpace(16.h),
                            InkWell(
                              onTap: _selectDate,
                              child: AbsorbPointer(
                                child: CustomTextField(
                                  hintText: selectedDate != null
                                      ? "${selectedDate!.month.toString().padLeft(2, '0')}/${selectedDate!.day.toString().padLeft(2, '0')}/${selectedDate!.year}"
                                      : "mm/dd/yyyy",
                                  rightIcon: AppIcons.calendar,
                                  readOnly: true,
                                  controller: dateController,
                                ),
                              ),
                            ),
                            UIHelper.verticalSpace(16.h),
                            Text(
                              "Time",
                              style: TextFontStyle.textStyle16InterW700,
                            ),
                            UIHelper.verticalSpace(16.h),
                            InkWell(
                              onTap: _selectTime,
                              child: AbsorbPointer(
                                child: CustomTextField(
                                  hintText: selectedTime != null
                                      ? "${selectedTime!.hourOfPeriod}:${selectedTime!.minute.toString().padLeft(2, '0')} ${selectedTime!.period.name.toUpperCase()}"
                                      : "hh:mm aa",
                                  rightIcon: AppIcons.clock,
                                  readOnly: true,
                                  controller: timeController,
                                ),
                              ),
                            ),
                            UIHelper.verticalSpace(16.h),
                            Text(
                              "Description",
                              style: TextFontStyle.textStyle16InterW700,
                            ),
                            UIHelper.verticalSpace(16.h),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xff373b4c),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              padding: EdgeInsets.all(16.w),
                              child: CustomTextField(
                                borderColor: Colors.transparent,
                                height: 120.h,
                                hintText: "What would you like to remember?",
                                controller: sparkDescriptionController,
                                maxLength: 500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      UIHelper.verticalSpace(100.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
