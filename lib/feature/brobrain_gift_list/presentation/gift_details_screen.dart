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
import 'package:kashirons_flutter/networks/api_acess.dart';

class ProductDetailScreen extends StatefulWidget {
  final String id;
  const ProductDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;
  bool _isFavorited = false;
  String? selectedImage;
  List<String> productImages = [];

  @override
  void initState() {
    super.initState();
    giftDetailsApiRx.getGiftDetails(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryBg,
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: Container(
        padding: EdgeInsets.all(16.w),
        margin: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          color: const Color(0xFF141824),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: StreamBuilder(
          stream: giftDetailsApiRx.dataFetcher,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                !snapshot.hasData) {
              return const SizedBox.shrink();
            }

            return CustomElevatedButton(
              text: "Buy Now \$${snapshot.data?.data?.price}",
              onPressed: () {
                if (quantity > 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Proceeding to payment...")),
                  );
                }
              },
            );
          },
        ),
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: giftDetailsApiRx.dataFetcher,
          builder: (context, snapshot) {
            // Loading state
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                children: [
                  CustomAppBar(
                    title: "Gift Details",
                  ),
                  UIHelper.verticalSpace(16.h),
                  Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            }

            if (snapshot.hasError || !snapshot.hasData) {
              return Column(
                children: [
                  CustomAppBar(
                    title: "Gift Details",
                  ),
                  UIHelper.verticalSpace(16.h),
                  Center(
                    child: Text(
                      "Failed to load product details",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              );
            }

            final data = snapshot.data!.data;
            if (data == null) {
              return Column(
                children: [
                  CustomAppBar(
                    title: "Gift Details",
                  ),
                  UIHelper.verticalSpace(16.h),
                  Center(
                    child: Text(
                      "No product data available",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              );
            }

            final mainImage =
                data.primaryImage?.imageUrl ?? AppImages.placeholderImageItem;

            final thumbnailImages = <String>[];
            for (final img in data.images ?? []) {
              if (img.imageUrl != null &&
                  img.imageUrl!.isNotEmpty &&
                  img.imageUrl != mainImage) {
                thumbnailImages.add(img.imageUrl!);
              }
            }

            if (selectedImage == null) {
              selectedImage = mainImage;
            }

            return SingleChildScrollView(
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
                                imageUrl: selectedImage ?? mainImage,
                                placeholder: AppImages.placeholderImageItem,
                                height: 200.h,
                                width: double.infinity,
                              ),
                              UIHelper.verticalSpace(12.h),

                              if (thumbnailImages.isNotEmpty)
                                SizedBox(
                                  height: 90.h,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: thumbnailImages.length,
                                    itemBuilder: (context, index) {
                                      final imageUrl = thumbnailImages[index];
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedImage = imageUrl;
                                          });
                                        },
                                        child: _buildThumbnail(
                                          imageUrl,
                                          isSelected: selectedImage == imageUrl,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              if (thumbnailImages.isNotEmpty)
                                UIHelper.verticalSpace(16.h),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      data.title ?? "No Title",
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _isFavorited = !_isFavorited;
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
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
                                      color: _isFavorited
                                          ? Colors.red
                                          : Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              UIHelper.verticalSpace(4.h),
                              Text(
                                "\$${data.price ?? "0.00"}",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                              UIHelper.verticalSpace(8.h),

                              if (data.shortDescription != null &&
                                  data.shortDescription!.isNotEmpty)
                                ExpandableText(
                                  text: data.shortDescription!,
                                  trimLength: 150,
                                ),
                              UIHelper.verticalSpace(16.h),
                            ],
                          ),
                        ),
                        UIHelper.verticalSpace(150.h),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildThumbnail(String imageUrl, {bool isSelected = false}) {
    return Container(
      margin: EdgeInsets.only(right: 8.w),
      padding: isSelected ? EdgeInsets.all(3.w) : EdgeInsets.zero,
      decoration: BoxDecoration(
        border: isSelected ? Border.all(color: Colors.red, width: 2.w) : null,
        borderRadius: BorderRadius.circular(8.r),
      ),
      clipBehavior: Clip.antiAlias,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: ShimmerImage(
          imageUrl: imageUrl,
          placeholder: AppImages.placeholderImageItem,
          width: 90.w,
          height: 90.h,
        ),
      ),
    );
  }
}
