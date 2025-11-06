import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import 'package:kashirons_flutter/common_widgets/custom_app_bar.dart';
import 'package:kashirons_flutter/common_widgets/custom_text_field.dart';
import 'package:kashirons_flutter/feature/vip_profile/widget/select_interested_button.dart';
import 'package:kashirons_flutter/feature/vip_profile/widget/vip_profile_add_to_spark_card.dart';
import 'package:kashirons_flutter/helpers/all_routes.dart';
import 'package:kashirons_flutter/helpers/navigation_service.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';

class VipDetailsScreen extends StatefulWidget {
  const VipDetailsScreen({super.key});

  @override
  State<VipDetailsScreen> createState() => _VipDetailsScreenState();
}

class _VipDetailsScreenState extends State<VipDetailsScreen> {
  TextEditingController searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryBg,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///>>>>>>>>>>>>>>>>>>>>>>>>> app bar section >>>>>>>>>>>>>
          CustomAppBar(
            title: "VIP Details",
            actionButton: IconButton(
                onPressed: () {
                  final RenderBox button = context.findRenderObject() as RenderBox;
                  final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
                  final RelativeRect position = RelativeRect.fromRect(
                    Rect.fromPoints(
                      button.localToGlobal(button.size.topRight(Offset.zero), ancestor: overlay),
                      button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
                    ),
                    Offset.zero & overlay.size,
                  );

                  showMenu(
                    color: AppColor.primaryBg,
                    context: context,
                    position: position,
                    items: [
                      PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit, size: 20,color: Colors.white,),
                            SizedBox(width: 8.w),
                            Text('Edit',style: TextStyle(color: Colors.white),),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete, size: 20, color: Colors.red),
                            SizedBox(width: 8.w),
                            Text('Delete', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ],
                  ).then((value) {
                    if (value != null) {
                      if (value == 'edit') {
                        // Edit logic
                      } else if (value == 'delete') {
                        // Delete logic
                      }
                    }
                  });
                },
                icon: Icon(Icons.more_vert, color: Colors.white, size: 24)),
          ),

          // Wrap the content with Expanded
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Card section
                    UIHelper.verticalSpace(16.h),

                    vipProfileAddToSparkCard(
                      onCardTap: () {},
                      buttonName: "Add Heads-Up",
                      type: "brother",
                      name: "Sayda Tasnim",
                      birthdayDate: "10 August",
                      onAddSparkTap: () {
                        NavigationService.navigateTo(Routes.createSparkScreen);
                      },
                      sparkNumber: "0",
                    ),
                    UIHelper.verticalSpace(8.h),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: ShapeDecoration(
                        color: const Color(0xFF2D3142),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 8,
                        children: [
                          SizedBox(
                            width: 303,
                            child: Text('Special Notes',
                                style: TextFontStyle.textStyle18InterW700),
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: ShapeDecoration(
                              color: const Color(0xFF2D3142),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 1,
                                  color: const Color(0xFF373B4C),
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              spacing: 167,
                              children: [
                                SizedBox(
                                  width: 310,
                                  child: Text(
                                      textAlign: TextAlign.justify,
                                      'Jahidul Islam is cheerful and loves celebrating birthdays with family. Passionate about teaching and books, she also enjoys gardening. Flowers or a personalized book always make her smile on special occasions.',
                                      style: TextFontStyle
                                          .textStyle14InterW500
                                          .copyWith(color: Colors.white60)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// select interest section
                    UIHelper.verticalSpace(16.h),

                    SelectedInterestsScreen(
                      interests: [
                        "Fashion/Style",
                        "DIY",
                        "Writing",
                        "Reading",
                        "Photography",
                        "Travel",
                        "Adventure",
                        "Music",
                      ],
                    ),

                    UIHelper.verticalSpace(16.h),
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
