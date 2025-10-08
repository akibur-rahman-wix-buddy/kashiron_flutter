
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import 'package:kashirons_flutter/common_widgets/custom_text_field.dart';
import 'package:kashirons_flutter/feature/add_vip_profile_part/add_vip_profile_part/widget/Interests_widget.dart';
import 'package:kashirons_flutter/feature/add_vip_profile_part/add_vip_profile_part/widget/basic_Information.dart';
import 'package:kashirons_flutter/feature/add_vip_profile_part/add_vip_profile_part/widget/add_their_location_widget.dart';
import 'package:kashirons_flutter/feature/add_vip_profile_part/add_vip_profile_part/widget/cancel_save_button.dart';
import 'package:kashirons_flutter/feature/add_vip_profile_part/add_vip_profile_part/widget/important_events_widget.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';

class AddVipProfilePartScreen extends StatefulWidget {
  const AddVipProfilePartScreen({super.key});

  @override
  State<AddVipProfilePartScreen> createState() =>
      _AddVipProfilePartScreenState();
}

class _AddVipProfilePartScreenState extends State<AddVipProfilePartScreen> {
  final _profileImage = Rx<XFile?>(null);
  String? selectedRelationship;
  bool isOn = false;
  final TextEditingController searchController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController zipcodeController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController streemController = TextEditingController();
  final GlobalKey _relationshipFieldKey = GlobalKey();
  final _formKey = GlobalKey<FormState>();

  List<String> allRelationships = [
    'Husband',
    'Wife',
    'Father',
    'Mother',
    'Brother',
    'Sister',
    'Son',
    'Daughter',
    'Grandfather',
    'Grandmother',
    'Partner',
    'Boyfriend',
    'Girlfriend',
    'Fiancé',
    'Fiancée',
    'Best Friend',
    'Uncle',
    'Aunt',
    'Nephew',
    'Niece',
    'Father-in-law',
    'Mother-in-law',
    'Colleague',
    'Boss',
    'Business Partner',
    'Mentor',
    'Client',
    'Employee',
    'Friend (general)',
    'Neighbor',
    'Teacher',
    'Doctor',
    'Classmate',
    'Roommate'
  ];
  List<String> filteredRelationships = [];
  //===================================//
  final Map<String, List<String>> categories = const {

    'Lifestyle & Creative': [
      'Fashion/Style',
      'Health & Beauty',
      'Home & Decor',
      'Wellness',
      'Spa',
      'Social Media'
    ],
    'Hobbies & Creative': [
      'Art',
      'DIY',
      'Photography',
      'Music',
      'Dance',
      'Film/TV',
      'Reading',
      'Writing'
    ],
    'Activities & Outdoors': ['Travel', 'Beach', 'Camping', 'Adventure', 'Gardening'],
    'Food & Drink': ['Cooking', 'Coffee/Tea', 'Foodie', 'Wine/Cocktails', 'BBQ/Grilling'],
    'Fitness & Sports': [
      'Fitness',
      'Running',
      'Cycling',
      'Swimming',
      'Yoga',
      'Tennis',
      'Pickleball',
      'Football',
      'Golf',
      'Baseball',
      'Soccer'
    ],
    'Pets': ['Dogs', 'Cats', 'Birds', 'Fish', 'Reptiles', 'Small Pets'],
    'Entertainment & Social': ['Partying', 'Podcasts'],



  };
  @override
  void initState() {
    super.initState();
    filteredRelationships = allRelationships;
    searchController.addListener(_filterRelationships);
  }

  void _filterRelationships() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredRelationships = allRelationships
          .where((relationship) => relationship.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        _profileImage.value = pickedFile;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void _showRelationshipMenu(BuildContext context) {
    final RenderBox? renderBox =
        _relationshipFieldKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    final double popupWidth = size.width;
    final double popupHeight = 200.h;

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + size.height,
        offset.dx + size.width,
        offset.dy + size.height + popupHeight,
      ),
      color: AppColor.c2D3142,
      constraints: BoxConstraints(
        minWidth: popupWidth,
        maxWidth: popupWidth,
        maxHeight: popupHeight,
      ),
      items: [
        PopupMenuItem<String>(
          enabled: false,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              searchController.addListener(() {
                setState(() {
                  _filterRelationships();
                });
              });

              return SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        controller: searchController,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 8.h, horizontal: 16.w),
                        hintText: 'Search relationships...',
                        hintTextSyle:
                            TextFontStyle.textStyle10InterW400.copyWith(
                          color: const Color(0xFF787A83),
                          fontSize: 14.sp,
                        ),
                      ),
                      UIHelper.verticalSpace(14.h),
                      _buildPopupSection(
                          '🏡 Family',
                          [
                            'Husband',
                            'Wife',
                            'Father',
                            'Mother',
                            'Brother',
                            'Sister',
                            'Son',
                            'Daughter',
                            'Grandfather',
                            'Grandmother'
                          ],
                          setState),
                      _buildPopupSection(
                          '❤️ Personal / Close',
                          [
                            'Partner',
                            'Boyfriend',
                            'Girlfriend',
                            'Fiancé',
                            'Fiancée',
                            'Best Friend'
                          ],
                          setState),
                      _buildPopupSection(
                          '👥 Relatives',
                          [
                            'Uncle',
                            'Aunt',
                            'Nephew',
                            'Niece',
                            'Father-in-law',
                            'Mother-in-law'
                          ],
                          setState),
                      _buildPopupSection(
                          '💼 Professional',
                          [
                            'Colleague',
                            'Boss',
                            'Business Partner',
                            'Mentor',
                            'Client',
                            'Employee'
                          ],
                          setState),
                      _buildPopupSection(
                          '🎉 Others',
                          [
                            'Friend (general)',
                            'Neighbor',
                            'Teacher',
                            'Doctor',
                            'Classmate',
                            'Roommate'
                          ],
                          setState),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ).then((value) {
      if (value != null) {
        setState(() {
          selectedRelationship = value;
          searchController.clear();
          filteredRelationships = allRelationships;
        });
      }
    });
  }

  Widget _buildPopupSection(
      String title, List<String> items, StateSetter setState) {
    List<String> filteredItems =
        items.where((item) => filteredRelationships.contains(item)).toList();
    if (filteredItems.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
          decoration: ShapeDecoration(
            color: const Color(0xFF373B4C),
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: Color(0xFF3E4357)),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: TextFontStyle.textStyle10InterW400
                      .copyWith(fontSize: 12.sp, fontWeight: FontWeight.w500)),
              SvgPicture.asset(AppIcons.searchiconcon, height: 20.h),
            ],
          ),
        ),
        UIHelper.verticalSpace(8.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: filteredItems
                .map((item) => GestureDetector(
                      onTap: () {
                        Navigator.pop(context, item);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 7.h),
                        child: Text(
                          item,
                          style: TextFontStyle.textStyle10InterW400
                              .copyWith(fontSize: 14.sp),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.c272A36,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: 80,
        backgroundColor: AppColor.c2D3142,
        title: Row(
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: SvgPicture.asset(AppIcons.arrwlefticon,
                  height: 20.h, width: 20.w),
            ),
            const Spacer(),
            Text('Add VIP Profile',
                style: TextFontStyle.textStyle14InterW500
                    .copyWith(fontSize: 18.sp)),
            const Spacer(),
            SvgPicture.asset(AppIcons.qustionicon),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            children: [
              UIHelper.verticalSpace(15.h),
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Obx(() {
                      return CircleAvatar(
                        radius: 50.r,
                        backgroundColor: AppColor.blackColor.withOpacity(0.2),
                        backgroundImage: _profileImage.value != null
                            ? FileImage(File(_profileImage.value!.path))
                            : null,
                        child: _profileImage.value == null
                            ? Icon(Icons.person,
                                size: 50.r, color: Colors.white)
                            : null,
                      );
                    }),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          Get.bottomSheet(
                            Container(
                              color: AppColor.c0E3E2C,
                              padding: EdgeInsets.all(20.sp),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.back();
                                      _pickImage(ImageSource.camera);
                                    },
                                    child: Text('Take Photo',
                                        style:
                                            TextFontStyle.textStyle10InterW400),
                                  ),
                                  UIHelper.verticalSpace(10.h),
                                  const Divider(color: Colors.grey),
                                  UIHelper.verticalSpace(10.h),
                                  GestureDetector(
                                    onTap: () {
                                      Get.back();
                                      _pickImage(ImageSource.gallery);
                                    },
                                    child: Text('Select from library',
                                        style:
                                            TextFontStyle.textStyle14InterW500),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: SvgPicture.asset(AppIcons.cameraicon),
                      ),
                    ),
                  ],
                ),
              ),
              UIHelper.verticalSpace(8.h),
              Text('Add Photo',
                  textAlign: TextAlign.center,
                  style: TextFontStyle.textStyle14InterW500),
              UIHelper.verticalSpace(2.h),
              Text('Tap to add a profile picture',
                  textAlign: TextAlign.center,
                  style: TextFontStyle.textcA9A9A9Style12InterW400),
              UIHelper.verticalSpace(20.h),

              /// ✅ Replaced container with custom widget
              BasicInformationSection(
                selectedRelationship: selectedRelationship,
                relationshipFieldKey: _relationshipFieldKey,
                onTapRelationship: () => _showRelationshipMenu(context),
              ),

              UIHelper.verticalSpace(20.h),

              ImportantEventsWidget(title: 'Important Events'),


              UIHelper.verticalSpace(20.h),




              AddTheirLocationWidget(
                isOn: isOn,
                streemController: streemController,
                countryController: countryController,
                cityController: cityController,
                zipcodeController: zipcodeController,
                phoneController: phoneController,
                onSwitchChanged: (value) => setState(() => isOn = value),
              ),

              UIHelper.verticalSpace(20.h),

              InterestsWidget(categories: categories),
              UIHelper.verticalSpace(20.h),

              Row(
                children: [
                  Expanded(child: CancelSaveButton(
                      color: AppColor.c373B4C,

                      title: 'Cancel')),
                  UIHelper.horizontalSpace(12.w),

                  Expanded(child: CancelSaveButton(
                      color: AppColor.cA4161A,
                      title: 'Save VIP Profile'))
                ],
              )




            ],
          ),
        ),
      ),
    );
  }
}



