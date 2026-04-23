import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import 'package:kashirons_flutter/common_widgets/custom_app_bar.dart';
import 'package:kashirons_flutter/common_widgets/custom_button.dart';
import 'package:kashirons_flutter/common_widgets/custom_text_field.dart';
import 'package:kashirons_flutter/common_widgets/shimmerClipOverImageWidget.dart';
import 'package:kashirons_flutter/feature/bottom_nav_bar.dart';
import 'package:kashirons_flutter/feature/settings/model/user_infi_data_model.dart';
import 'package:kashirons_flutter/helpers/toast.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';
import 'package:kashirons_flutter/networks/api_acess.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.data});
  final GetUserProfileModelData data;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  XFile? _pickedImage;
  final ImagePicker _picker = ImagePicker();
  DateTime? selectedDate;
  bool _isLoading = false;

  @override
  void initState() {
    _initializeData();
    super.initState();
  }

  void _initializeData() {
    // Initialize name
    if (widget.data.data?.user?.name != null &&
        widget.data.data!.user!.name!.isNotEmpty) {
      firstNameController.text = widget.data.data!.user!.name!;
    } else {
      firstNameController.text = "Enter Your name";
    }

    // Initialize email
    if (widget.data.data?.user?.email != null &&
        widget.data.data!.user!.email!.isNotEmpty) {
      emailController.text = widget.data.data!.user!.email!;
    } else {
      emailController.text = "Enter Your email";
    }

    // Initialize date of birth
    if (widget.data.data?.user?.dateOfBirth != null &&
        widget.data.data!.user!.dateOfBirth!.isNotEmpty) {
      // Parse the API date and format it for display
      try {
        DateTime apiDate = DateTime.parse(widget.data.data!.user!.dateOfBirth!);
        selectedDate = apiDate;
        // Format for display: mm/dd/yyyy
        dateController.text = _formatDateForDisplay(apiDate);
      } catch (e) {
        log('Error parsing date: $e');
        dateController.text = "Select your birthday";
      }
    } else {
      dateController.text = "Select your birthday";
    }
  }

  // Format date for display (mm/dd/yyyy)
  String _formatDateForDisplay(DateTime date) {
    return "${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}/${date.year}";
  }

  // Format date for API (yyyy-mm-dd)
  String _formatDateForApi(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColor.primaryBg,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.red),
                title: Text('Choose from Gallery',
                    style: TextFontStyle.textStyle16InterW700),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? image =
                      await _picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    setState(() => _pickedImage = image);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.red),
                title: Text('Take a Photo',
                    style: TextFontStyle.textStyle16InterW700),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? image =
                      await _picker.pickImage(source: ImageSource.camera);
                  if (image != null) {
                    setState(() => _pickedImage = image);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColor.c2D3142,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColor.c2D3142,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        // Format the date for display: mm/dd/yyyy
        dateController.text = _formatDateForDisplay(picked);
      });
    }
  }

  Future<void> _saveChanges() async {
    // Validate inputs
    if (firstNameController.text.isEmpty ||
        firstNameController.text == "Enter Your name") {
      _showErrorSnackBar("Please enter your name");
      return;
    }

    if (emailController.text.isEmpty ||
        emailController.text == "Enter Your email") {
      _showErrorSnackBar("Please enter your email");
      return;
    }

    if (!_isValidEmail(emailController.text)) {
      _showErrorSnackBar("Please enter a valid email address");
      return;
    }

    if (dateController.text.isEmpty ||
        dateController.text == "Select your birthday") {
      _showErrorSnackBar("Please select your date of birth");
      return;
    }

    // Validate date format
    if (selectedDate == null) {
      _showErrorSnackBar("Please select a valid date");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Format date for API (yyyy-mm-dd)
      String apiFormattedDate = _formatDateForApi(selectedDate!);

      // Log the data being sent
      log("Name: ${firstNameController.text}");
      log("Email: ${emailController.text}");
      log("Date of Birth (Display): ${dateController.text}");
      log("Date of Birth (API): $apiFormattedDate");
      if (_pickedImage != null) {
        log("Image Path: ${_pickedImage!.path}");
      }

      bool success = await updateProfileRx.updateProfileInfo(
        name: firstNameController.text,
        dateOfBirth: apiFormattedDate, // Use API formatted date
        avatar: _pickedImage != null ? XFile(_pickedImage!.path) : null,
      );

      if (success) {
        Get.to(CustomBottomNavBar(
          initialIndex: 2,
        ));
        ToastUtil.showLongToast("Profile updated successfully!");
      }
    } catch (e) {
      log("Error updating profile: $e");
      _showErrorSnackBar("Failed to update profile. Please try again.");
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  bool _isValidEmail(String email) {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget _buildProfileImage() {
    if (_pickedImage != null) {
      return ClipOval(
        child: Image.file(
          File(_pickedImage!.path),
          height: 110,
          width: 110,
          fit: BoxFit.cover,
        ),
      );
    } else if (widget.data.data?.user?.avatar != null &&
        widget.data.data!.user!.avatar!.isNotEmpty) {
      return shimmerClipOvalWidget(
        height: 110,
        weight: 110,
        networkImageLink: widget.data.data!.user!.avatar!,
      );
    } else {
      return Container(
        height: 110,
        width: 110,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.person,
          size: 50,
          color: Colors.grey[600],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryBg,
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// App Bar
            CustomAppBar(
              title: "Edit Profile",
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UIHelper.verticalSpace(26.h),
                  Align(
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(60),
                          ),
                          child: _buildProfileImage(),
                        ),
                        Positioned(
                          right: 5,
                          bottom: 5,
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: const Color(0xFFA4161A),
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  UIHelper.verticalSpace(16.h),
                  Align(
                    alignment: Alignment.center,
                    child: Text("Change Photo",
                        style: TextFontStyle.textStyle16InterW700),
                  ),
                  UIHelper.verticalSpace(16.h),

                  // Name Field
                  Text("Name", style: TextFontStyle.textStyle14InterW500),
                  UIHelper.verticalSpace(8.h),
                  CustomTextField(
                    controller: firstNameController,
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),

                  UIHelper.verticalSpace(16.h),
                  // Email Field
                  Text("Email Address",
                      style: TextFontStyle.textStyle14InterW500),
                  UIHelper.verticalSpace(8.h),
                  CustomTextField(
                    readOnly: true,
                    controller: emailController,
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),

                  UIHelper.verticalSpace(16.h),
                  // Date of Birth Field
                  Text("Date of Birth",
                      style: TextFontStyle.textStyle14InterW500),
                  UIHelper.verticalSpace(8.h),
                  InkWell(
                    onTap: _selectDate,
                    child: AbsorbPointer(
                      child: CustomTextField(
                        hintText: "mm/dd/yyyy",
                        rightIcon: AppIcons.calendar,
                        readOnly: true,
                        controller: dateController,
                      ),
                    ),
                  ),

                  UIHelper.verticalSpace(
                      MediaQuery.of(context).size.height * 0.22),
                  // Save Button
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : customButton(
                          name: "Save Changes",
                          borderColor: Colors.transparent,
                          height: 45,
                          onCallBack: _saveChanges,
                          context: context,
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    firstNameController.dispose();
    emailController.dispose();
    dateController.dispose();
    super.dispose();
  }
}
