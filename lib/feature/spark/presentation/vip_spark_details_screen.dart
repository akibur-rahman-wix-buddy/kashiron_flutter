import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/common_widgets/custom_app_bar.dart';
import 'package:kashirons_flutter/feature/home_screen/widget/set_reminder_bottomSheet.dart';
import 'package:kashirons_flutter/feature/spark/model/interest_wise_product_model.dart';
import 'package:kashirons_flutter/feature/spark/model/reminder_list_model.dart';
import 'package:kashirons_flutter/feature/spark/model/spark_show_model.dart';
import 'package:kashirons_flutter/feature/spark/widget/SparkBottomCard.dart';
import 'package:kashirons_flutter/feature/spark/widget/reroll_gifts_button.dart';
import 'package:kashirons_flutter/feature/spark/widget/spark_delete_dialogue.dart';
import 'package:kashirons_flutter/feature/spark/widget/spark_hading_card.dart';
import 'package:kashirons_flutter/feature/spark/widget/spark_product_card.dart';
import 'package:kashirons_flutter/helpers/all_routes.dart';
import 'package:kashirons_flutter/helpers/navigation_service.dart';
import 'package:kashirons_flutter/helpers/toast.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';
import 'package:kashirons_flutter/networks/api_acess.dart';
import 'package:url_launcher/url_launcher.dart';

class VipSparkDetailsScreen extends StatefulWidget {
  final String? id;
  final String? vip_id;

  const VipSparkDetailsScreen({super.key, this.id, this.vip_id});

  @override
  State<VipSparkDetailsScreen> createState() => _VipSparkDetailsScreenState();
}

class _VipSparkDetailsScreenState extends State<VipSparkDetailsScreen> {
  bool isLoading = false;
  bool reminderEdit = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    vipSparksDetailsApiRx.getVipSparksDetails(id: widget.id.toString());
    reminderListApiRx.reminderListData();
    widget.vip_id == "0"
        ? null
        : interestWiseProductApiRx.getInterestWideProducts(
            id: widget.vip_id.toString());
  }

  late String relationName = "Myself";

  bool reroll = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryBg,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(
            title: "Spark Details",
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StreamBuilder<SparkShowModel>(
                          stream: vipSparksDetailsApiRx.dataFetcher,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData || snapshot.data == null) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            final model = snapshot.data!;
                            final data = model.data;
                            relationName =
                                data?.vip?.relation?.name ?? "Relation Name";
                            if (data == null || data.vip == null) {
                              return const SizedBox();
                            }

                            return SparkHadingCard(
                              title: data.title ?? '',
                              image: data.vip?.avatar ?? '',
                              name: data.vip?.name ?? '',
                              description: data.description ?? '',
                              leftDate: data.formattedDate ?? '',
                              relation: data.vip?.relation?.name ?? '',
                              leftTime: data.daysStatus ?? '',
                            );
                          },
                        ),
                        UIHelper.verticalSpace(16.h),
                        Container(
                          color: AppColor.primaryBg,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Gift Ideas for ${relationName}",
                                    style: TextFontStyle.textStyle16InterW700,
                                  ),
                                  RerollButton(
                                    onTap: () {
                                      interestWiseProductApiRx
                                          .getInterestWideProducts(
                                              id: widget.vip_id.toString());

                                      setState(() {
                                        reroll = true;
                                      });

                                      Future.delayed(const Duration(seconds: 3),
                                          () {
                                        if (mounted) {
                                          setState(() {
                                            reroll = false;
                                          });
                                        }
                                      });
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
                  reroll
                      ? Center(child: CircularProgressIndicator())
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: StreamBuilder<VipInterestWiseProductModel>(
                            stream: interestWiseProductApiRx.dataFetcher,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }

                              if (snapshot.hasError) {
                                return const Center(
                                    child: Text("Something went wrong"));
                              }

                              if (!snapshot.hasData ||
                                  snapshot.data == null ||
                                  snapshot.data!.data == null ||
                                  snapshot.data!.data!.isEmpty) {
                                return const Center(
                                    child: Text("No products found"));
                              }

                              final products = snapshot.data!.data!;

                              return GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 16,
                                  crossAxisSpacing: 16,
                                  childAspectRatio: 100 / 145,
                                ),
                                itemCount: products.length,
                                padding: const EdgeInsets.only(bottom: 16),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final data = products[index];

                                  return SparkProductCard(
                                    isFavorite: data.isFavourite ?? false,
                                    title: data.title ?? "",
                                    price: double.tryParse(
                                            data.price?.amount ?? '0') ??
                                        0.0,
                                    image: data.mainImage.toString(),
                                    onBuyTap: () async {
                                      final url = data.sourceRef;

                                      if (url == null || url.isEmpty) return;

                                      final uri = Uri.parse(url);

                                      if (!await launchUrl(
                                        uri,
                                        mode: LaunchMode.externalApplication,
                                      )) {
                                        debugPrint('Could not launch $url');
                                      }
                                    },
                                    id: data.productId.toString(),
                                    ontap: () {
                                      NavigationService.navigateToWithArgs(
                                          Routes.productDetailScreen,
                                          {"id": data.productId.toString()});
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    child: Text(
                      "Surprise Flowers",
                      style: TextFontStyle.textStyle18InterW700,
                    ),
                  ),
                  SparkCard(
                    iconCircleColor: const Color(0xFF009F50),
                    ifButton: true,
                    onTap: () {
                      NavigationService.navigateTo(Routes.sendFlowerCardScreen);
                    },
                    title: "Send Flowers & Card",
                    subTitle: "Deliver fresh flowers with a personalized card ",
                    buttonName: "Send Now",
                    iconName: Icons.settings,
                  ),
                  UIHelper.verticalSpace(16),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    child: Text(
                      "Option",
                      style: TextFontStyle.textStyle18InterW700,
                    ),
                  ),
                  SparkCard(
                    iconCircleColor: const Color(0xFF009F50),
                    ifButton: false,
                    onTap: () {
                      SparkDeleteDialog.showLogoutDialog(
                        context: context,
                        onLogout: () async {
                          setState(() {
                            isLoading = true;
                          });
                          bool success = await sparkDeleteApiRx.sparkDelete(
                              id: widget.id.toString());
                          if (success) {
                            setState(() {
                              isLoading = false;
                            });
                            NavigationService.navigateTo(
                                Routes.customBottomNavBar);
                          }
                          setState(() {
                            isLoading = false;
                          });
                        },
                        isLoading: isLoading,
                      );
                    },
                    title: "Delete Spark",
                    subTitle: "Remove this reminder",
                    buttonName: "Send Now",
                    iconName: Icons.delete,
                  ),
                  UIHelper.verticalSpace(16.h),
                  StreamBuilder<SparkShowModel>(
                    stream: vipSparksDetailsApiRx.dataFetcher,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData || snapshot.data == null) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      final model = snapshot.data!;
                      final data = model.data;

                      if (data == null || data.vip == null) {
                        return const SizedBox();
                      }

                      return StreamBuilder<ReminderListModel>(
                        stream: reminderListApiRx.dataFetcher,
                        builder: (context, reminderSnapshot) {
                          String? reminderTime;
                          String? reminderDate;
                          String? reminderId;

                          // Find matching reminder if exists
                          if (reminderSnapshot.hasData &&
                              reminderSnapshot.data?.data != null &&
                              reminderSnapshot.data!.data!.isNotEmpty) {
                            try {
                              final matchingReminder =
                                  reminderSnapshot.data!.data!.firstWhere(
                                (reminder) =>
                                    reminder.sparkId ==
                                    int.parse(widget.id.toString()),
                              );
                              reminderTime = matchingReminder.reminderTime;
                              reminderDate = matchingReminder.reminderDate
                                  .toIso8601String()
                                  .split('T')[0];
                              reminderId = matchingReminder.id.toString();
                            } catch (e) {
                              // No matching reminder found
                            }
                          }

                          return SparkCard(
                            iconCircleColor: const Color(0xFFEB690E),
                            ifButton: true,
                            onTap: () async {
                              final result = await setReminderBottomSheet(
                                context,
                                reminderTime: reminderTime,
                                reminderDate: reminderDate,
                                title: data.title.toString(),
                                image: data.vip?.avatar.toString() ?? "",
                                date: data.formattedDate.toString(),
                                time: data.time.toString(),
                                isEdit: reminderEdit,
                                id: reminderId.toString(),
                              );

                              if (result == true) {
                                reminderListApiRx.reminderListData();
                                ToastUtil.showShortToast(
                                    "Reminder Updated Successfully");
                              }
                            },
                            title: "Remind Me",
                            subTitle:
                                "Set a reminder to receive alerts before this spark.",
                            buttonName: reminderEdit ? "Edit" : "Set",
                            iconName: Icons.notification_important,
                          );
                        },
                      );
                    },
                  ),
                  UIHelper.verticalSpace(12.h),
                  StreamBuilder<ReminderListModel>(
                    stream: reminderListApiRx.dataFetcher,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox.shrink();
                      }

                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            "Error occurred",
                            style: TextFontStyle.textStyle14InterW500,
                          ),
                        );
                      }

                      if (!snapshot.hasData ||
                          snapshot.data?.data == null ||
                          snapshot.data!.data!.isEmpty) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (reminderEdit != false) {
                            setState(() {
                              reminderEdit = false;
                            });
                          }
                        });
                        return const SizedBox.shrink();
                      }

                      final reminders = snapshot.data!.data!;

                      try {
                        final matchingReminder = reminders.firstWhere(
                          (reminder) =>
                              reminder.sparkId ==
                              int.parse(widget.id.toString()),
                        );

                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (reminderEdit != true) {
                            setState(() {
                              reminderEdit = true;
                            });
                          }
                        });

                        final formattedDate =
                            "${matchingReminder.reminderDate.day.toString().padLeft(2, '0')}/"
                            "${matchingReminder.reminderDate.month.toString().padLeft(2, '0')}/"
                            "${matchingReminder.reminderDate.year}";

                        final timeParts =
                            matchingReminder.reminderTime.split(':');
                        final hour = int.parse(timeParts[0]);
                        final minute = timeParts[1];
                        final period = hour >= 12 ? 'PM' : 'AM';
                        final hour12 = hour % 12 == 0 ? 12 : hour % 12;
                        final formattedTime = "$hour12:$minute $period";

                        final String reminderId =
                            matchingReminder.id.toString();

                        return Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2A2A3D),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: ListTile(
                            title: Text(
                              "Reminder set for $formattedDate at $formattedTime",
                              style: TextFontStyle.textStyle14InterW500
                                  .copyWith(color: const Color(0xFF24C776)),
                            ),
                            subtitle: Text(
                              "You’ll be notified about this spark",
                              style: TextFontStyle.textStyle12InterW400
                                  .copyWith(color: Colors.white60),
                            ),
                            trailing: TextButton(
                              onPressed: () async {
                                bool success = await reminderDeleteApiRx
                                    .reminderDelete(id: reminderId);
                                if (success) {
                                  // Refresh reminder list after deletion
                                  reminderListApiRx.reminderListData();
                                  setState(() {
                                    reminderEdit = false;
                                  });
                                }
                              },
                              child: const Text(
                                "Remove",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ),
                        );
                      } catch (e) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (reminderEdit != false) {
                            setState(() {
                              reminderEdit = false;
                            });
                          }
                        });
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                  UIHelper.verticalSpace(16.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
