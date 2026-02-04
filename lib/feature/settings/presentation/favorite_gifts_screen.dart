import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import 'package:kashirons_flutter/common_widgets/custom_app_bar.dart';
import 'package:kashirons_flutter/common_widgets/custom_text_field.dart';
import 'package:kashirons_flutter/feature/brobrain_gift_list/widget/product_card.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';
import 'package:kashirons_flutter/networks/api_acess.dart';
import 'package:url_launcher/url_launcher.dart';

class FavoriteGiftsScreen extends StatefulWidget {
  const FavoriteGiftsScreen({super.key});

  @override
  State<FavoriteGiftsScreen> createState() => _FavoriteGiftsScreenState();
}

class _FavoriteGiftsScreenState extends State<FavoriteGiftsScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _searchDebounceTimer;
  String _searchQuery = '';
  bool _isSearching = false;
  List<dynamic>? _allFavoriteItems;
  List<dynamic>? _filteredFavoriteItems;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _loadFavoriteGifts();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _searchDebounceTimer?.cancel();
    super.dispose();
  }

  void _loadFavoriteGifts() {
    setState(() {
      _isLoading = true;
    });
    favoriteGiftsApiRx.favoriteGifts();
  }

  void _onSearchChanged() {
    if (_searchDebounceTimer?.isActive ?? false) {
      _searchDebounceTimer?.cancel();
    }

    _searchDebounceTimer = Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _searchQuery = _searchController.text.trim();
          _isSearching = _searchQuery.isNotEmpty;

          // Filter the items locally based on search query
          if (_allFavoriteItems != null) {
            if (_searchQuery.isEmpty) {
              _filteredFavoriteItems = List.from(_allFavoriteItems!);
            } else {
              _filteredFavoriteItems = _allFavoriteItems!.where((item) {
                final title = item.title?.toString().toLowerCase() ?? '';
                final searchLower = _searchQuery.toLowerCase();
                return title.contains(searchLower);
              }).toList();
            }
          }
        });
      }
    });
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _searchQuery = '';
      _isSearching = false;
      _filteredFavoriteItems =
          _allFavoriteItems != null ? List.from(_allFavoriteItems!) : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryBg,
      body: Column(
        children: [
          /// App Bar
          CustomAppBar(
            title: "Favorite Gifts",
          ),
          UIHelper.verticalSpace(16.h),

          /// Search Field with Clear Button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: _searchController,
                    hintText: "Search for gifts...",
                    leftIcon: AppIcons.search,
                    onChanged: (value) {
                      // The listener will handle the debounce
                    },
                  ),
                ),
                if (_isSearching)
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

          /// Content Section
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Header
                  Text(
                    _isSearching && _searchQuery.isNotEmpty
                        ? "Search Results for: '$_searchQuery'"
                        : "Your Favorite Gifts Items",
                    style: TextFontStyle.textStyle18InterW700,
                  ),
                  UIHelper.verticalSpace(8.h),

                  /// Description (only show when not searching)
                  if (!_isSearching)
                    Column(
                      children: [
                        Text(
                          "All the gifts you've saved from the Brobrain gift lists are displayed here. You can review them anytime and purchase whenever you're ready.",
                          style: TextFontStyle.textStyle14InterW500
                              .copyWith(color: Colors.white60),
                        ),
                        UIHelper.verticalSpace(8.h),
                      ],
                    ),

                  /// Results count
                  if (_filteredFavoriteItems != null)
                    Text(
                      "${_filteredFavoriteItems!.length} item${_filteredFavoriteItems!.length != 1 ? 's' : ''} found",
                      style: TextFontStyle.textStyle12InterW400
                          .copyWith(color: Colors.white70),
                    ),

                  UIHelper.verticalSpace(16.h),

                  /// Favorites Grid
                  Expanded(
                    child: StreamBuilder(
                      stream: favoriteGiftsApiRx.dataFetcher,
                      builder: (context, snapshot) {
                        // Handle different states
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (snapshot.hasError) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  color: Colors.red,
                                  size: 48.r,
                                ),
                                UIHelper.verticalSpace(16.h),
                                Text(
                                  "Failed to load favorite gifts",
                                  style: TextStyle(color: Colors.red),
                                ),
                                UIHelper.verticalSpace(8.h),
                                ElevatedButton(
                                  onPressed: _loadFavoriteGifts,
                                  child: Text("Retry"),
                                ),
                              ],
                            ),
                          );
                        }

                        if (!snapshot.hasData || snapshot.data!.data == null) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        // Store all items and filter if needed
                        if (_allFavoriteItems == null) {
                          _allFavoriteItems = snapshot.data!.data!;
                          _filteredFavoriteItems =
                              List.from(_allFavoriteItems!);
                        }

                        // If we're searching and have a query, use filtered items
                        final displayItems =
                            _isSearching && _searchQuery.isNotEmpty
                                ? _filteredFavoriteItems
                                : _allFavoriteItems;

                        if (displayItems == null || displayItems.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.favorite_border,
                                  size: 64.r,
                                  color: Colors.white60,
                                ),
                                UIHelper.verticalSpace(16.h),
                                Text(
                                  _isSearching && _searchQuery.isNotEmpty
                                      ? "No gifts found for '$_searchQuery'"
                                      : "No favorite gifts yet",
                                  style: TextStyle(
                                    color: Colors.white60,
                                    fontSize: 16.sp,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          );
                        }

                        return GridView.builder(
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.w,
                            mainAxisSpacing: 10.h,
                            childAspectRatio:
                                0.7, // Adjust based on your ProductCard design
                          ),
                          itemCount: displayItems.length,
                          itemBuilder: (context, index) {
                            final data = displayItems![index];

                            return ProductCard(
                              imageUrl: data.images?.isNotEmpty == true
                                  ? data.images![0].url ?? ""
                                  : "",
                              isLoveValue: true,
                              price: data.price?.amount?.toString() ?? "0",
                              productName: data.title ?? "Unnamed Gift",
                              isBuyGiftClick: () async {
                                final url = data.url;
                                if (url == null || url.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text("Product URL not available"),
                                    ),
                                  );
                                  return;
                                }

                                final uri = Uri.parse(url);
                                try {
                                  if (!await launchUrl(
                                    uri,
                                    mode: LaunchMode.externalApplication,
                                  )) {
                                    debugPrint('Could not launch $url');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text("Could not open product link"),
                                      ),
                                    );
                                  }
                                } catch (e) {
                                  debugPrint('Error launching URL: $e');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text("Error opening product link"),
                                    ),
                                  );
                                }
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
