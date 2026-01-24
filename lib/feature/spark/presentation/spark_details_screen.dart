import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/common_widgets/custom_app_bar.dart';
import 'package:kashirons_flutter/constants/app_constants.dart';
import 'package:kashirons_flutter/feature/spark/widget/reminder_bottom_sheet.dart';
import 'package:kashirons_flutter/feature/spark/widget/spark_hading_card.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';
import '../../../assets_helperfdg/app_fonts.dart';
import '../widget/SparkBottomCard.dart' show SparkCard;

class SparkDetailsScreen extends StatelessWidget {
  const SparkDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryBg,
      body: Column(
        children: [
          /// ============================ App bar ====================== ///
          CustomAppBar(
            title: "Spark Details",
          ),
          Expanded(
            child: Column(
              children: [
                /// ============================ Fixed Header Section ====================== ///
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 16.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SparkHadingCard(
                            title: "Mom's Birthday 🎂 ",
                            image: PlaceholderNetworkImageUrl,
                            name: "Samantha Usry",
                            description:
                                "Don't miss their special day—send love, wishes, and joy that make birthdays truly unforgettable!",
                            leftDate: "September 6, 2025",
                            relation: "Mother",
                            leftTime: "2 days left",
                          ),
                        ],
                      ),
                    ),

                    ///>>>>>>>>>>>>>>>>>>>>>> option section >>>>>>>>>>>>>>>>>>>>>>>>
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      child: Text(
                        "Option",
                        style: TextFontStyle.textStyle18InterW700,
                      ),
                    ),
                    SparkCard(
                      iconCircleColor: Color(0xFF3B82F6),
                      ifButton: false,
                      onTap: () {},
                      title: "Edit Spark",
                      subTitle: "Modify details and timing",
                      buttonName: "Send Now",
                      iconName: Icons.edit,
                    ),
                    UIHelper.verticalSpace(16.h),
                    SparkCard(
                      iconCircleColor: Color(0xFF009F50),
                      ifButton: false,
                      onTap: () {},
                      title: "Delete Spark",
                      subTitle: "Remove this reminder",
                      buttonName: "Send Now",
                      iconName: Icons.delete,
                    ),
                    UIHelper.verticalSpace(16.h),
                    SparkCard(
                      iconCircleColor: Color(0xFFEB690E),
                      ifButton: true,
                      onTap: () {
                        ReminderBottomSheet.show(context,
                            id: '', spark_id: '', date: '', time: '');
                      },
                      title: "Remind Me",
                      subTitle:
                          "Set a reminder to receive alerts before this spark.",
                      buttonName: "Set",
                      iconName: Icons.notification_important,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
