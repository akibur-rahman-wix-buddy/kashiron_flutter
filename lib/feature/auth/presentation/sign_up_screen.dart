import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/common_widgets/custom_elevated_button.dart';
import 'package:kashirons_flutter/common_widgets/custom_text_field.dart';
import 'package:kashirons_flutter/helpers/navigation_service.dart';
import 'package:kashirons_flutter/helpers/all_routes.dart';
import 'package:kashirons_flutter/networks/api_acess.dart';
import 'package:kashirons_flutter/networks/endpoints.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool _hasImageError = false; // Track image validation error

  XFile? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  ///>>>>>>>>>>>>>>>>>. here is the file picker >>>>>>>>>>>>>>>>>>>>>>>>>>
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
                title: Text(
                  'Choose from Gallery',
                  style: TextFontStyle.textStyle16InterW700,
                ),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? image =
                      await _picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    setState(() {
                      _pickedImage = image;
                      _hasImageError =
                          false; // Clear error when image is selected
                    });
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.red),
                title: Text(
                  'Take a Photo',
                  style: TextFontStyle.textStyle16InterW700,
                ),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? image =
                      await _picker.pickImage(source: ImageSource.camera);
                  if (image != null) {
                    setState(() {
                      _pickedImage = image;
                      _hasImageError =
                          false; // Clear error when image is selected
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Validate the form including image
  bool _validateForm() {
    if (_formKey.currentState!.validate()) {
      if (_pickedImage == null) {
        setState(() {
          _hasImageError = true;
        });
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a profile image'),
            backgroundColor: Colors.red,
          ),
        );
        return false;
      }
      return true;
    }
    return false;
  }

  ///>>>>>>>>>>>>>>>>>. here is the submit callback >>>>>>>>>>>>>>>>>>>>>>>>>>
  Future<void> _submitForm() async {
    if (_validateForm()) {
      setState(() {
        isLoading = true;
      });

      bool success = await signUpRx.signUp(
        name: nameController.text,
        email: emailController.text,
        dateOfBirth: dateController.text,
        avatar: _pickedImage,
      );

      if (success) {
        NavigationService.navigateToWithArgs(Routes.signupOtpScreen,
            {"email": emailController.text, "isForgetScreen": false});
      }

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.authBg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20.h),
                  // Profile Image with Validation
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: _hasImageError
                                      ? Colors.red
                                      : Colors.white,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(60),
                              ),
                              child: ClipOval(
                                child: _pickedImage != null
                                    ? Image.file(
                                        File(_pickedImage!.path),
                                        height: 110,
                                        width: 110,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                            height: 110,
                                            width: 110,
                                            color: Colors.grey[300],
                                            child: Icon(
                                              Icons.person,
                                              size: 50,
                                              color: Colors.grey[600],
                                            ),
                                          );
                                        },
                                      )
                                    : SvgPicture.asset(
                                        AppIcons.authPlaceHolder,
                                        height: 80.h,
                                        width: 80.w,
                                      ),
                              ),
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
                      if (_hasImageError)
                        Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: Text(
                            'Profile image is required',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    "Create Account",
                    style: TextFontStyle.textStyle12InterW300.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: AppColor.cEDEDED,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "Sign up to get started",
                    style: TextFontStyle.textStyle12InterW300.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColor.cEDEDED,
                    ),
                  ),
                  SizedBox(height: 32.h),
                  CustomTextField(
                    leftIcon: AppIcons.fieldProfile,
                    hintText: "Name",
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a name";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  CustomTextField(
                    leftIcon: AppIcons.fieldMai,
                    hintText: "Email",
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter an email";
                      } else if (!RegExp(
                              r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                          .hasMatch(value)) {
                        return "Please enter a valid email";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  CustomTextField(
                    leftIcon: AppIcons.fieldCalander,
                    hintText: "Date of Birth",
                    controller: dateController,
                    readOnly: true,
                    onTap: () async {
                      FocusScope.of(context).requestFocus(FocusNode());

                      // Calculate initial date (18 years ago for default selection)
                      final DateTime now = DateTime.now();
                      final DateTime initialDate =
                          DateTime(now.year - 0, now.month, now.day);
                      final DateTime firstDate = DateTime(1900);
                      final DateTime lastDate = now;

                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: initialDate,
                        firstDate: firstDate,
                        lastDate: lastDate,
                        initialEntryMode: DatePickerEntryMode.calendar,
                        helpText: 'Select your birthday',
                        confirmText: 'SELECT',
                        cancelText: 'CANCEL',
                        fieldLabelText: 'Birthday',
                        fieldHintText: 'MM/DD/YYYY',
                        errorFormatText: 'Enter valid date',
                        errorInvalidText: 'Enter date in valid range',
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.light(
                                primary: Color(0xffA4161A),
                                // header background color
                                onPrimary: Colors.white,
                                // header text color
                                onSurface: Colors.black, // body text color
                              ),
                              textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(
                                  foregroundColor: const Color(
                                      0xffA4161A), // button text color
                                ),
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );

                      if (pickedDate != null) {
                        setState(() {
                          dateController.text =
                              "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                        });
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your date of birth";
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  CustomElevatedButton(
                    text: "Create Account",
                    onPressed: _submitForm,
                    isLoading: isLoading,
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 1.h,
                        width: 60.w,
                        color: const Color(0xff787a83),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        "Or continue with",
                        style: TextFontStyle.textStyle12InterW300.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff787a83),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Container(
                        height: 1.h,
                        width: 60.w,
                        color: const Color(0xff787a83),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  AuthOptionContainer(
                    logo: AppIcons.google,
                    title: "Continue with Google",
                    onTap: () {},
                  ),
                  SizedBox(height: 16.h),
                  AuthOptionContainer(
                    logo: AppIcons.apple,
                    title: "Continue with Apple",
                    onTap: () {},
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: TextFontStyle.textStyle12InterW300.copyWith(
                          color: AppColor.cEDEDED,
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          NavigationService.navigateTo(Routes.loginScreen);
                        },
                        child: Text(
                          'Sign In',
                          style: TextFontStyle.textStyle12InterW300.copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor: const Color(0xffD7263D),
                            color: const Color(0xffD7263D),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'By using this app, you agree to our ',
                    style: TextFontStyle.textStyle12InterW300.copyWith(
                      color: AppColor.cEDEDED,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'Terms of Use and Privacy Policy',
                    style: TextFontStyle.textStyle12InterW300.copyWith(
                      decoration: TextDecoration.underline,
                      decorationColor: const Color(0xffD7263D),
                      color: const Color(0xffD7263D),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AuthOptionContainer extends StatelessWidget {
  final dynamic logo;
  final dynamic title;
  final VoidCallback onTap;

  const AuthOptionContainer({
    super.key,
    required this.logo,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xff373b4c),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(logo, height: 24.h, width: 24.w),
              SizedBox(width: 10.w),
              Text(
                title,
                style: TextFontStyle.textStyle12InterW300.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColor.cEDEDED,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
