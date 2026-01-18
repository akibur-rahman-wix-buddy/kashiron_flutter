import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import 'package:kashirons_flutter/common_widgets/custom_app_bar.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';

class SettingsNotificationScreen extends StatefulWidget {
  SettingsNotificationScreen({super.key});

  @override
  State<SettingsNotificationScreen> createState() => _SettingsNotificationScreenState();
}

class _SettingsNotificationScreenState extends State<SettingsNotificationScreen> {
  bool isPushNotificationOn = true;
  bool isReminderSwitchOn = true;
  bool isVipUpdatesOn = true;
  bool isGiftSuggestionsOn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryBg,
      body: Column(
        children: [
          CustomAppBar(
            title: "Notification",
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Push Notifications",
                    style: TextFontStyle.textStyle16InterW700,
                  ),
                  UIHelper.verticalSpace(8.h),
                  Text(
                    "Manage how BroBrain sends you updates and alerts. Turn on push notifications to stay informed about upcoming sparks, gift ideas, and VIP events.",
                    style: TextFontStyle.textStyle12InterW400.copyWith(
                      color: Colors.white60,
                    ),
                  ),
                  UIHelper.verticalSpace(20.h),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: ShapeDecoration(
                      color: const Color(0xFF2D3142),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.notification_important,
                                    color: Colors.white,
                                    size: 35,
                                  ),
                                  UIHelper.horizontalSpace(8.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Push Notifications Enabled",
                                          style: TextFontStyle.textStyle14InterW500,
                                        ),
                                        UIHelper.verticalSpace(8.h),
                                        Text(
                                          "Receive reminders for VIP events, self-care, and gift suggestions.",
                                          style: TextFontStyle.textStyle12InterW400.copyWith(color: Colors.white60),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            UIHelper.horizontalSpace(8.w),
                            SizedBox(
                              height: 80,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomSwitch(
                                    initialValue: isPushNotificationOn,
                                    onChanged: (val) {
                                      setState(() => isPushNotificationOn = val);
                                      print("Main Push Notification Switch is now: $val");
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        UIHelper.verticalSpace(16.h),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          decoration: ShapeDecoration(
                            color: const Color(0xFF2D3142),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1,
                                color: Colors.white60,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                isPushNotificationOn ? Icons.check_circle : Icons.cancel,
                                color: Colors.grey,
                              ),
                              UIHelper.horizontalSpace(8.w),
                              Text(
                                isPushNotificationOn ? "Notifications enabled ✅" : "Notifications are off ❌",
                                style: TextFontStyle.textStyle12InterW400,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  UIHelper.verticalSpace(16.h),
                  isPushNotificationOn?  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("What you'll get", style: TextFontStyle.textStyle16InterW700),
                      UIHelper.verticalSpace(16.h),

                      // Reminders
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: ShapeDecoration(
                          color: const Color(0xFF2D3142),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(AppIcons.calendar),
                                  UIHelper.horizontalSpace(8.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Reminders", style: TextFontStyle.textStyle14InterW500),
                                        Text("Birthdays, milestones, spark nudges",
                                            style: TextFontStyle.textStyle12InterW400.copyWith(color: Colors.white60))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CustomSwitch(
                              initialValue: isReminderSwitchOn,
                              onChanged: (val) {
                                setState(() => isReminderSwitchOn = val);
                                print("Reminders Switch is now: $val");
                              },
                            ),
                          ],
                        ),
                      ),
                      UIHelper.verticalSpace(16.h),

                      // VIP Updates
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: ShapeDecoration(
                          color: const Color(0xFF2D3142),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(AppIcons.star),
                                  UIHelper.horizontalSpace(8.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("VIP Updates", style: TextFontStyle.textStyle14InterW500),
                                        Text("Important changes and insights",
                                            style: TextFontStyle.textStyle12InterW400.copyWith(color: Colors.white60))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CustomSwitch(
                              initialValue: isVipUpdatesOn,
                              onChanged: (val) {
                                setState(() => isVipUpdatesOn = val);
                                print("VIP Updates Switch is now: $val");
                              },
                            ),
                          ],
                        ),
                      ),
                      UIHelper.verticalSpace(16.h),

                      // Gift Suggestions
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: ShapeDecoration(
                          color: const Color(0xFF2D3142),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(AppIcons.suggestedStars),
                                  UIHelper.horizontalSpace(8.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Gift Suggestions", style: TextFontStyle.textStyle14InterW500),
                                        Text("Personalized gift picks and ideas",
                                            style: TextFontStyle.textStyle12InterW400.copyWith(color: Colors.white60))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CustomSwitch(
                              initialValue: isGiftSuggestionsOn,
                              onChanged: (val) {
                                setState(() => isGiftSuggestionsOn = val);
                                print("Gift Suggestions Switch is now: $val");
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ):SizedBox()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomSwitch extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({
    super.key,
    this.initialValue = false,
    required this.onChanged,
  });

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  late bool isOn;

  @override
  void initState() {
    super.initState();
    isOn = widget.initialValue;
  }

  void toggleSwitch() {
    setState(() => isOn = !isOn);
    widget.onChanged(isOn);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleSwitch,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 55.w,
        height: 30.h,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: isOn ? Colors.greenAccent.shade700 : Colors.grey.shade600,
        ),
        alignment: isOn ? Alignment.centerRight : Alignment.centerLeft,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: 22.w,
          height: 22.h,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 3,
                offset: Offset(1, 2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}