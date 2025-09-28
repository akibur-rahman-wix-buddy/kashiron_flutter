import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_image.dart';
import 'package:kashirons_flutter/common_widgets/custom_app_bar.dart';
import 'package:kashirons_flutter/common_widgets/custom_button.dart';
import 'package:kashirons_flutter/common_widgets/custom_elevated_button.dart';
import 'package:kashirons_flutter/constants/app_constants.dart';
import 'package:kashirons_flutter/feature/spark/widget/SparkBottomCard.dart';
import 'package:kashirons_flutter/feature/spark/widget/reminder_bottom_sheet.dart';
import 'package:kashirons_flutter/feature/spark/widget/reroll_gifts_button.dart';
import 'package:kashirons_flutter/feature/spark/widget/spark_hading_card.dart';
import 'package:kashirons_flutter/feature/spark/widget/spark_product_card.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';
import '../../../assets_helperfdg/app_fonts.dart';

class VipSparkDetailsScreen extends StatelessWidget {
  const VipSparkDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryBg,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ============================ App bar ====================== ///
            CustomAppBar(
              title: "Spark Details",
            ),

            /// ============================ Fixed Header Section ====================== ///
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
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

                  UIHelper.verticalSpace(16.h),

                  // This section stays fixed at the top
                  Container(
                    color: AppColor.primaryBg,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Gift Ideas for Mother",
                              style: TextFontStyle.textStyle16InterW700,
                            ),
                            RerollButton(
                              onTap: () {
                                print("Reroll API called!");
                              },
                            ),
                          ],
                        ),
                        UIHelper.verticalSpace(8.h),
                        Divider(
                          color: Colors.white,
                          height: 3,
                        ),
                        UIHelper.verticalSpace(8.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// ============================ GridView Section ====================== ///
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 100 / 145,
                ),
                itemCount: 6,
                padding: const EdgeInsets.only(bottom: 16),
                shrinkWrap:
                    true, // Ensures GridView takes only the space it needs
                physics:
                    const NeverScrollableScrollPhysics(), // Disables GridView's own scrolling
                itemBuilder: (context, index) {
                  return SparkProductCard(
                    title: "Smart Watch",
                    price: 100,
                    image: "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZHVjdHxlbnwwfHwwfHx8MA%3D%3D",
                    onBuyTap: () {
                      print("Buy gift tapped for index $index");
                    },
                  );
                },
              ),
            ),

            /// "Surprise Flowers" Text at the bottom
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Text(
                "Surprise Flowers",
                style: TextFontStyle.textStyle18InterW700,
              ),
            ),
            SparkCard(
              iconCircleColor: Color(0xFF009F50),
              ifButton: true,
              onTap: () {},
              title: "Send Flowers & Card",
              subTitle: "Deliver fresh flowers with a personalized card ",
              buttonName: "Send Now",
              iconName: Icons.settings,
            ),

            ///>>>>>>>>>>>>>>>>>>>>>> option section >>>>>>>>>>>>>>>>>>>>>>>>
            UIHelper.verticalSpace(16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Text(
                "Option",
                style: TextFontStyle.textStyle18InterW700,
              ),
            ),
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
                ReminderBottomSheet.show(context);
              },
              title: "Remind Me",
              subTitle: "Set a reminder to receive alerts before this spark.",
              buttonName: "Set",
              iconName: Icons.notification_important,
            ),
            UIHelper.verticalSpace(16.h),
          ],
        ),
      ),
    );
  }
}
