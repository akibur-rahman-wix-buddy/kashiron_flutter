import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import 'package:kashirons_flutter/common_widgets/custom_app_bar.dart';
import 'package:kashirons_flutter/common_widgets/custom_text_field.dart';
import 'package:kashirons_flutter/helpers/all_routes.dart';
import 'package:kashirons_flutter/helpers/navigation_service.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';
import 'package:kashirons_flutter/common_widgets/custom_elevated_button.dart';
import 'package:kashirons_flutter/networks/api_acess.dart';

class SelfCareReminderScreen extends StatefulWidget {
  String? id;
  String? spark_id;

  SelfCareReminderScreen({Key? key, this.id, this.spark_id}) : super(key: key);

  @override
  State<SelfCareReminderScreen> createState() => _SelfCareReminderScreenState();
}

class _SelfCareReminderScreenState extends State<SelfCareReminderScreen> {
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
            "${picked.hourOfPeriod}:${picked.minute.toString().padLeft(2, '0')}";
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
            "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                  onPressed: () {
                    NavigationService.goBack;
                  },
                ),
                CustomElevatedButton(
                  padding: EdgeInsets.all(0),
                  width: 140.w,
                  text: "Save",
                  onPressed: () async {
                    log(">>>>>>>>>>>>>>>>>>>> VIP Profile: ${vipProfileController.text}");
                    log(">>>>>>>>>>>>>>>>>>>> Spark Title: ${sparkTitleController.text}");
                    log(">>>>>>>>>>>>>>>>>>>> Description: ${sparkDescriptionController.text}");
                    log(">>>>>>>>>>>>>>>>>>>> Date: ${dateController.text}");
                    log(">>>>>>>>>>>>>>>>>>>> Time: ${timeController.text}");
                    log(">>>>>>>>>>>>>>>>>>>> Gift Suggestion Needed: ${_selectedOption ?? 'Not selected'}");

                    if (widget.id != null) {
                      bool success = await sparkUpdateApiRx.sparkUpdate(
                          vip_id: widget.id.toString(),
                          title: sparkTitleController.text,
                          description: sparkDescriptionController.text,
                          date: dateController.text,
                          time: timeController.text,
                          spark_id: widget.spark_id.toString());

                      if (success) {
                        NavigationService.navigateTo(
                            Routes.vipSparkDetailsScreen);
                      }
                    } else {
                      bool success = await selfReminderApiRx.selfReminder(
                          title: sparkTitleController.text,
                          description: sparkDescriptionController.text,
                          date: dateController.text,
                          time: timeController.text);
                      if (success) {
                        NavigationService.navigateTo(Routes.customBottomNavBar);
                      }
                    }
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
              title: "Self Care Reminder",
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
                            UIHelper.verticalSpace(16.h),
                            Text(
                              "Reminder Title",
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
                                height: 80.h,
                                hintText:
                                    "Enter reminder title (e.g., Meditation session)",
                                controller: sparkTitleController,
                                maxLength: 30,
                              ),
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
                    ],
                  ),
                ),
              ),
            ),
            UIHelper.verticalSpace(100.h)
          ],
        ),
      ),
    );
  }
}
