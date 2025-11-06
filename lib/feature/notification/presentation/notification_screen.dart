import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/common_widgets/custom_app_bar.dart';
import 'package:kashirons_flutter/feature/notification/model/dummy_model_with_list.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';

class NotificationScreen extends StatelessWidget {
  final Map<String, List<ReminderItem>> reminders =
  ReminderData.getGroupedReminders();
  final List<String> timePeriods = ReminderData.getTimePeriods();

  NotificationScreen({super.key});

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
            child: ListView.builder(
              itemCount: timePeriods.length,
              itemBuilder: (context, sectionIndex) {
                final period = timePeriods[sectionIndex];
                final periodReminders = reminders[period] ?? [];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section Header
                    Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          Text(
                            period,
                            style: TextFontStyle.textStyle18InterW700.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          UIHelper.horizontalSpace(25.w),
                            Expanded(
                                child: Divider(
                                  height: 2,
                                  color: Colors.white,
                                )),
                        ],
                      ),
                    ),

                    // Section Items
                    ...periodReminders.map((reminder) {
                      // Skip rendering if title, category, and description are empty
                      if (reminder.title.isEmpty &&
                          reminder.category.isEmpty &&
                          reminder.description.isEmpty) {
                        return const SizedBox.shrink();
                      }

                      // Regular reminder item
                      return SizedBox(
                        width: double.infinity,
                        child: Container(
                          decoration: BoxDecoration(
                              color: reminder.isSeen ? Color(0xFF2D3142) : null,
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(
                                  color: reminder.isSeen != true
                                      ? Colors.white54
                                      : Colors.transparent)),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Title and Timestamp Row
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        reminder.title,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    if (reminder.timestamp != null)
                                      Text(
                                        reminder.timestamp!,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.white54,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                  ],
                                ),

                                const SizedBox(height: 8),

                                // Category Badge
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.blue.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        reminder.category,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    reminder.isSeen
                                        ? CircleAvatar(
                                      radius: 5.r,
                                      backgroundColor: Colors.red,
                                    )
                                        : SizedBox.shrink()
                                  ],
                                ),

                                const SizedBox(height: 8),

                                // Description
                                Text(
                                  reminder.description,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white54,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),

                    // Divider between sections
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}