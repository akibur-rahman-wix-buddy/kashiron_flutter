import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import 'package:kashirons_flutter/common_widgets/custom_app_bar.dart';
import 'package:kashirons_flutter/common_widgets/custom_elevated_button.dart';
import 'package:kashirons_flutter/common_widgets/custom_text_field.dart';
import 'package:kashirons_flutter/helpers/all_routes.dart';
import 'package:kashirons_flutter/helpers/navigation_service.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';

class SendFlowerCardScreen extends StatelessWidget {
  const SendFlowerCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController personalizationTextController =
    TextEditingController();

    // Function to handle suggestion tap
    void _onSuggestionTap(String suggestion) {
      final currentText = personalizationTextController.text;
      final newText = currentText.isEmpty
          ? suggestion
          : '$currentText $suggestion';

      personalizationTextController.text = newText;

      // Move cursor to the end
      personalizationTextController.selection = TextSelection.fromPosition(
        TextPosition(offset: newText.length),
      );
    }

    return Scaffold(
      backgroundColor: AppColor.primaryBg,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomAppBar(
            title: "Send Flowers & Card",
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Personalize Your Message",
                    style: TextFontStyle.textStyle16InterW700.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  UIHelper.verticalSpace(8.h),
                  Text(
                    "Write a heartfelt message to make your gift extra special.",
                    style: TextFontStyle.textStyle16InterW700.copyWith(
                      color: Colors.white60,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  UIHelper.verticalSpace(16.h),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff373b4c),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.all(16.w),
                    child: CustomTextField(
                      borderColor: Colors.transparent,
                      height: 120.h,
                      hintText:
                      "Write your personalized message here... E.g., Happy Birthday! Wishing you love and happiness.",
                      controller: personalizationTextController,
                      maxLength: 250,
                    ),
                  ),
                  UIHelper.verticalSpace(16.h),
                  Text(
                    "Quick suggestions:",
                    style: TextFontStyle.textStyle18InterW700.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  UIHelper.verticalSpace(12.h),
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: [
                      _buildSuggestionChip(
                        "Thinking of you on your special day! 💕",
                        onTap: () => _onSuggestionTap("Thinking of you on your special day! 💕"),
                      ),
                      _buildSuggestionChip(
                        "Wishing you love and happiness! 🌸",
                        onTap: () => _onSuggestionTap("Wishing you love and happiness! 🌸"),
                      ),
                      _buildSuggestionChip(
                        "Hope this brightens your day! 💐",
                        onTap: () => _onSuggestionTap("Hope this brightens your day! 💐"),
                      ),
                      _buildSuggestionChip(
                        "Sending warm wishes your way! 🌺",
                        onTap: () => _onSuggestionTap("Sending warm wishes your way! 🌺"),
                      ),
                      _buildSuggestionChip(
                        "You mean the world to me! ❤️",
                        onTap: () => _onSuggestionTap("You mean the world to me! ❤️"),
                      ),
                      _buildSuggestionChip(
                        "Celebrating you today! 🎉",
                        onTap: () => _onSuggestionTap("Celebrating you today! 🎉"),
                      ),
                    ],
                  ),
                  UIHelper.verticalSpace(24.h),
                  Row(
                    children: [
                      Expanded(
                        child: CustomElevatedButton(
                          text: "Continue",
                          onPressed: () {
                           NavigationService.navigateToReplacement(Routes.chooseDeliveryAddressSendFlowerCard);
                            if (personalizationTextController.text.isEmpty) {
                              // Show error or validation
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Please write a message before continuing",
                                    style: TextFontStyle.textStyle14InterW400,
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            } else {
                              // Proceed with the flow
                              print("Message: ${personalizationTextController.text}");
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  UIHelper.verticalSpace(16.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionChip(String text, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: ShapeDecoration(
          color: const Color(0xFF2D303C),
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 1,
              color: Color(0xFF2D3142),
            ),
            borderRadius: BorderRadius.circular(33.r),
          ),
        ),
        child: Text(
          text,
          style: TextFontStyle.textStyle12InterW600.copyWith(
            color: Colors.white70,
          ),
        ),
      ),
    );
  }
}