import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import 'package:kashirons_flutter/common_widgets/custom_app_bar.dart';
import 'package:kashirons_flutter/common_widgets/custom_button.dart';
import 'package:kashirons_flutter/common_widgets/custom_text_field.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';
import 'package:kashirons_flutter/networks/endpoints.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
TextEditingController firstNameController = TextEditingController(text: "First name");
TextEditingController lastNameController = TextEditingController(text: "Last name");
TextEditingController emailController = TextEditingController(text: "sholifulislamemon@gmail.com");
TextEditingController dateController = TextEditingController();
XFile? _pickedImage;
final ImagePicker _picker = ImagePicker();

Future<void> _pickImage() async {
  showModalBottomSheet(
    context: context,
    backgroundColor:Colors.transparent,
    builder: (context) {
      return Container(

        decoration: const BoxDecoration(
          color:AppColor.primaryBg,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.red),
              title:  Text('Choose from Gallery',style: TextFontStyle.textStyle16InterW700,),
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
              title:   Text('Take a Photo',style: TextFontStyle.textStyle16InterW700,),
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

DateTime? selectedDate;
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
            primary: AppColor.c2D3142, // Change primary color
            onPrimary: Colors.white, // Text color on primary
            onSurface: Colors.black, // Text color on surface
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: AppColor.c2D3142, // Button text color
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
      // Format the date as mm/dd/yyyy
      dateController.text =
      "${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}/${picked.year}";
    });
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryBg,
      body: Column(
        children: [
          /// App Bar
          CustomAppBar(
            title: "Edit Profile",
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
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
                            child: ClipOval(
                              child:  _pickedImage != null
                                  ? Image.file(
                                File(_pickedImage!.path),
                                height: 110,
                                width: 110,
                                fit: BoxFit.cover,
                              )
                                  : Image.network(
                                personImageUrl,
                                height: 110,
                                width: 110,
                                fit: BoxFit.cover,
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
                    UIHelper.verticalSpace(16.h),
                    Align(
                        alignment: Alignment.center,
                        child: Text("Change Photo",style:TextFontStyle.textStyle16InterW700,)),
                    UIHelper.verticalSpace(16.h),

                    Text("First Name",style: TextFontStyle.textStyle14InterW500,),
                    UIHelper.verticalSpace(8.h),
                    CustomTextField(controller:firstNameController,),

                    UIHelper.verticalSpace(16.h),
                    Text("Last Name",style: TextFontStyle.textStyle14InterW500,),
                    UIHelper.verticalSpace(8.h),
                    CustomTextField(controller:lastNameController,),

                    UIHelper.verticalSpace(16.h),
                    Text("Email Address",style: TextFontStyle.textStyle14InterW500,),
                    UIHelper.verticalSpace(8.h),
                    CustomTextField(controller:emailController,),

                    UIHelper.verticalSpace(16.h),
                    Text("Date of Birth",style: TextFontStyle.textStyle14InterW500,),
                    UIHelper.verticalSpace(8.h),
                    InkWell(
                      onTap: _selectDate,
                      child: AbsorbPointer(
                        child: CustomTextField(
                          hintText: selectedDate != null
                              ? "${selectedDate!.month.toString().padLeft(2, '0')}/${selectedDate!.day.toString().padLeft(2, '0')}/${selectedDate!.year}"
                              : "mm/dd/yyyy",
                          rightIcon: AppIcons.calendar,
                          readOnly: true,
                          controller: dateController,
                        ),
                      ),
                    ),
                    UIHelper.verticalSpace(100.h),
                    customButton(name: "Save Change",
                        borderColor: Colors.transparent,
                        height: 45,
                        onCallBack: (){

                      log(">>>>>>>>>>>>>>>>>>>>> First name ${firstNameController.text} ");
                      log(">>>>>>>>>>>>>>>>>>>>>>> last name ${lastNameController.text} ");
                      log(">>>>>>>>>>>>>>>>>>>>> Email address ${emailController.text} ");
                      log(">>>>>>>>>>>>>>>>>>>>> date of birth ${dateController.text} ");
                      log(">>>>>>>>>>>>>>>>>>>>> date of birth ${_pickedImage?.path} ");



                    },  context: context)

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
