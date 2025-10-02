import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_image.dart';
import 'package:kashirons_flutter/feature/brobrain_gift_list/widget/product_card.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';
import '../../../assets_helperfdg/app_fonts.dart';



class PopularGifts extends StatelessWidget {
  const PopularGifts({
    super.key, required this.title, required this.value, required this.isLove,
  });

  final String title;
  final String value;
  final bool isLove;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 232.h,
      child: ListView.builder(
        itemCount: 4,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {

          return ProductCard(isLoveValue: false,price: 250.toString(),productName: "Smart Watch", isBuyGiftClick: () {  },);
          ;
        },
      ),
    );
  }
}