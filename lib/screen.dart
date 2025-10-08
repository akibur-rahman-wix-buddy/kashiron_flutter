//
// import 'dart:io' show File;
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
// import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
// import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
// import 'package:kashirons_flutter/common_widgets/custom_text_field.dart';
// import 'package:kashirons_flutter/feature/add_vip_profile_part/add_vip_profile_part/widget/basic_Information.dart';
// import 'package:kashirons_flutter/helpers/ui_helpers.dart';
//
// class AddVipProfilePartScreen extends StatefulWidget {
//   const AddVipProfilePartScreen({super.key});
//
//   @override
//   State<AddVipProfilePartScreen> createState() => _AddVipProfilePartScreenState();
// }
//
// class _AddVipProfilePartScreenState extends State<AddVipProfilePartScreen> {
//   final _profileImage = Rx<XFile?>(null);
//   String? selectedRelationship;
//
//   final TextEditingController searchController = TextEditingController();
//   final GlobalKey _relationshipFieldKey = GlobalKey();
//   final _formKey = GlobalKey<FormState>();
//
//
//   List<String> allRelationships = [
//     'Husband', 'Wife', 'Father', 'Mother', 'Brother', 'Sister', 'Son', 'Daughter',
//     'Grandfather', 'Grandmother', 'Partner', 'Boyfriend', 'Girlfriend', 'Fiancé',
//     'Fiancée', 'Best Friend', 'Uncle', 'Aunt', 'Nephew', 'Niece', 'Father-in-law',
//     'Mother-in-law', 'Colleague', 'Boss', 'Business Partner', 'Mentor', 'Client',
//     'Employee', 'Friend (general)', 'Neighbor', 'Teacher', 'Doctor', 'Classmate',
//     'Roommate'
//   ];
//   List<String> filteredRelationships = [];
//
//   @override
//   void initState() {
//     super.initState();
//     filteredRelationships = allRelationships;
//     searchController.addListener(_filterRelationships);
//   }
//
//   void _filterRelationships() {
//     String query = searchController.text.toLowerCase();
//     setState(() {
//       filteredRelationships = allRelationships
//           .where((relationship) => relationship.toLowerCase().contains(query))
//           .toList();
//     });
//   }
//
//   @override
//   void dispose() {
//     searchController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _pickImage(ImageSource source) async {
//     try {
//       final pickedFile = await ImagePicker().pickImage(source: source);
//       if (pickedFile != null) {
//         _profileImage.value = pickedFile;
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to pick image: $e',
//           backgroundColor: Colors.red, colorText: Colors.white);
//     }
//   }
//
//   void _showRelationshipMenu(BuildContext context) {
//     // Get the position and size of the Relationship field
//     final RenderBox? renderBox = _relationshipFieldKey.currentContext?.findRenderObject() as RenderBox?;
//     if (renderBox == null) return;
//
//     final Offset offset = renderBox.localToGlobal(Offset.zero);
//     final Size size = renderBox.size;
//
//     // Define popup dimensions
//     final double popupWidth = size.width; // Match the exact width of the text field
//     final double popupHeight = 200.h;
//
//     showMenu(
//       context: context,
//       position: RelativeRect.fromLTRB(
//         offset.dx, // Align left edge exactly with the text field
//         offset.dy + size.height, // Position directly below the text field
//         offset.dx + size.width, // Align right edge exactly with the text field
//         offset.dy + size.height + popupHeight, // Bottom of the popup
//       ),
//       color: AppColor.c2D3142,
//       constraints: BoxConstraints(
//         minWidth: popupWidth, // Ensure minimum width matches text field
//         maxWidth: popupWidth, // Ensure maximum width matches text field
//         maxHeight: popupHeight,
//       ),
//       items: [
//         PopupMenuItem<String>(
//           enabled: false,
//           child: StatefulBuilder(
//             builder: (BuildContext context, StateSetter setState) {
//               // Rebuild the popup when search changes
//               searchController.addListener(() {
//                 setState(() {
//                   _filterRelationships();
//                 });
//               });
//
//               return SingleChildScrollView(
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Search field
//                       CustomTextField(
//                         controller: searchController,
//                         contentPadding:
//                         EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
//                         hintText: 'Search relationships...',
//                         hintTextSyle: TextFontStyle.textStyle10InterW400.copyWith(
//                           color: const Color(0xFF787A83),
//                           fontSize: 14.sp,
//                         ),
//                       ),
//                       UIHelper.verticalSpace(14.h),
//                       // Family Section
//                       _buildPopupSection('🏡 Family', [
//                         'Husband', 'Wife', 'Father', 'Mother', 'Brother', 'Sister', 'Son',
//                         'Daughter', 'Grandfather', 'Grandmother'
//                       ], setState),
//                       // Personal/Close Section
//                       _buildPopupSection('❤️ Personal / Close', [
//                         'Partner', 'Boyfriend', 'Girlfriend', 'Fiancé', 'Fiancée', 'Best Friend'
//                       ], setState),
//                       // Relatives Section
//                       _buildPopupSection('👥 Relatives', [
//                         'Uncle', 'Aunt', 'Nephew', 'Niece', 'Father-in-law', 'Mother-in-law'
//                       ], setState),
//                       // Professional Section
//                       _buildPopupSection('💼 Professional', [
//                         'Colleague', 'Boss', 'Business Partner', 'Mentor', 'Client', 'Employee'
//                       ], setState),
//                       // Others Section
//                       _buildPopupSection('🎉 Others', [
//                         'Friend (general)', 'Neighbor', 'Teacher', 'Doctor', 'Classmate', 'Roommate'
//                       ], setState),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     ).then((value) {
//       if (value != null) {
//         setState(() {
//           selectedRelationship = value;
//           searchController.clear();
//           filteredRelationships = allRelationships;
//         });
//       }
//     });
//   }
//
//   Widget _buildPopupSection(String title, List<String> items, StateSetter setState) {
//     List<String> filteredItems =
//     items.where((item) => filteredRelationships.contains(item)).toList();
//     if (filteredItems.isEmpty) return const SizedBox.shrink();
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           width: double.infinity,
//           padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
//           decoration: ShapeDecoration(
//             color: const Color(0xFF373B4C),
//             shape: RoundedRectangleBorder(
//               side: const BorderSide(
//                 width: 1,
//                 color: Color(0xFF3E4357),
//               ),
//             ),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 title,
//                 style: TextFontStyle.textStyle10InterW400.copyWith(
//                   fontSize: 12.sp,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               SvgPicture.asset(
//                 AppIcons.searchiconcon,
//                 height: 20.h,
//               ),
//             ],
//           ),
//         ),
//         UIHelper.verticalSpace(8.h),
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: filteredItems
//                 .map((item) => GestureDetector(
//               onTap: () {
//                 Navigator.pop(context, item);
//               },
//               child: Padding(
//                 padding: EdgeInsets.symmetric(vertical: 7.h),
//                 child: Text(
//                   item,
//                   style: TextFontStyle.textStyle10InterW400.copyWith(
//                     fontSize: 14.sp,
//                   ),
//                 ),
//               ),
//             ))
//                 .toList(),
//           ),
//         ),
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.c272A36,
//       appBar: AppBar(
//         elevation: 0,
//         scrolledUnderElevation: 0,
//         toolbarHeight: 80,
//         backgroundColor: AppColor.c2D3142,
//         title: Row(
//           children: [
//             GestureDetector(
//               onTap: () => Get.back(),
//               child: SvgPicture.asset(
//                 AppIcons.arrwlefticon,
//                 height: 20.h,
//                 width: 20.w,
//               ),
//             ),
//             const Spacer(),
//             Text(
//               'Add VIP Profile',
//               style: TextFontStyle.textStyle14InterW500.copyWith(
//                 fontSize: 18.sp,
//               ),
//             ),
//             const Spacer(),
//             SvgPicture.asset(AppIcons.qustionicon),
//           ],
//         ),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
//           child: Column(
//             children: [
//               UIHelper.verticalSpace(15.h),
//
//               Center(
//                 child: Stack(
//                   clipBehavior: Clip.none,
//                   children: [
//                     Obx(() {
//                       return CircleAvatar(
//                         radius: 50.r,
//                         backgroundColor: AppColor.blackColor.withOpacity(0.2),
//                         backgroundImage: _profileImage.value != null
//                             ? FileImage(File(_profileImage.value!.path))
//                             : null,
//                         child: _profileImage.value == null
//                             ? Icon(
//                           Icons.person,
//                           size: 50.r,
//                           color: Colors.white,
//                         )
//                             : null,
//                       );
//                     }),
//                     Positioned(
//                       bottom: 0,
//                       right: 0,
//                       child: GestureDetector(
//                         onTap: () {
//                           Get.bottomSheet(
//                             Container(
//                               color: AppColor.c0E3E2C,
//                               padding: EdgeInsets.all(20.sp),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   GestureDetector(
//                                     onTap: () {
//                                       Get.back();
//                                       _pickImage(ImageSource.camera);
//                                     },
//                                     child: Text(
//                                       'Take Photo',
//                                       style: TextFontStyle.textStyle10InterW400,
//                                     ),
//                                   ),
//                                   UIHelper.verticalSpace(10.h),
//                                   const Divider(color: Colors.grey),
//                                   UIHelper.verticalSpace(10.h),
//                                   GestureDetector(
//                                     onTap: () {
//                                       Get.back();
//                                       _pickImage(ImageSource.gallery);
//                                     },
//                                     child: Text(
//                                       'Select from library',
//                                       style: TextFontStyle.textStyle14InterW500,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                         child: SvgPicture.asset(AppIcons.cameraicon),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               UIHelper.verticalSpace(8.h),
//               Text('Add Photo',
//                   textAlign: TextAlign.center,
//                   style: TextFontStyle.textStyle14InterW500),
//               UIHelper.verticalSpace(2.h),
//               Text('Tap to add a profile picture',
//                   textAlign: TextAlign.center,
//                   style: TextFontStyle.textcA9A9A9Style12InterW400),
//               UIHelper.verticalSpace(20.h),
//
//               BasicInformation(title: 'Basic Information',),
//
//               CustomTextField(
//                 key: _relationshipFieldKey,
//                 readOnly: true,
//                 contentPadding:
//                 EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
//                 hintText: selectedRelationship ?? 'Select relationship',
//                 hintTextSyle: TextFontStyle.textStyle10InterW400.copyWith(
//                   fontSize: 14.sp,
//                   fontWeight: FontWeight.w400,
//                 ),
//                 height: 48,
//                 rightIconWidget: InkWell(
//                   onTap: () => _showRelationshipMenu(context),
//                   child: Transform.scale(
//                       scale: 0.60,
//                       child: SvgPicture.asset(AppIcons.drwopdwonicon)),
//                 ),
//               ),
//
//
//               UIHelper.verticalSpace(20.h),
//               Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.all(16.sp),
//                 decoration: ShapeDecoration(
//                   color: AppColor.c2D3142,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12.r),
//                   ),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       width: 304.w,
//                       child: Text('Important Events',
//                           style: TextFontStyle.textStyle10InterW400.copyWith(
//                               fontSize: 18.sp, fontWeight: FontWeight.w500)),
//                     ),
//                     UIHelper.verticalSpace(16.h),
//                     Text('Birthday date',
//                         style: TextFontStyle.textStyle10InterW400.copyWith(
//                             fontSize: 16.sp, fontWeight: FontWeight.w400)),
//                     UIHelper.verticalSpace(6.h),
//                     CustomTextField(
//                       contentPadding:
//                       EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
//                       hintText: 'mm/dd/yyyy',
//                       hintTextSyle: TextFontStyle.textStyle10InterW400.copyWith(
//                         color: const Color(0xFF787A83),
//                         fontSize: 14.sp,
//                       ),
//                       rightIcon: AppIcons.calendars,
//                     ),
//                     UIHelper.verticalSpace(12.h),
//                     Text('Special Notes (Optional)',
//                         style: TextFontStyle.textStyle10InterW400.copyWith(
//                             fontSize: 16.sp, fontWeight: FontWeight.w400)),
//                     UIHelper.verticalSpace(6.h),
//
//                     CustomTextField(
//                       key: _relationshipFieldKey,
//                       readOnly: true,
//                       contentPadding:
//                       EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
//                       hintText: selectedRelationship ?? 'Select relationship',
//                       hintTextSyle: TextFontStyle.textStyle10InterW400.copyWith(
//                         fontSize: 14.sp,
//                         fontWeight: FontWeight.w400,
//                       ),
//                       height: 48,
//                       rightIconWidget: InkWell(
//                         onTap: () => _showRelationshipMenu(context),
//                         child: Transform.scale(
//                             scale: 0.60,
//                             child: SvgPicture.asset(AppIcons.drwopdwonicon)),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//


//
//
// class InterestsScreen extends StatelessWidget {
//   const InterestsScreen({super.key});
//
//   final Map<String, List<String>> categories = const {
//
//     'Lifestyle & Creative': [
//       'Fashion/Style',
//       'Health & Beauty',
//       'Home & Decor',
//       'Wellness',
//       'Spa',
//       'Social Media'
//     ],
//     'Hobbies & Creative': [
//       'Art',
//       'DIY',
//       'Photography',
//       'Music',
//       'Dance',
//       'Film/TV',
//       'Reading',
//       'Writing'
//     ],
//     'Activities & Outdoors': ['Travel', 'Beach', 'Camping', 'Adventure', 'Gardening'],
//     'Food & Drink': ['Cooking', 'Coffee/Tea', 'Foodie', 'Wine/Cocktails', 'BBQ/Grilling'],
//     'Fitness & Sports': [
//       'Fitness',
//       'Running',
//       'Cycling',
//       'Swimming',
//       'Yoga',
//       'Tennis',
//       'Pickleball',
//       'Football',
//       'Golf',
//       'Baseball',
//       'Soccer'
//     ],
//     'Pets': ['Dogs', 'Cats', 'Birds', 'Fish', 'Reptiles', 'Small Pets'],
//     'Entertainment & Social': ['Partying', 'Podcasts'],
//
//
//
//   };
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.c272A36,
//       body: SingleChildScrollView(
//         padding: EdgeInsets.symmetric(horizontal: 24, vertical: 50),
//         child: InterestSelector(categories: categories),
//       ),
//     );
//   }
// }
