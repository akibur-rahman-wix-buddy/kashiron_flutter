import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_image.dart';
import 'package:kashirons_flutter/common_widgets/custom_container.dart';
import 'package:kashirons_flutter/common_widgets/custom_elevated_button.dart';
import 'package:kashirons_flutter/common_widgets/custom_shimmer_image.dart';
import 'package:kashirons_flutter/common_widgets/custom_text_field.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';
import 'package:kashirons_flutter/networks/api_acess.dart';
import '../../../assets_helperfdg/app_fonts.dart';

Future<bool?> setReminderBottomSheet(
  BuildContext context, {
  required String title,
  required String image,
  required bool isEdit,
  required String date,
  required String time,
  String? reminderTime,
  String? reminderDate,
  required String id,
}) {
  return showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: const Color(0xff2d3142),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (context) {
      return _ReminderBottomSheetContent(
        isEdit: isEdit,
        id: id,
        reminderTime: reminderTime,
        reminderDate: reminderDate,
        title: title,
        image: image,
        date: date,
        time: time,
      );
    },
  );
}

class _ReminderBottomSheetContent extends StatefulWidget {
  final String title;
  final String image;
  final String date;
  final String time;
  final String id;
  final bool isEdit;
  final String? reminderTime;
  final String? reminderDate;

  const _ReminderBottomSheetContent({
    required this.title,
    required this.image,
    required this.date,
    required this.time,
    required this.id,
    required this.isEdit,
    this.reminderTime,
    this.reminderDate,
  });

  @override
  __ReminderBottomSheetContentState createState() =>
      __ReminderBottomSheetContentState();
}

class __ReminderBottomSheetContentState
    extends State<_ReminderBottomSheetContent> {
  late TextEditingController dateController;
  late TextEditingController timeController;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  void initState() {
    super.initState();
    dateController = TextEditingController();
    timeController = TextEditingController();

    // Set initial values if in edit mode and reminder data exists
    if (widget.isEdit &&
        widget.reminderDate != null &&
        widget.reminderTime != null) {
      _setInitialReminderValues();
    }

    print(
        "here is the id >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ${widget.id}");
  }

  @override
  void dispose() {
    dateController.dispose();
    timeController.dispose();
    super.dispose();
  }

  /// Set initial values from reminderDate and reminderTime for edit mode
  void _setInitialReminderValues() {
    try {
      // Parse reminder date (format: YYYY-MM-DD)
      if (widget.reminderDate != null && widget.reminderDate!.isNotEmpty) {
        final dateParts = widget.reminderDate!.split('-');
        if (dateParts.length == 3) {
          final year = int.parse(dateParts[0]);
          final month = int.parse(dateParts[1]);
          final day = int.parse(dateParts[2]);

          selectedDate = DateTime(year, month, day);

          // Format as mm/dd/yyyy for display
          dateController.text =
              "${month.toString().padLeft(2, '0')}/${day.toString().padLeft(2, '0')}/$year";
        }
      }

      // Parse reminder time (format: HH:MM:SS)
      if (widget.reminderTime != null && widget.reminderTime!.isNotEmpty) {
        final timeParts = widget.reminderTime!.split(':');
        if (timeParts.length >= 2) {
          final hour = int.parse(timeParts[0]);
          final minute = int.parse(timeParts[1]);

          selectedTime = TimeOfDay(hour: hour, minute: minute);

          // Display in 12-hour format
          timeController.text = _timeOfDayTo12HourFormat(selectedTime!);
        }
      }
    } catch (e) {
      print("Error parsing reminder values: $e");
    }
  }

  /// Convert 24-hour format to TimeOfDay
  TimeOfDay _convertToTimeOfDay(String time24) {
    try {
      final cleanedTime = time24.trim();
      final parts = cleanedTime.split(':');

      if (parts.length < 2) return TimeOfDay.now();

      final hour = int.tryParse(parts[0]) ?? 0;
      final minute = int.tryParse(parts[1]) ?? 0;

      return TimeOfDay(hour: hour, minute: minute);
    } catch (e) {
      return TimeOfDay.now();
    }
  }

  /// Convert 24-hour format to 12-hour format string
  String _convertTo12HourFormat(String time24) {
    try {
      final cleanedTime = time24.trim();
      final parts = cleanedTime.split(':');

      if (parts.length < 2) return time24;

      final hour = int.tryParse(parts[0]) ?? 0;
      final minute = int.tryParse(parts[1]) ?? 0;

      final period = hour >= 12 ? 'PM' : 'AM';
      final hour12 = hour % 12;
      final displayHour = hour12 == 0 ? 12 : hour12;
      final minuteStr = minute.toString().padLeft(2, '0');

      return '$displayHour:$minuteStr $period';
    } catch (e) {
      return time24;
    }
  }

  /// Convert TimeOfDay to 12-hour format string
  String _timeOfDayTo12HourFormat(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';

    return '$hour:$minute $period';
  }

  /// Convert TimeOfDay to 24-hour format for API
  String _timeOfDayTo24HourFormat(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  /// Get initial date for date picker
  DateTime _getInitialDate() {
    if (selectedDate != null) {
      return selectedDate!;
    } else if (widget.isEdit &&
        widget.reminderDate != null &&
        widget.reminderDate!.isNotEmpty) {
      try {
        final dateParts = widget.reminderDate!.split('-');
        if (dateParts.length == 3) {
          return DateTime(
            int.parse(dateParts[0]),
            int.parse(dateParts[1]),
            int.parse(dateParts[2]),
          );
        }
      } catch (e) {
        // Fallback to now
      }
    }
    return DateTime.now();
  }

  /// Get initial time for time picker
  TimeOfDay _getInitialTime() {
    if (selectedTime != null) {
      return selectedTime!;
    } else if (widget.isEdit &&
        widget.reminderTime != null &&
        widget.reminderTime!.isNotEmpty) {
      return _convertToTimeOfDay(widget.reminderTime!);
    } else {
      return _convertToTimeOfDay(widget.time);
    }
  }

  /// Time picker function with 12-hour format
  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _getInitialTime(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            alwaysUse24HourFormat: false,
          ),
          child: Theme(
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
          ),
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedTime = picked;
        timeController.text = _timeOfDayTo12HourFormat(picked);
      });
    }
  }

  /// Date picker function
  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _getInitialDate(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
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

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        // Format as mm/dd/yyyy
        dateController.text =
            "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  Future<void> _saveReminder() async {
    if (selectedDate == null || selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select both date and time')),
      );
      return;
    }

    final formattedDate = "${selectedDate!.day.toString().padLeft(2, '0')}-"
        "${selectedDate!.month.toString().padLeft(2, '0')}-"
        "${selectedDate!.year.toString().padLeft(4, '0')}";

    final formattedTime = _timeOfDayTo24HourFormat(selectedTime!);

    bool success = false;

    if (widget.isEdit) {
      success = await reminderUpdateApiRx.reminderUpdate(
        reminder_id: widget.id,
        date: formattedDate,
        time: formattedTime,
      );
    } else {
      success = await reminderUpdateApiRx.reminderUpdate(
        reminder_id: widget.id,
        date: formattedDate,
        time: formattedTime,
      );
    }

    if (success && mounted) {
      Navigator.of(context).pop(true); // return TRUE
    }
  }

  /// Get hint text for time field
  String _getTimeHintText() {
    if (selectedTime != null) {
      return _timeOfDayTo12HourFormat(selectedTime!);
    } else if (widget.isEdit &&
        widget.reminderTime != null &&
        widget.reminderTime!.isNotEmpty) {
      return _convertTo12HourFormat(widget.reminderTime!);
    } else {
      return _convertTo12HourFormat(widget.time);
    }
  }

  /// Get hint text for date field
  String _getDateHintText() {
    if (selectedDate != null) {
      return "${selectedDate!.month.toString().padLeft(2, '0')}/${selectedDate!.day.toString().padLeft(2, '0')}/${selectedDate!.year}";
    } else if (widget.isEdit &&
        widget.reminderDate != null &&
        widget.reminderDate!.isNotEmpty) {
      try {
        final dateParts = widget.reminderDate!.split('-');
        if (dateParts.length == 3) {
          return "${dateParts[1].padLeft(2, '0')}/${dateParts[2].padLeft(2, '0')}/${dateParts[0]}";
        }
      } catch (e) {
        return "mm/dd/yyyy";
      }
    }
    return "mm/dd/yyyy";
  }

  @override
  Widget build(BuildContext context) {
    // Convert the incoming spark time to 12-hour format for display
    final displayTime = _convertTo12HourFormat(widget.time);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Wrap(
        children: [
          CustomContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          widget.isEdit
                              ? "Edit Reminder 🔔"
                              : "Set Reminder 🔔",
                          style: TextFontStyle.textStyle16InterW400.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColor.cEDEDED,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: SvgPicture.asset(
                        AppIcons.cross,
                        height: 20.h,
                        width: 20.w,
                      ),
                    ),
                  ],
                ),
                UIHelper.verticalSpace(20.h),
                Container(
                  padding: EdgeInsets.all(16.sp),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: AppColor.c373B4C,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerImage(
                        imageUrl: widget.image,
                        placeholder: AppImages.placeholderImageItem,
                        height: 44.h,
                        width: 44.w,
                      ),
                      UIHelper.horizontalSpace(12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              style:
                                  TextFontStyle.textStyle14InterW500.copyWith(
                                color: AppColor.cDFE0E5,
                                fontSize: 16.sp,
                              ),
                            ),
                            UIHelper.verticalSpace(4.h),
                            Text(
                              "${widget.date}, $displayTime",
                              style:
                                  TextFontStyle.textStyle14InterW500.copyWith(
                                fontWeight: FontWeight.w400,
                                color: AppColor.cDFE0E5,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                UIHelper.verticalSpace(16.h),
                Text(
                  "Date",
                  style: TextFontStyle.textStyle16InterW700.copyWith(
                    color: AppColor.cEDEDED,
                  ),
                ),
                UIHelper.verticalSpace(8.h),
                InkWell(
                  onTap: _selectDate,
                  child: AbsorbPointer(
                    child: CustomTextField(
                      hintText: _getDateHintText(),
                      rightIcon: AppIcons.calendar,
                      readOnly: true,
                      controller: dateController,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(16.h),
                Text(
                  "Time",
                  style: TextFontStyle.textStyle16InterW700.copyWith(
                    color: AppColor.cEDEDED,
                  ),
                ),
                UIHelper.verticalSpace(8.h),
                InkWell(
                  onTap: _selectTime,
                  child: AbsorbPointer(
                    child: CustomTextField(
                      hintText: _getTimeHintText(),
                      rightIcon: AppIcons.clock,
                      readOnly: true,
                      controller: timeController,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(16.h),
                Divider(
                  thickness: 0.6,
                  color: AppColor.c4F556C,
                ),
                UIHelper.verticalSpace(20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomElevatedButton(
                      padding: EdgeInsets.symmetric(
                          vertical: 12.h, horizontal: 20.w),
                      backgroundColor: const Color(0xFF414556),
                      width: 160.w,
                      radius: 8.r,
                      text: "Cancel",
                      textStyle: TextFontStyle.textStyle14InterW500,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    CustomElevatedButton(
                      padding: EdgeInsets.symmetric(
                          vertical: 12.h, horizontal: 20.w),
                      backgroundColor: const Color(0xFFA4161A),
                      width: 160.w,
                      text: widget.isEdit ? "Update Reminder" : "Save Reminder",
                      onPressed: _saveReminder,
                      textStyle: TextFontStyle.textStyle14InterW500,
                    ),
                  ],
                ),
              ],
            ),
            padding: EdgeInsets.all(20.sp),
          ),
        ],
      ),
    );
  }
}
