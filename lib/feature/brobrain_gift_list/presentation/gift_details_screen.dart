import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_image.dart';
import 'package:kashirons_flutter/common_widgets/custom_app_bar.dart';
import 'package:kashirons_flutter/common_widgets/custom_shimmer_image.dart';
import 'package:kashirons_flutter/common_widgets/expandabl_text.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';
import 'package:kashirons_flutter/common_widgets/custom_elevated_button.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;
  bool _isExpanded = false; // Track if description is expanded
  bool _isFavorited = false; // Track wishlist state
  String selectedImage = AppImages.demoAvatar;

  /// Demo product images
  final List<String> productImages = [
    AppImages.demoAvatar,
    AppImages.placeholderImageItem,
    AppImages.demoAvatar,
    AppImages.placeholderImageItem,
    AppImages.demoAvatar,
  ];

  /// Product description
  final String description =
      "Stay connected and active with this stylish Smart Watch. Track fitness, monitor heart rate and sleep, get notifications, and customize watch faces. Perfect for tech enthusiasts or anyone wanting to stay organized, healthy, and connected effortlessly. Stay connected and active with this stylish Smart Watch. Track fitness, monitor heart rate and sleep, get notifications, and customize watch faces. Perfect for tech enthusiasts or anyone wanting to stay organized, healthy, and connected effortlessly.";

  /// Price per item
  final double pricePerItem = 26.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryBg,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: Container(
        padding: EdgeInsets.all(16.w),
        margin: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          color: const Color(0xFF141824),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$quantity item${quantity == 1 ? '' : 's'}",
                      style: TextFontStyle.textStyle12InterW400,
                    ),
                    Text(
                      "\$${(pricePerItem * quantity).toStringAsFixed(2)}",
                      style: TextFontStyle.textStyle18InterW700,
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: quantity > 1
                          ? () {
                        setState(() {
                          quantity--;
                        });
                      }
                          : null,
                      icon: Icon(
                        Icons.remove_circle_outline,
                        color: quantity > 1 ? Colors.white : Colors.white54,
                      ),
                    ),
                    Text(
                      "$quantity",
                      style: TextStyle(fontSize: 16.sp, color: Colors.white),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                      },
                      icon: const Icon(
                        Icons.add_circle_outline,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            UIHelper.verticalSpace(16.h),
            CustomElevatedButton(
              text: "Buy Now \$${(
                  pricePerItem * quantity).toStringAsFixed(2)}",

              onPressed: () {
                if (quantity > 0) {
                  // Implement payment logic here
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Proceeding to payment...")),
                  );
                }
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(
                title: "Gift Details",
              ),
              Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(8.w),
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
                          /// Main product image
                          ShimmerImage(
                            imageUrl: selectedImage,
                            placeholder: AppImages.placeholderImageItem,
                            height: 200.h,
                            width: double.infinity,
                          ),
                          UIHelper.verticalSpace(12.h),
                
                          /// Product thumbnails
                          SizedBox(
                            height: 90.h,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: productImages.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedImage = productImages[index];
                                    });
                                  },
                                  child: _buildThumbnail(
                                    productImages[index],
                                    isSelected: selectedImage == productImages[index],
                                  ),
                                );
                              },
                            ),
                          ),
                          UIHelper.verticalSpace(16.h),
                
                          /// Product Title + Wishlist
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Smart Popular Watch",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isFavorited = !_isFavorited;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        _isFavorited
                                            ? "Added to wishlist"
                                            : "Removed from wishlist",
                                      ),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  _isFavorited
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: _isFavorited ? Colors.red : Colors.white,
                                ),
                              ),
                            ],
                          ),
                
                          /// Price
                          Text(
                            "\$${pricePerItem.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          UIHelper.verticalSpace(8.h),
                
                          /// Description with See More/See Less


                          ExpandableText(text: description,
                          trimLength: 150,),


                          // description.length > 150
                          //     ? Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     Text(
                          //       _isExpanded
                          //           ? description
                          //           : '${description.substring(0, 150)}...',
                          //       style: TextStyle(
                          //         fontSize: 14.sp,
                          //         color: Colors.white70,
                          //         height: 1.4,
                          //       ),
                          //     ),
                          //     TextButton(
                          //       onPressed: () {
                          //         setState(() {
                          //           _isExpanded = !_isExpanded;
                          //         });
                          //       },
                          //       child: Text(
                          //         _isExpanded ? "See Less" : "See More",
                          //         style: TextStyle(
                          //           color: Colors.red,
                          //           fontSize: 14.sp,
                          //           fontWeight: FontWeight.bold,
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // )
                          //     : Text(
                          //   description,
                          //   style: TextStyle(
                          //     fontSize: 14.sp,
                          //     color: Colors.white70,
                          //     height: 1.4,
                          //   ),
                          // ),
                          UIHelper.verticalSpace(16.h),
                        ],
                      ),
                    ),
                    UIHelper.verticalSpace(150.h), // Adjusted for floatingActionButton
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThumbnail(String path, {bool isSelected = false}) {
    return Container(
      margin: EdgeInsets.only(right: 8.w),
      padding: isSelected ? EdgeInsets.all(3.w) : EdgeInsets.zero,
      decoration: BoxDecoration(
        border: isSelected ? Border.all(color: Colors.red, width: 2.w) : null,
        borderRadius: BorderRadius.circular(8.r),
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        path,
        width: 90.w,
        fit: BoxFit.cover,
      ),
    );
  }
}