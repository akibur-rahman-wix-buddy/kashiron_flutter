import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_image.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';
import 'package:shimmer/shimmer.dart';

class SparkProductCard extends StatefulWidget {
  final String title;
  final double price;
  final String image;
  final VoidCallback onBuyTap;

  const SparkProductCard({
    Key? key,
    required this.title,
    required this.price,
    required this.image,
    required this.onBuyTap,
  }) : super(key: key);

  @override
  State<SparkProductCard> createState() => _SparkProductCardState();
}

class _SparkProductCardState extends State<SparkProductCard> {
  bool isFavorite = false;



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColor.authBg,
      ),
      clipBehavior: Clip.hardEdge, // ensures image respects radius
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              // Image
              ShimmerImage(
                imageUrl: widget.image,
                placeholder: AppImages.placeholderImageItem,
                height: 120.h,
                width: double.infinity,
                borderRadius: 8,
              ),

              // Favorite icon
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      isFavorite =!isFavorite;
                    });
                  },
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color(0x661F1F1F),
                      shape: BoxShape.circle, // make it circular
                    ),
                    child: Center(
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.white,
                        size: 20, // adjust icon size
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextFontStyle.textStyle16InterW400.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColor.cFFFFFF,
                    ),
                  ),
                  Text(
                    "\$${widget.price}",
                    style: TextFontStyle.textStyle16InterW400.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xffEF233C),
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.onBuyTap,
                    child: Container(
                      height: 34.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xff373c51),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AppIcons.gift, height: 14.h, width: 14.w),
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
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}




class ShimmerImage extends StatelessWidget {
  final String imageUrl;
  final String placeholder;
  final double height;
  final double width;
  final double borderRadius;

  const ShimmerImage({
    super.key,
    required this.imageUrl,
    required this.placeholder,
    required this.height,
    required this.width,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        height: height,
        width: width,
        fit: BoxFit.cover,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey.shade400,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: height,
            width: width,
            color: Colors.white,
          ),
        ),
        errorWidget: (context, url, error) => Image.asset(
          placeholder,
          height: height,
          width: width,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

