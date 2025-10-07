import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_image.dart';
import 'package:kashirons_flutter/common_widgets/custom_app_bar.dart';
import 'package:kashirons_flutter/common_widgets/custom_shimmer_image.dart';
import 'package:kashirons_flutter/common_widgets/custom_text_field.dart';
import 'package:kashirons_flutter/common_widgets/shimmerClipOverImageWidget.dart';
import 'package:kashirons_flutter/feature/brobrain_gift_list/widget/product_card.dart';
import 'package:kashirons_flutter/feature/settings/presentation/order_history.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';
import 'package:kashirons_flutter/networks/endpoints.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  List<String> category = [ "All","Delivered","Pending"];
  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryBg,
      body: SafeArea(
        child: Column(
          children: [
            /// App Bar
            CustomAppBar(
              title: "Edit Profile",
            ),
            UIHelper.verticalSpace(26.h),
            Column(
              children: [
                shimmerClipOvalWidget(networkImageLink: personImageUrl,  height: 120, weight: 120),
                Positioned(
                    left: 10,
                    bottom: 10 ,
                    child: Container(


                  height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.r),
                      color: Colors.red
                    ),


                    child: Icon(Icons.edit,color: Colors.white,)))
              ],
            ),






          ],
        ),
      ),
    );
  }
}
