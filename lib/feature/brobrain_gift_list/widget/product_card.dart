import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_image.dart';
import 'package:kashirons_flutter/helpers/all_routes.dart';
import 'package:kashirons_flutter/helpers/navigation_service.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key, required this.productName, required this.price, required this.isLoveValue, required this.isBuyGiftClick});
  final String productName;
  final String price;
  final bool isLoveValue ;
  final VoidCallback isBuyGiftClick;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {


  late bool isLove ;

 @override
  void initState() {

   isLove = widget.isLoveValue;

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        NavigationService.navigateTo(Routes.productDetailScreen);
      },
      child: Padding(padding: EdgeInsets.only(right: 16), child: Container(
        width: 140.w,
        height: 240.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColor.authBg,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  child: Image.asset(AppImages.demoItem, height: 120.h, width: double.infinity, fit: BoxFit.cover,),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                ),
                Positioned(

                  right: 10,
                  top: 20,

                  child: Container(
                    decoration: BoxDecoration(

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          spreadRadius: 5
                        )
                      ]
                    ),
                    child: GestureDetector(
                        onTap: (){
                          setState(() {
                            isLove=!isLove;
                          });
                        },
                        child: Icon(isLove? Icons.favorite:Icons.favorite_border,color: isLove?Colors.red:Colors.white, )),
                  ),
                )
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UIHelper.verticalSpace(10.h),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      widget.productName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextFontStyle.textStyle16InterW400.copyWith(
                          fontSize: 14.sp,fontWeight: FontWeight.w500,
                          color: AppColor.cFFFFFF
                      ),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      widget.price,
                      style: TextFontStyle.textStyle16InterW400.copyWith(
                          fontSize: 14.sp,fontWeight: FontWeight.w500,
                          color: Color(0xffEF233C)
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: ElevatedButton(
                      onPressed: widget.isBuyGiftClick,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff373c51),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        minimumSize: Size(double.infinity, 34.h),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppIcons.gift,
                            height: 14.h,
                            width: 14.w,
                          ),
                          UIHelper.horizontalSpace(4.w),
                          Text(
                            "Buy Gift",
                            style: TextFontStyle.textStyle16InterW400.copyWith(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColor.cEDEDED,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  UIHelper.verticalSpace(10.h),
                ],
              ),
            )
          ],
        ),
      ),),
    );;
  }
}
