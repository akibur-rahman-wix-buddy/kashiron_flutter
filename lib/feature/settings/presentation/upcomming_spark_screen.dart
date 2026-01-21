import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/common_widgets/custom_app_bar.dart';
import 'package:kashirons_flutter/feature/settings/widget/upcomming_Spark_Card.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';
import 'package:kashirons_flutter/networks/api_acess.dart';
import 'package:kashirons_flutter/networks/endpoints.dart';

class UpcommingSparkScreen extends StatefulWidget {
  const UpcommingSparkScreen({super.key});

  @override
  State<UpcommingSparkScreen> createState() => _UpcommingSparkScreenState();
}

class _UpcommingSparkScreenState extends State<UpcommingSparkScreen> {
  @override
  void initState() {
    // TODO: implement initState
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
          CustomAppBar(
            title: "Upcoming Sparks",
          ),
          UIHelper.verticalSpace(16.h),

          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Today",
                          style: TextFontStyle.textStyle14InterW500,
                        ),
                        UIHelper.horizontalSpace(16.h),
                        Expanded(
                          child: Divider(
                            height: 50,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    UIHelper.verticalSpace(16.h),
                    StreamBuilder(
                      stream: upcomingSparksApiRx.dataFetcher,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (snapshot.hasError) {
                          return const Center(
                            child: Text(
                              "Something went wrong",
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }

                        final sparks = snapshot.data!.data;

                        if (sparks == null || sparks.isEmpty) {
                          return const Center(
                            child: Text(
                              "No upcoming sparks found",
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }

                        return ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          padding: EdgeInsets.zero,
                          itemCount: sparks.length,
                          itemBuilder: (context, index) {
                            final data = sparks[index];

                            return UpcommingSparkCard(
                              titleName: data.title ?? "",
                              description: data.description ?? "",
                              image: data.vipAvatar ?? "",
                              cancelOnTap: () {},
                              date: data.dateTime ?? "",
                              day: data.daysLeft?.toString() ?? "",
                              relationship: "My mother",
                              saveOnTap: () {},
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
