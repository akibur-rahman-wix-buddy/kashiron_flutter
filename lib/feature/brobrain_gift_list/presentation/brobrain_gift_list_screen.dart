import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import 'package:kashirons_flutter/common_widgets/custom_app_bar.dart';
import 'package:kashirons_flutter/common_widgets/custom_text_field.dart';
import 'package:kashirons_flutter/feature/brobrain_gift_list/model/popular_products_model.dart';
import 'package:kashirons_flutter/feature/brobrain_gift_list/widget/product_card.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';
import 'package:kashirons_flutter/networks/api_acess.dart';
import 'package:url_launcher/url_launcher.dart';

class BrobrainGiftListScreen extends StatefulWidget {
  const BrobrainGiftListScreen({super.key});

  @override
  State<BrobrainGiftListScreen> createState() => _BrobrainGiftListScreenState();
}

class _BrobrainGiftListScreenState extends State<BrobrainGiftListScreen> {
  List<String> list = ["Most Popular", "For Woman", "For Man", "For Baby"];
  List<String> keyword = ["", "Woman", "Man", "Baby"];

  int selectedIndex = 0;
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  bool isSearching = false;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    searchController.addListener(_onSearchChanged);
    popularProductsApiRx.popularProducts();
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer?.cancel();
    }

    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          searchQuery = searchController.text.trim();
          isSearching = searchQuery.isNotEmpty;
        });

        // If user is typing in search, trigger search API
        if (searchQuery.isNotEmpty) {
          searchProductApiRx.searchProduct(searchQuery);
        } else {
          // If search is cleared, show regular content based on selected category
          if (selectedIndex == 0) {
            popularProductsApiRx.popularProducts();
          } else {
            searchProductApiRx.searchProduct(keyword[selectedIndex]);
          }
        }
      }
    });
  }

  void _onCategorySelected(int index) {
    setState(() {
      selectedIndex = index;
      // Clear search when category is selected
      if (searchController.text.isNotEmpty) {
        searchController.clear();
        searchQuery = '';
        isSearching = false;
      }
    });

    if (selectedIndex == 0) {
      popularProductsApiRx.popularProducts();
    } else {
      searchProductApiRx.searchProduct(keyword[selectedIndex]);
    }
  }

  void _clearSearch() {
    setState(() {
      searchController.clear();
      searchQuery = '';
      isSearching = false;
    });

    // Restore to default view based on selected category
    if (selectedIndex == 0) {
      popularProductsApiRx.popularProducts();
    } else {
      searchProductApiRx.searchProduct(keyword[selectedIndex]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryBg,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(
            title: "Brobrain Giftlist",
          ),
          UIHelper.verticalSpace(16.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: searchController,
                    hintText: "Search for gifts...",
                    leftIcon: AppIcons.search,
                  ),
                ),
                if (isSearching)
                  Padding(
                    padding: EdgeInsets.only(left: 8.w),
                    child: IconButton(
                      onPressed: _clearSearch,
                      icon: Icon(
                        Icons.clear,
                        color: Colors.grey,
                        size: 24.r,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          UIHelper.verticalSpace(16.h),

          if (isSearching)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  Text(
                    "Search Results for: $searchQuery",
                    style: TextFontStyle.textStyle12InterW400.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  UIHelper.verticalSpace(16.h),
                ],
              ),
            )
          else
            SizedBox(
              height: 45.h,
              child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(5.h),
                    child: ElevatedButton(
                      onPressed: () => _onCategorySelected(index),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedIndex == index
                            ? AppColor.c42475B
                            : const Color(0xFF2D3142),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            color: selectedIndex == index
                                ? AppColor.c525A77
                                : const Color(0xFF32374C),
                          ),
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 7.h,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          list[index],
                          style: TextFontStyle.textStyle12InterW400,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

          if (!isSearching) UIHelper.verticalSpace(20.h),

          if (!isSearching)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                list[selectedIndex],
                style: TextFontStyle.textStyle12InterW400.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

          if (!isSearching) UIHelper.verticalSpace(16.h),

          /// Products Grid - Shows search results OR category products
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: _buildProductGrid(),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildProductGrid() {
    if (isSearching) {
      return StreamBuilder(
        stream: searchProductApiRx.dataFetcher,
        builder: (context, snapshot) {
          return _buildGridView(snapshot);
        },
      );
    } else {
      if (selectedIndex == 0) {
        return StreamBuilder<PopularProductsModel>(
          stream: popularProductsApiRx.dataFetcher,
          builder: (context, snapshot) {
            return _buildGridView(snapshot);
          },
        );
      } else {
        return StreamBuilder(
          stream: searchProductApiRx.dataFetcher,
          builder: (context, snapshot) {
            return _buildGridView(snapshot);
          },
        );
      }
    }
  }

  Widget _buildGridView(AsyncSnapshot snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }

    if (snapshot.hasError) {
      return const Center(
        child: Text(
          "Something went wrong!",
          style: TextStyle(color: Colors.red),
        ),
      );
    }

    final products = snapshot.data?.data;
    if (products == null || products.isEmpty) {
      return Center(
        child: Text(
          isSearching
              ? "No results found for '$searchQuery'"
              : "No products found",
        ),
      );
    }

    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
        childAspectRatio: 0.7,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final item = products[index];

        return ProductCard(
          id: item.id.toString(),
          imageUrl: item.mainImage ?? "",
          isLoveValue: item.isFavourite ?? false,
          price: item.price?.amount?.toString() ?? "0",
          productName: item.title ?? "",
          isBuyGiftClick: () async {
            final url = item.url;
            if (url == null || url.isEmpty) return;

            final uri = Uri.parse(url);
            if (!await launchUrl(
              uri,
              mode: LaunchMode.externalApplication,
            )) {
              debugPrint('Could not launch $url');
            }
          },
        );
      },
    );
  }
}
