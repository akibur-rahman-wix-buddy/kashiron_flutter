import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import 'package:kashirons_flutter/common_widgets/custom_app_bar.dart';
import 'package:kashirons_flutter/common_widgets/shimmerClipOverImageWidget.dart';
import 'package:kashirons_flutter/feature/settings/widget/setting_item_card.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';
import 'package:kashirons_flutter/networks/endpoints.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryBg,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: "Create Spark",
            ), Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Padding(
                      padding: EdgeInsets.all(12.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///>>>>>>>>>>>>>> here is the profile section >>>>>>>>>>>>>>>>>>
                          Container(
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
                                  child: Column(
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
                                            Text(
                                                "jahidulislam3454@gmail.com",
                                                style: TextFontStyle.textStyle10InterW400
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                ),



                              ],
                            ),
                          ),

                          UIHelper.verticalSpace(16.h),
                          Text("Reminders & Gifts",style: TextFontStyle.textStyle16InterW700,),
                          UIHelper.verticalSpace(16.h),
                          SettingsItemCard(
                            onTap: (){},
                            icon: AppIcons.calendar2,
                            title: "Upcoming Sparks",
                            subtitle: "See all upcoming reminders (VIP events + self-care)",
                          ),
                          SettingsItemCard(
                            onTap: (){},
                            icon: AppIcons.gift,
                            title: "Brobrain Gift lists",
                            subtitle: "Browse popular gifts by category",
                          ),
                          SettingsItemCard(
                            onTap: (){},
                            icon: AppIcons.favourite,
                            title: "Favorite Gifts",
                            subtitle: "View and manage your saved gift items",
                          ),
                          SettingsItemCard(
                            onTap: (){},
                            icon: AppIcons.workHistory,
                            title: "Order History",
                            subtitle: "Track and review your past gift orders",
                          ),
                          UIHelper.verticalSpace(16.h),
                          Text("Account & Security",style: TextFontStyle.textStyle16InterW700,),
                          UIHelper.verticalSpace(16.h),
                          SettingsItemCard(
                            onTap: (){},
                            icon: AppIcons.profile,
                            title: "Edit Profile",
                            subtitle: "Update your name, email, date of birth and avatar",
                          ),
                          SettingsItemCard(
                            onTap: (){},
                            icon: AppIcons.fieldLock,
                            title: "Change Password",
                            subtitle: "Update your account password",
                          ),
                          SettingsItemCard(
                            onTap: (){},
                            icon: AppIcons.notificationIcon,
                            title: "Notifications",
                            subtitle: "Manage push alerts and preferences",
                          ),
                          SettingsItemCard(
                            onTap: (){},
                            icon: AppIcons.documentText,
                            title: "Terms of Use",
                            subtitle: "Read the terms and conditions",
                          ),
                          SettingsItemCard(
                            onTap: (){},
                            icon: AppIcons.policy,
                            title: "Privacy Policy",
                            subtitle: "Read our privacy policy",
                          ),
                          SettingsItemCard(
                            onTap: (){},
                            icon: AppIcons.delete2,
                            title: "Delete Account",
                            subtitle: "Permanently delete all data",
                          ),
                          SettingsItemCard(
                            onTap: (){},
                            icon: AppIcons.logout,
                            title: "Sign Out",
                            subtitle: "End session and return to login",
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}
