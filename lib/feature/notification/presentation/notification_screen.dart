import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_image.dart';
import 'package:kashirons_flutter/common_widgets/custom_app_bar.dart';
import 'package:kashirons_flutter/common_widgets/custom_shimmer_image.dart';
import 'package:kashirons_flutter/feature/notification/model/notification_screen_model.dart';
import 'package:kashirons_flutter/helpers/toast.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';
import 'package:kashirons_flutter/networks/api_acess.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch notifications when screen loads
    notificationScreenApiRx.getNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryBg,
      body: Column(
        children: [
          const CustomAppBar(
            title: "Notification",
          ),
          UIHelper.verticalSpace(8.h),
          Expanded(
            child: StreamBuilder<NotificationScreenModel>(
              stream: notificationScreenApiRx.dataFetcher,
              builder: (context, snapshot) {
                // Loading state
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                }

                // Error state
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Failed to load notifications",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                    ),
                  );
                }

                // Empty state
                if (!snapshot.hasData ||
                    snapshot.data == null ||
                    snapshot.data!.data == null ||
                    snapshot.data!.data!.groups == null ||
                    snapshot.data!.data!.groups!.isEmpty) {
                  return Center(
                    child: Text(
                      "No notifications found",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                    ),
                  );
                }

                final groups = snapshot.data!.data!.groups!;

                return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: groups.length,
                  itemBuilder: (context, sectionIndex) {
                    final group = groups[sectionIndex];
                    final items = group.items ?? [];

                    if (items.isEmpty) {
                      return const SizedBox.shrink();
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Section Header
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 8.h),
                          child: Row(
                            children: [
                              Text(
                                group.title ?? "Notifications",
                                style:
                                    TextFontStyle.textStyle18InterW700.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              UIHelper.horizontalSpace(25.w),
                              Expanded(
                                child: Divider(
                                  height: 2.h,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Section Items
                        ...items.map((item) {
                          return GestureDetector(
                            onTap: () async {
                              final success = await notificationToggleApiRx
                                  .notificationToggle(id: item.id.toString());

                              if (!success) return;

                              final model = notificationScreenApiRx.current;
                              if (model == null) return;

                              for (final group in model.data!.groups!) {
                                for (final i in group.items!) {
                                  if (i.id == item.id) {
                                    i.isUnread = false; // or toggle
                                  }
                                }
                              }

                              notificationScreenApiRx.emit(model);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: item.isUnread == false
                                      ? null
                                      : AppColor.c2D3142,
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(
                                    color: AppColor.c414762,
                                  )),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 4.h),
                              child: Padding(
                                padding: EdgeInsets.all(16.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            _getTitle(item),
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        if (item.timeLabel != null &&
                                            item.timeLabel!.isNotEmpty)
                                          Text(
                                            item.timeLabel!,
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              color: Colors.white54,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                      ],
                                    ),

                                    SizedBox(height: 8.h),

                                    // Category Badge
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.w, vertical: 2.h),
                                          decoration: BoxDecoration(
                                            color: Colors.blue.withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(4.r),
                                          ),
                                          child: Text(
                                            _getCategory(item),
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        if (item.isUnread == true)
                                          CircleAvatar(
                                            radius: 5.r,
                                            backgroundColor: Colors.red,
                                          ),
                                      ],
                                    ),

                                    SizedBox(height: 8.h),

                                    // Description
                                    Text(
                                      _getMessage(item),
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.white54,
                                        height: 1.4,
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
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

  String _getTitle(Item item) {
    if (item.title != null) {
      return item.title!.name;
    }
    return "Notification";
  }

  String _getMessage(Item item) {
    if (item.message != null) {
      return item.message!.name;
    }
    return "No description available";
  }

  String _getCategory(Item item) {
    if (item.category != null) {
      return item.category!.name;
    }
    return "General";
  }
}

// // Enum extensions
// extension TitleExtension on Title {
//   String get name {
//     switch (this) {
//       case Title.HELLO_THIS_IS_REMINDER:
//         return "Hello This is Reminder.";
//       case Title.VJGVHUJG_HJ_GHFG_F_GFG:
//         return "vjgvhujg hj ghfg f gfg";
//       case Title.WIFE_SELECTED:
//         return "Wife Selected";
//       case Title.NEW_REMINDER:
//         return "NEW Reminder";
//       case Title.UNKNOWN:
//         return "Notification";
//     }
//   }
// }

extension MessageExtension on Message {
  String get name {
    switch (this) {
      case Message.FGYHFG_GFJH_FGFH_FGFH_VFGF_GHFG_HG_HG_H:
        return "fgyhfg gfjh fgfh fgfh vfgf ghfg hg hg h";
      case Message.THIS_VIP_FOR_DESCRIPTION:
        return "This VIP for Description ....";
      case Message.TITLE_DESCRIPTION:
        return "Title description";
      case Message.NEW_REMINDER:
        return "New reminder";
      case Message.REMINDER_DESCRIPTION:
        return "Reminder description";
      case Message.UNKNOWN:
        return "";
    }
  }
}

extension CategoryExtension on Category {
  String get name {
    switch (this) {
      case Category.SPARK:
        return "Spark";
      case Category.SELF_CARE:
        return "Self-Care";
      case Category.UNKNOWN:
        return "General";
    }
  }
}
