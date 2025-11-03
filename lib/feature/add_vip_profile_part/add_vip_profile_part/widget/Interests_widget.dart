import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import 'package:kashirons_flutter/common_widgets/custom_text_field.dart';
import 'package:kashirons_flutter/feature/add_vip_profile_part/add_vip_profile_part/widget/button_widget.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';

/// Custom Widget for Interest Selection
class InterestsWidget extends StatefulWidget {
  final Map<String, List<String>> categories;

  const InterestsWidget({super.key, required this.categories});

  @override
  State<InterestsWidget> createState() => _InterestsWidgetState();
}

class _InterestsWidgetState extends State<InterestsWidget> {
  bool showAll = true;
  String searchQuery = '';
  int selectedCount = 0;

  final TextEditingController searchController = TextEditingController();
  final Set<String> selectedItems = {};

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {
        searchQuery = searchController.text.toLowerCase();
      });
    });
  }

  List<String> _getFilteredItems(String category) {
    if (searchQuery.isEmpty) {
      return widget.categories[category]!;
    } else {
      return widget.categories[category]!
          .where((item) => item.toLowerCase().contains(searchQuery))
          .toList();
    }
  }

  List<String> _getAllFilteredItems() {
    List<String> allItems = [];
    widget.categories.forEach((key, value) {
      allItems.addAll(_getFilteredItems(key));
    });
    return allItems;
  }

  Widget _buildCategory(String category) {
    if (!showAll) return const SizedBox.shrink();

    final items = _getFilteredItems(category);
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category,
          style: TextFontStyle.textStyle12InterW400
              .copyWith(fontSize: 16.sp, fontWeight: FontWeight.w500),
        ),
        UIHelper.verticalSpace(8.h),
        Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: items
              .map(
                (item) => ButtonWidget(
              title: item,
              isSelected: selectedItems.contains(item),
              onTap: () {
                setState(() {
                  if (selectedItems.contains(item)) {
                    selectedItems.remove(item);
                  } else {
                    selectedItems.add(item);
                  }
                  selectedCount = selectedItems.length;
                });
              },
            ),
          )
              .toList(),
        ),
        UIHelper.verticalSpace(16.h),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final allItems = _getAllFilteredItems();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Interests',
          style: TextFontStyle.textStyle10InterW400.copyWith(
            color: const Color(0xFFEDEDED),
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        UIHelper.verticalSpace(8.h),
        Text(
          '$selectedCount selected',
          style: TextFontStyle.textStyle10InterW400.copyWith(
            color: const Color(0xFF787A83),
            fontSize: 12,
          ),
        ),
        UIHelper.verticalSpace(16.h),
        CustomTextField(
          controller: searchController,
          contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
          hintText: 'Search interests...',
          hintTextSyle: TextFontStyle.textStyle14InterW400c787A83,
          leftIcon: AppIcons.searchicon,
        ),
        UIHelper.verticalSpace(16.h),
        GestureDetector(
          onTap: () {
            setState(() {
              showAll = !showAll;
            });
          },
          child: Text(
            showAll ? 'Show All' : 'Show by Category',
            style: TextStyle(
              color: const Color(0xFFEF233C),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        UIHelper.verticalSpace(16.h),
        if (showAll)
          ...widget.categories.keys.map((cat) => _buildCategory(cat)).toList()
        else
          Wrap(
            spacing: 10.w,
            runSpacing: 10.h,
            children: allItems
                .map(
                  (item) => ButtonWidget(
                title: item,
                isSelected: selectedItems.contains(item),
                onTap: () {
                  setState(() {
                    if (selectedItems.contains(item)) {
                      selectedItems.remove(item);
                    } else {
                      selectedItems.add(item);
                    }
                    selectedCount = selectedItems.length;
                  });
                },
              ),
            )
                .toList(),
          ),
      ],
    );
  }
}
