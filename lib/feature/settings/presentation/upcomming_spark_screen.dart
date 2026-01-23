import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/common_widgets/custom_app_bar.dart';
import 'package:kashirons_flutter/feature/settings/widget/upcomming_Spark_Card.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';
import 'package:kashirons_flutter/networks/api_acess.dart';

class UpcommingSparkScreen extends StatefulWidget {
  const UpcommingSparkScreen({super.key});

  @override
  State<UpcommingSparkScreen> createState() => _UpcommingSparkScreenState();
}

class _UpcommingSparkScreenState extends State<UpcommingSparkScreen> {
  @override
  void initState() {
    super.initState();
    upcomingSparksApiRx.upcomingSparks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryBg,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// App Bar
          const CustomAppBar(
            title: "Upcoming Sparks",
          ),
          UIHelper.verticalSpace(16.h),

          Expanded(
            child: StreamBuilder(
              stream: upcomingSparksApiRx.dataFetcher,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                }

                if (!snapshot.hasData ||
                    snapshot.data == null ||
                    snapshot.data!.data == null) {
                  return Center(
                    child: Text(
                      "No data available",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                    ),
                  );
                }

                final dateGroups = snapshot.data!.data!;

                if (dateGroups.isEmpty) {
                  return Center(
                    child: Text(
                      "No upcoming sparks found",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                    ),
                  );
                }

                final validDateGroups = dateGroups
                    .where((group) =>
                        group.sparks != null && group.sparks!.isNotEmpty)
                    .toList();

                if (validDateGroups.isEmpty) {
                  return Center(
                    child: Text(
                      "No upcoming sparks found",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.only(
                    bottom: 16.h,
                    top: 8.h,
                  ),
                  itemCount: validDateGroups.length,
                  itemBuilder: (context, groupIndex) {
                    final dateGroup = validDateGroups[groupIndex];
                    final sparks = dateGroup.sparks!;

                    String headerText = dateGroup.date ?? "";
                    if (dateGroup.isToday == true) {
                      headerText = "Today";
                    } else if (dateGroup.isTomorrow == true) {
                      headerText = "Tomorrow";
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Text(
                                          headerText,
                                          style: TextFontStyle
                                              .textStyle14InterW500
                                              .copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(width: 16.w),
                                        Expanded(
                                          child: Divider(
                                            thickness: 1,
                                            height: 1,
                                            color:
                                                Colors.white.withOpacity(0.3),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.h),
                            ],
                          ),
                        ),

                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          itemCount: sparks.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 16.h),
                          itemBuilder: (context, sparkIndex) {
                            final spark = sparks[sparkIndex];

                            return UpcommingSparkCard(
                              titleName: spark.title ?? "No Title",
                              description:
                                  spark.description ?? "No Description",
                              image: spark.vip?.avatar ?? "",
                              cancelOnTap: () {
                                _showCancelDialog(context, spark.id);
                              },
                              date: spark.dateTime ?? "",
                              day: spark.daysLeft ?? "",
                              relationship: spark.vip?.relation?.name ??
                                  "No Relationship",
                              saveOnTap: () {
                                _showSaveDialog(context, spark.id);
                              },
                            );
                          },
                        ),

                        // Add spacing between date groups (except for last one)
                        if (groupIndex < validDateGroups.length - 1)
                          UIHelper.verticalSpace(16.h)
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showCancelDialog(BuildContext context, int? sparkId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Cancel Spark",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          "Are you sure you want to cancel this spark?",
          style: TextStyle(fontSize: 14.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "No",
              style: TextStyle(fontSize: 14.sp),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (sparkId != null) {
                _cancelSpark(sparkId);
              }
            },
            child: Text(
              "Yes",
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSaveDialog(BuildContext context, int? sparkId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Save Spark",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          "Are you sure you want to save this spark?",
          style: TextStyle(fontSize: 14.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "No",
              style: TextStyle(fontSize: 14.sp),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Implement save logic here
              if (sparkId != null) {
                _saveSpark(sparkId);
              }
            },
            child: Text(
              "Yes",
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _cancelSpark(int sparkId) {
    // Implement cancel spark API call
    print("Cancelling spark with ID: $sparkId");
    // Add your API call here
  }

  void _saveSpark(int sparkId) {
    // Implement save spark API call
    print("Saving spark with ID: $sparkId");
    // Add your API call here
  }
}
