
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import 'package:kashirons_flutter/common_widgets/custom_app_bar.dart';
import 'package:kashirons_flutter/common_widgets/custom_button.dart';
import 'package:kashirons_flutter/common_widgets/custom_text_field.dart';
import 'package:kashirons_flutter/common_widgets/shimmerClipOverImageWidget.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';
import 'package:kashirons_flutter/common_widgets/custom_elevated_button.dart';
import 'package:kashirons_flutter/networks/endpoints.dart';

class CreateSparkScreen extends StatefulWidget {
  const CreateSparkScreen({Key? key}) : super(key: key);

  @override
  State<CreateSparkScreen> createState() => _CreateSparkScreenState();
}

class _CreateSparkScreenState extends State<CreateSparkScreen> {

  TextEditingController sparkTitleTextController = TextEditingController();
  TextEditingController sparkDescriptionController = TextEditingController();

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
        timeController.text = "${picked.hourOfPeriod}:${picked.minute.toString().padLeft(2, '0')} ${picked.period.name.toUpperCase()}";
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
        dateController.text = "${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryBg,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
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

                  },
                ),
                CustomElevatedButton(
                  padding: EdgeInsets.all(0),
                  width: 140.w,
                  text: "Save",

                  onPressed: () {

                    log(">>>>>>>>>>>>>>>>>>>> this is title${sparkTitleTextController.text} ");
                    log(">>>>>>>>>>>>>>>>>>>> this is description${sparkDescriptionController.text} ");
                    log(">>>>>>>>>>>>>>>>>>>> this is date${dateController.text} ");
                    log(">>>>>>>>>>>>>>>>>>>> this is time${timeController.text} ");

                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(
                title: "Create Spark",
              ),
              Padding(
                padding: EdgeInsets.all(12.w),
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
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: ShapeDecoration(
                            color: const Color(0xFF373B4C),
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
                                    Text("name",style: TextFontStyle.textStyle20InterW500.copyWith(fontSize: 18),),

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
                                          "brother",
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
                                    Text("Birthday: ${"10 august"}",style: TextFontStyle.textStyle10InterW400,)
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
                                          "10" ,
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
                           ],
                        ),
                        ),
                        UIHelper.verticalSpace(16.h),
                        Text("Spark Title",style: TextFontStyle.textStyle16InterW700,),
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
                            "Enter heads-up or spark name (e.g., Call Mom about doctor’s visit",
                            controller: sparkTitleTextController,
                            maxLength: 30,
                          ),
                        ),

                        UIHelper.verticalSpace(16.h),
                        Text("Date",style: TextFontStyle.textStyle16InterW700,),
                        UIHelper.verticalSpace(16.h),
                        InkWell(
                          onTap: _selectDate,
                          child: AbsorbPointer(
                            child: CustomTextField(
                              hintText: selectedDate != null
                                  ? "${selectedDate!.month.toString().padLeft(2, '0')}/${selectedDate!.day.toString().padLeft(2, '0')}/${selectedDate!.year}"
                                  : "mm/dd/yyyy",
                              rightIcon: AppIcons.calendar,
                              read: true,
                              controller: dateController,
                            ),
                          ),
                        ),
                        UIHelper.verticalSpace(16.h),
                        Text("Time",style: TextFontStyle.textStyle16InterW700,),
                        UIHelper.verticalSpace(16.h),
                        InkWell(
                          onTap: _selectTime,
                          child: AbsorbPointer(
                            child: CustomTextField(
                              hintText: selectedTime != null
                                  ? "${selectedTime!.hourOfPeriod}:${selectedTime!.minute.toString().padLeft(2, '0')} ${selectedTime!.period.name.toUpperCase()}"
                                  : "hh:mm aa",
                              rightIcon: AppIcons.clock, // Make sure you have a clock icon
                              read: true,
                              controller: timeController,
                            ),
                          ),
                        ),
                        UIHelper.verticalSpace(16.h),
                        Text("Sparks Notes / Description",style: TextFontStyle.textStyle16InterW700,),
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
                            controller: sparkDescriptionController,
                            maxLength: 500,
                          ),
                        ),

                      ],
                      ),
                    ),
                    UIHelper.verticalSpace(150.h), // Adjusted for floatingActionButton
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}