import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import 'package:kashirons_flutter/common_widgets/custom_app_bar.dart';
import 'package:kashirons_flutter/common_widgets/custom_text_field.dart';
import 'package:kashirons_flutter/feature/vip_profile/model/vip_profile_model.dart';
import 'package:kashirons_flutter/feature/vip_profile/widget/select_interested_button.dart';
import 'package:kashirons_flutter/feature/vip_profile/widget/vip_profile_add_to_spark_card.dart';
import 'package:kashirons_flutter/helpers/all_routes.dart';
import 'package:kashirons_flutter/helpers/navigation_service.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';
import 'package:kashirons_flutter/networks/api_acess.dart';
import 'package:kashirons_flutter/networks/endpoints.dart';

class VipDetailsScreen extends StatefulWidget {
  final dynamic id;

  const VipDetailsScreen({super.key, required this.id});

  @override
  State<VipDetailsScreen> createState() => _VipDetailsScreenState();
}

class _VipDetailsScreenState extends State<VipDetailsScreen> {
  TextEditingController searchTextController = TextEditingController();

  late VipDataInfo vipDataInfo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVipProfileApiRx.getVipProfile(id: widget.id);
    log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>here is the id: ${widget.id.toString()}");
  }

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
                  final RenderBox button =
                      context.findRenderObject() as RenderBox;
                  final RenderBox overlay = Overlay.of(context)
                      .context
                      .findRenderObject() as RenderBox;
                  final RelativeRect position = RelativeRect.fromRect(
                    Rect.fromPoints(
                      button.localToGlobal(button.size.topRight(Offset.zero),
                          ancestor: overlay),
                      button.localToGlobal(button.size.bottomRight(Offset.zero),
                          ancestor: overlay),
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
                        child: GestureDetector(
                          onTap: () {
                            NavigationService.navigateToWithArgs(
                                Routes.addVipProfilePartScreen,
                                {"isEdit": true, "data": vipDataInfo});
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.edit,
                                size: 20,
                                color: Colors.white,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'Edit',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: GestureDetector(
                          onTap: () async {
                            bool success =
                                await vipDeleteApiRx.vipDelete(id: widget.id);
                            if (success) {
                              NavigationService.navigateTo(
                                  Routes.customBottomNavBar);
                            }
                          },
                          child: Row(
                            children: [
                              Icon(Icons.delete, size: 20, color: Colors.red),
                              SizedBox(width: 8.w),
                              Text('Delete',
                                  style: TextStyle(color: Colors.red)),
                            ],
                          ),
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
          StreamBuilder(
              stream: getVipProfileApiRx.dataFetcher,
              builder: (context, snapshot) {
                final data = snapshot.data?.data;

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: const CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Something went wrong',
                      style: TextFontStyle.textStyle14InterW400c787A83
                          .copyWith(color: Colors.redAccent),
                    ),
                  );
                }

                if (data == null || data == []) {
                  return Center(child: const CircularProgressIndicator());
                }

                vipDataInfo = data;

                return Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Card section
                          UIHelper.verticalSpace(16.h),

                          vipProfileAddToSparkCard(
                            imageUrl: "${imageUrlForBackend + data.avatar}",
                            onCardTap: () {
                              log(">>>>>>>>>>>>>>>>>>>>>>>>>> print ${data.avatar.toString()}");
                            },
                            buttonName: "Add Spark",
                            type: data.relation.name,
                            name: data.name,
                            birthdayDate: data.birthday,
                            onAddSparkTap: () {
                              NavigationService.navigateToWithArgs(
                                  Routes.createSparkScreen, {"id": data.id});
                            },
                            sparkNumber: data.sparkCount.toString(),
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
                              spacing: 8.w,
                              children: [
                                SizedBox(
                                  width: 303.w,
                                  child: Text('Special Notes',
                                      style:
                                          TextFontStyle.textStyle18InterW700),
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(12.sp),
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFF2D3142),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 1,
                                        color: const Color(0xFF373B4C),
                                      ),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    spacing: 167.w,
                                    children: [
                                      SizedBox(
                                        child: Text(data.specialNotes,
                                            textAlign: TextAlign.justify,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextFontStyle
                                                .textStyle14InterW500
                                                .copyWith(
                                                    color: Colors.white60)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          UIHelper.verticalSpace(16.h),

                          SelectedInterestsScreen(
                            interests: data?.selectedInterest
                                    .map((e) => e.name)
                                    .toList() ??
                                [],
                          ),

                          UIHelper.verticalSpace(16.h),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
