
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/common_widgets/custom_app_bar.dart';
import 'package:kashirons_flutter/feature/settings/widget/upcomming_Spark_Card.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';
import 'package:kashirons_flutter/networks/endpoints.dart';

class UpcommingSparkScreen extends StatefulWidget {
  const UpcommingSparkScreen({super.key});

  @override
  State<UpcommingSparkScreen> createState() => _UpcommingSparkScreenState();
}

class _UpcommingSparkScreenState extends State<UpcommingSparkScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryBg,
      body: SafeArea(
        child: Column(
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
                         Text("Today",style: TextFontStyle.textStyle14InterW500,),
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


                     ListView.builder(
                         shrinkWrap: true,
                       primary: false,
                       itemCount: 5,
                         itemBuilder:  (context,index) {
                         return UpcommingSparkCard(
                           titleName: "Mom’s Birthday 🎂 ",
                           description: "Don’t miss their special day—send love, wishes, and joy that make birthdays truly unforgettable!",
                           image: personImageUrl,
                           cancelOnTap: (){},
                           date: "23 August 2025",
                           day: "Today",
                           relationship: "My mother",
                           saveOnTap: (){},
                         );
                       }
                     )
                   ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


