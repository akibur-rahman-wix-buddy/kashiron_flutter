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
import 'package:kashirons_flutter/feature/add_vip_profile_part/add_vip_profile_part/model/relation_vip_data_model.dart';
import 'package:kashirons_flutter/feature/add_vip_profile_part/add_vip_profile_part/model/vip_category_data_model.dart';
import 'package:kashirons_flutter/feature/vip_profile/model/vip_profile_model.dart';
import 'package:kashirons_flutter/helpers/navigation_service.dart';
import 'package:kashirons_flutter/helpers/toast.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';
import 'package:kashirons_flutter/networks/api_acess.dart';

class AddVipProfilePartScreen extends StatefulWidget {
  final bool isEdit;
  final VipDataInfo? data;

  const AddVipProfilePartScreen({super.key, required this.isEdit, this.data});

  @override
  State<AddVipProfilePartScreen> createState() =>
      _AddVipProfilePartScreenState();
}

class _AddVipProfilePartScreenState extends State<AddVipProfilePartScreen> {
  final _profileImage = Rx<XFile?>(null);
  String? selectedRelationship;
  int? selectedRelationshipId;
  bool isOn = false;

  // All controllers
  final TextEditingController searchController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController zipcodeController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController streetAddressController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController anniversaryController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController specialNoteController = TextEditingController();

  final GlobalKey _relationshipFieldKey = GlobalKey();
  final _formKey = GlobalKey<FormState>();

  List<RelationShipData>? relationshipCategories;
  List<Relations> allRelations = [];
  List<Relations> filteredRelations = [];
  bool isLoadingRelationships = true;
  bool isLoadingCategories = true;
  String? errorMessage;

  Map<String, List<Interests>> categories = {};
  List<dynamic> selectedInterestIds = [];

  // Base URL for images
  final String baseImageUrl = "https://admin.brobrainapp.com/";

  @override
  void initState() {
    super.initState();
    _loadRelationshipData();
    _loadVipCategoryData();
    _initializeData();

    print(">>>>>>>> isEdit: ${widget.isEdit}");
    print(">>>>>>>> Data name: ${widget.data?.name.toString()}");

    if (widget.isEdit == false) {
      widget.data == null;
    }

    searchController.addListener(_filterRelationships);
  }

  void _initializeData() {
    if (widget.data != null && widget.data!.selectedInterest.isNotEmpty) {
      selectedInterestIds =
          widget.data!.selectedInterest.map((e) => e.id).toList();
      print(">>>>>>>> selectedInterestIds: $selectedInterestIds");
    }

    if (widget.data?.name != null && widget.data!.name.isNotEmpty) {
      firstNameController.text = widget.data!.name;
    }
    if (widget.data?.relation.name != null &&
        widget.data!.relation.name.isNotEmpty) {
      selectedRelationship = widget.data!.relation.name;
    }
    if (widget.data?.relation.id != null) {
      selectedRelationshipId = widget.data!.relation.id;
    }
    if (widget.data?.anniversaryDate != null &&
        widget.data!.anniversaryDate!.isNotEmpty) {
      anniversaryController.text = widget.data!.anniversaryDate!;
    }
    if (widget.data?.birthday != null && widget.data!.birthday.isNotEmpty) {
      birthdayController.text = widget.data!.dateOfBirth!;
    }
    if (widget.data?.specialNotes != null &&
        widget.data!.specialNotes.isNotEmpty) {
      specialNoteController.text = widget.data!.specialNotes;
    }
    if (widget.data?.streetAddress != null &&
        widget.data!.streetAddress!.isNotEmpty) {
      streetAddressController.text = widget.data!.streetAddress!;
    }
    if (widget.data?.country != null && widget.data!.country!.isNotEmpty) {
      countryController.text = widget.data!.country!;
    }
    if (widget.data?.city != null && widget.data!.city!.isNotEmpty) {
      cityController.text = widget.data!.city!;
    }
    if (widget.data?.zipCode != null && widget.data!.zipCode!.isNotEmpty) {
      zipcodeController.text = widget.data!.zipCode!;
    }
    if (widget.data?.phone != null && widget.data!.phone!.isNotEmpty) {
      phoneController.text = widget.data!.phone!;
    }
  }

  Future<void> _loadRelationshipData() async {
    setState(() {
      isLoadingRelationships = true;
      errorMessage = null;
    });

    try {
      final data = await getVipRelationshipRx.getPeopleData();
      if (data != null && data.data != null) {
        setState(() {
          relationshipCategories = data.data!;
          allRelations = relationshipCategories!
              .expand<Relations>(
                  (category) => category.relations ?? <Relations>[])
              .where((relation) =>
                  relation.name != null && relation.name!.isNotEmpty)
              .toList();
          filteredRelations = allRelations;
          isLoadingRelationships = false;
        });
      } else {
        setState(() {
          isLoadingRelationships = false;
          errorMessage = 'Failed to load relationships';
        });
      }
    } catch (error) {
      setState(() {
        isLoadingRelationships = false;
        errorMessage = 'Error loading relationships: $error';
      });
    }
  }

  Future<void> _loadVipCategoryData() async {
    setState(() {
      isLoadingCategories = true;
      errorMessage = null;
    });

    try {
      final result = await getVipCategoryRx.getPeopleData();

      if (result != null && result.success == true && result.data != null) {
        setState(() {
          categories = _convertToCategoriesMap(result.data!);
          isLoadingCategories = false;
        });

        // Initialize selected interests after categories are loaded
        _initializeSelectedInterestsFromData();
      } else {
        setState(() {
          errorMessage = result?.message ?? 'Failed to load categories';
          isLoadingCategories = false;
        });
      }
    } catch (error) {
      setState(() {
        errorMessage = 'Error loading categories: $error';
        isLoadingCategories = false;
      });
    }
  }

  void _initializeSelectedInterestsFromData() {
    if (widget.data != null &&
        widget.data!.selectedInterest.isNotEmpty &&
        categories.isNotEmpty) {
      List<dynamic> validIds = [];

      categories.forEach((category, interests) {
        for (var interest in interests) {
          if (widget.data!.selectedInterest
              .any((selected) => selected.id == interest.id)) {
            validIds.add(interest.id);
          }
        }
      });

      if (validIds.isNotEmpty) {
        setState(() {
          selectedInterestIds = validIds;
        });
      }
    }
  }

  Map<String, List<Interests>> _convertToCategoriesMap(List<Data> dataList) {
    final Map<String, List<Interests>> result = {};

    for (final data in dataList) {
      if (data.category != null && data.interests != null) {
        final interestObjects = data.interests!
            .where((interest) => interest.name != null && interest.id != null)
            .toList();

        if (interestObjects.isNotEmpty) {
          result[data.category!] = interestObjects;
        }
      }
    }

    return result;
  }

  void _filterRelationships() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredRelations = allRelations
          .where((relation) => relation.name!.toLowerCase().contains(query))
          .toList();
    });
  }

  void _onRelationshipSelected(String name, int id) {
    setState(() {
      selectedRelationship = name;
      selectedRelationshipId = id;
    });
  }

  void _onInterestSelected(List<dynamic> selectedIds) {
    setState(() {
      selectedInterestIds = selectedIds;
    });
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
                      if (relationshipCategories != null)
                        ...relationshipCategories!.map((category) {
                          String emoji = '•';
                          switch (category.category?.name) {
                            case 'Family':
                              emoji = '🏡';
                              break;
                            case 'Personal / Close':
                              emoji = '❤️';
                              break;
                            case 'Relatives':
                              emoji = '👥';
                              break;
                            case 'Professional':
                              emoji = '💼';
                              break;
                            case 'Others':
                              emoji = '🎉';
                              break;
                            default:
                              emoji = '•';
                          }
                          return _buildPopupSection(
                            '$emoji ${category.category?.name ?? 'Unknown'}',
                            category.relations ?? [],
                            setState,
                          );
                        }).toList(),
                      if (isLoadingRelationships)
                        Padding(
                          padding: EdgeInsets.all(16.w),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ).then((value) {
      searchController.clear();
      filteredRelations = allRelations;
    });
  }

  Widget _buildPopupSection(
      String title, List<Relations> relations, StateSetter setState) {
    bool isExpanded = true;

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter localSetState) {
        List<Relations> filteredItems = relations
            .where((relation) => filteredRelations.contains(relation))
            .toList();
        if (filteredItems.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                localSetState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Container(
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
                        style: TextFontStyle.textStyle10InterW400.copyWith(
                            fontSize: 12.sp, fontWeight: FontWeight.w500)),
                    Row(
                      children: [
                        AnimatedRotation(
                          duration: const Duration(milliseconds: 300),
                          turns: isExpanded ? 0 : -0.5,
                          child: SvgPicture.asset(
                            AppIcons.searchiconcon,
                            height: 20.h,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (isExpanded) ...[
              UIHelper.verticalSpace(8.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: filteredItems
                      .map(
                        (relation) => GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            _onRelationshipSelected(
                                relation.name!, relation.id!);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 7.h),
                            child: Text(
                              relation.name!,
                              style: TextFontStyle.textStyle10InterW400
                                  .copyWith(fontSize: 14.sp),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _buildInterestsSection() {
    if (isLoadingCategories) {
      return Container(
        padding: EdgeInsets.all(20.h),
        child: Center(
          child: Column(
            children: [
              CircularProgressIndicator(),
              UIHelper.verticalSpace(10.h),
              Text(
                'Loading interests...',
                style: TextFontStyle.textStyle10InterW400.copyWith(
                  color: const Color(0xFF787A83),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (errorMessage != null) {
      return Container(
        padding: EdgeInsets.all(20.h),
        child: Column(
          children: [
            Text(
              errorMessage!,
              style: TextStyle(
                color: Colors.red,
                fontSize: 16.sp,
              ),
              textAlign: TextAlign.center,
            ),
            UIHelper.verticalSpace(16.h),
            ElevatedButton(
              onPressed: _loadVipCategoryData,
              child: Text('Retry'),
            ),
          ],
        ),
      );
    }

    return InterestsWidget(
      categories: categories,
      onInterestsSelected: _onInterestSelected,
      initiallySelectedIds: selectedInterestIds,
    );
  }

  List<String> _getSelectedInterestNames() {
    List<String> names = [];
    categories.forEach((category, interests) {
      for (var interest in interests) {
        if (selectedInterestIds.contains(interest.id)) {
          names.add(interest.name!);
        }
      }
    });
    return names;
  }

  Future<void> _saveVipProfile() async {
    if (firstNameController.text.isEmpty) {
      ToastUtil.showLongToast("Please enter full name");
      return;
    }

    if (selectedRelationship == null || selectedRelationshipId == null) {
      ToastUtil.showLongToast("Please select a relationship");
      return;
    }
    if (birthdayController.text.isEmpty) {
      ToastUtil.showLongToast("Please select birthday");
      return;
    }
    if (selectedInterestIds.isEmpty) {
      ToastUtil.showLongToast("Please select interest category ");
      return;
    }

    print('selectedInterestIds: $selectedInterestIds');
    print('selectedInterestNames: ${_getSelectedInterestNames().join(", ")}');
    print('=======================');
    print(
        '>>>>>>>>>> anniversary date ${anniversaryController.text.isNotEmpty ? anniversaryController.text : "Not set"}');
    print('>>>>>>>>>> avatar ${_profileImage.value}');

    try {
      if (widget.isEdit) {
        await updateVipProfileApiRx.updateVipProfileInfo(
          avatar: _profileImage.value,
          name: firstNameController.text,
          dateOfBirth: birthdayController.text.isNotEmpty
              ? birthdayController.text
              : 'Not set',
          relationId: selectedRelationshipId,
          specialNotes: specialNoteController.text.isNotEmpty
              ? specialNoteController.text
              : 'No special notes',
          streetAddress: streetAddressController.text,
          country: countryController.text,
          city: cityController.text,
          zipCode: zipcodeController.text,
          phone: phoneController.text,
          interests: selectedInterestIds,
          anniversaryDate: anniversaryController.text.isNotEmpty
              ? anniversaryController.text
              : 'Not set',
          id: widget.data!.id.toString(),
        );

        // Only call getVipProfile if we have an ID in edit mode
        if (widget.data?.id != null) {
          getVipProfileApiRx.getVipProfile(id: widget.data!.id);
        }
      } else {
        await createVipProfileRx.createVipProfileInfo(
          name: firstNameController.text,
          dateOfBirth: birthdayController.text.isNotEmpty
              ? birthdayController.text
              : 'Not set',
          relationId: selectedRelationshipId,
          specialNotes: specialNoteController.text.isNotEmpty
              ? specialNoteController.text
              : 'No special notes',
          streetAddress: streetAddressController.text,
          country: countryController.text,
          city: cityController.text,
          zipCode: zipcodeController.text,
          phone: phoneController.text,
          interests: selectedInterestIds,
          avatar: _profileImage.value,
          anniversaryDate: anniversaryController.text.isNotEmpty
              ? anniversaryController.text
              : 'Not set',
        );
      }
      getVipProfileListApiRx.getVipProfileList();

      NavigationService.goBack();
    } catch (e) {
      print('Error saving VIP profile: $e');
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    countryController.dispose();
    cityController.dispose();
    zipcodeController.dispose();
    phoneController.dispose();
    streetAddressController.dispose();
    firstNameController.dispose();
    anniversaryController.dispose();
    birthdayController.dispose();
    specialNoteController.dispose();
    super.dispose();
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
            const Spacer(),
            Text(widget.isEdit ? "Edit VIP Profile" : 'Add VIP Profile',
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
                      final pickedImage = _profileImage.value;
                      ImageProvider? image;

                      if (pickedImage != null) {
                        image = FileImage(File(pickedImage.path));
                      } else if (widget.isEdit &&
                          widget.data?.avatar != null &&
                          widget.data!.avatar.isNotEmpty) {
                        // FIX: Combine base URL with avatar path
                        String fullImageUrl = widget.data!.avatar!;
                        if (!fullImageUrl.startsWith('http')) {
                          fullImageUrl = baseImageUrl + widget.data!.avatar!;
                        }
                        print(">>>>>>>> Full Image URL: $fullImageUrl");
                        image = NetworkImage(fullImageUrl);
                      }

                      return CircleAvatar(
                        radius: 50.r,
                        backgroundColor: AppColor.blackColor.withOpacity(0.2),
                        backgroundImage: image,
                        child: image == null
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
                          showModalBottomSheet(
                            context: context,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16.r)),
                            ),
                            builder: (_) => _imagePickerSheet(
                              context,
                              onCameraTap: () => _pickImage(ImageSource.camera),
                              onGalleryTap: () =>
                                  _pickImage(ImageSource.gallery),
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
              BasicInformationSection(
                selectedRelationship: selectedRelationship,
                relationshipFieldKey: _relationshipFieldKey,
                onTapRelationship: () => _showRelationshipMenu(context),
                firstNameController: firstNameController,
                anniversaryController: anniversaryController,
              ),
              UIHelper.verticalSpace(20.h),
              ImportantEventsWidget(
                title: 'Important Events',
                birthday: birthdayController,
                spacialNote: specialNoteController,
              ),
              UIHelper.verticalSpace(20.h),
              AddTheirLocationWidget(
                isOn: isOn,
                streetAddressController: streetAddressController,
                countryController: countryController,
                cityController: cityController,
                zipcodeController: zipcodeController,
                phoneController: phoneController,
                onSwitchChanged: (value) => setState(() => isOn = value),
              ),
              UIHelper.verticalSpace(20.h),
              _buildInterestsSection(),
              UIHelper.verticalSpace(20.h),
              Row(
                children: [
                  Expanded(
                    child: CancelSaveButton(
                        onTap: () {
                          NavigationService.goBack;
                        },
                        color: AppColor.c373B4C,
                        title: 'Cancel'),
                  ),
                  UIHelper.horizontalSpace(12.w),
                  Expanded(
                    child: CancelSaveButton(
                        onTap: _saveVipProfile,
                        color: AppColor.buttonColor,
                        title: 'Save VIP Profile'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _imagePickerSheet(
  BuildContext context, {
  required VoidCallback onCameraTap,
  required VoidCallback onGalleryTap,
}) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r), color: AppColor.primaryBg),
    child: Padding(
      padding: EdgeInsets.all(12.sp),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(
              Icons.camera_alt,
              color: AppColor.cFFFFFF,
            ),
            title: Text(
              "Camera",
              style: TextFontStyle.textStyle14InterW400c787A83,
            ),
            onTap: () {
              Navigator.pop(context);
              onCameraTap();
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.photo_library,
              color: AppColor.cFFFFFF,
            ),
            title: Text(
              "Gallery",
              style: TextFontStyle.textStyle14InterW400c787A83,
            ),
            onTap: () {
              Navigator.pop(context);
              onGalleryTap();
            },
          ),
        ],
      ),
    ),
  );
}
