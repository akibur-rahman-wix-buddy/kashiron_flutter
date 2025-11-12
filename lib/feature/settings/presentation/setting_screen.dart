import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import 'package:kashirons_flutter/common_widgets/custom_app_bar.dart';
import 'package:kashirons_flutter/common_widgets/shimmerClipOverImageWidget.dart';
import 'package:kashirons_flutter/feature/settings/data/model/user_infi_data_model.dart';
import 'package:kashirons_flutter/feature/settings/widget/logout_dialouge_box.dart';
import 'package:kashirons_flutter/feature/settings/widget/setting_item_card.dart';
import 'package:kashirons_flutter/helpers/all_routes.dart';
import 'package:kashirons_flutter/helpers/navigation_service.dart';
import 'package:kashirons_flutter/helpers/toast.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';
import 'package:kashirons_flutter/networks/api_acess.dart';
import 'package:kashirons_flutter/networks/endpoints.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isLoading = false;
  GetUserProfileModelData? userProfileData;
  String errorMessage = '';

  @override
  void initState() {
    loadUserProfile();
    super.initState();
  }

  Future<void> loadUserProfile() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final profileData = await getUserProfileRx.getProfileApiData();

      setState(() {
        userProfileData = profileData;
        isLoading = false;
      });

      if (profileData == null) {
        setState(() {
          errorMessage = 'Failed to load user profile';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryBg,
      body: Column(
        children: [
          CustomAppBar(
            prefixIcon: SizedBox(
              width: 50,
            ),
            title: "Settings",
          ),
          Expanded(
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
                                          networkImageLink: personImageUrl,
                                        ),
                                        UIHelper.horizontalSpace(8.w),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              userProfileData?.data?.user?.name.toString()??"",
                                              style: TextFontStyle
                                                  .textStyle20InterW500
                                                  .copyWith(fontSize: 18),
                                            ),
                                            UIHelper.verticalSpace(8.h),
                                            Text(userProfileData?.data?.user?.email.toString()??"",
                                                style: TextFontStyle
                                                    .textStyle10InterW400),
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
                        Text(
                          "Reminders & Gifts",
                          style: TextFontStyle.textStyle16InterW700,
                        ),
                        UIHelper.verticalSpace(16.h),
                        SettingsItemCard(
                          onTap: () {
                            NavigationService.navigateTo(
                                Routes.upcommingSparkScreen);
                          },
                          icon: AppIcons.calendar2,
                          title: "Upcoming Sparks",
                          subtitle:
                              "See all upcoming reminders (VIP events + self-care)",
                        ),

                        SettingsItemCard(
                          onTap: () {
                            NavigationService.navigateTo(
                                Routes.brobrainGiftListScreen);
                          },
                          icon: AppIcons.gift,
                          title: "Brobrain Gift lists",
                          subtitle: "Browse popular gifts by category",
                        ),

                        SettingsItemCard(
                          onTap: () {
                            NavigationService.navigateTo(
                                Routes.favoriteGiftsScreen);
                          },
                          icon: AppIcons.favourite,
                          title: "Favorite Gifts",
                          subtitle: "View and manage your saved gift items",
                        ),

                        SettingsItemCard(
                          onTap: () {
                            NavigationService.navigateTo(
                                Routes.orderHistoryScreen);
                          },
                          icon: AppIcons.workHistory,
                          title: "Order History",
                          subtitle: "Track and review your past gift orders",
                        ),

                        UIHelper.verticalSpace(16.h),
                        Text(
                          "Account & Security",
                          style: TextFontStyle.textStyle16InterW700,
                        ),
                        UIHelper.verticalSpace(16.h),

                        SettingsItemCard(
                          onTap: () {
                            NavigationService.navigateToWithArgs(
                                Routes.editProfileScreen,{
                                  "data":userProfileData
                            });
                          },
                          icon: AppIcons.profile,
                          title: "Edit Profile",
                          subtitle:
                              "Update your name, email, date of birth and avatar",
                        ),

                        SettingsItemCard(
                          onTap: () {
                            NavigationService.navigateTo(
                                Routes.changePasswordScreen);
                          },
                          icon: AppIcons.fieldLock,
                          title: "Change Password",
                          subtitle: "Update your account password",
                        ),
                        SettingsItemCard(
                          onTap: () {
                            NavigationService.navigateTo(
                                Routes.settingsNotificationScreen);
                          },
                          icon: AppIcons.notificationIcon,
                          title: "Notifications",
                          subtitle: "Manage push alerts and preferences",
                        ),
                        SettingsItemCard(
                          onTap: () {
                            NavigationService.navigateTo(
                                Routes.termsAndConditionScreen);
                          },
                          icon: AppIcons.documentText,
                          title: "Terms of Use",
                          subtitle: "Read the terms and conditions",
                        ),

                        SettingsItemCard(
                          onTap: () {
                            NavigationService.navigateTo(
                                Routes.privacyPolicyScreen);
                          },
                          icon: AppIcons.policy,
                          title: "Privacy Policy",
                          subtitle: "Read our privacy policy",
                        ),
                        SettingsItemCard(
                          onTap: () {
                            NavigationService.navigateTo(
                                Routes.deleteAccountScreen);
                          },
                          icon: AppIcons.delete2,
                          title: "Delete Account",
                          subtitle: "Permanently delete all data",
                        ),
                        SettingsItemCard(
                          onTap: () {
                            LogoutDialog.showLogoutDialog(

                              context: context,
                              onLogout: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                bool success = await postLogOutRX.logOut();
                                if (success) {
                                  setState(() {
                                    isLoading = false;
                                  });

                                  NavigationService.navigateToUntilReplacement(
                                      Routes.loginScreen);
                                }
                                setState(() {
                                  isLoading = false;
                                });
                              },
                              isLoading: isLoading,
                            );
                          },
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
    );
  }
}
