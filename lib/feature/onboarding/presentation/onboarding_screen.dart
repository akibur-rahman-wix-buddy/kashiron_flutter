import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import 'package:kashirons_flutter/feature/onboarding/widget/onboarding_button.dart';
import 'package:kashirons_flutter/helpers/all_routes.dart';
import 'package:kashirons_flutter/helpers/navigation_service.dart';

import '../../../assets_helperfdg/app_colors.dart';
import '../../../assets_helperfdg/app_fonts.dart';
import '../../../assets_helperfdg/app_image.dart';
import '../../../helpers/ui_helpers.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> _images = [
    AppImages.onb1,
    AppImages.onb2,
    AppImages.onb3,
  ];

  final List<String> _titles = [
    'Be the Bro Who\nRemembers',
    'Partner, Parents,\nFriends, You Name it!',
    'Pro Moves,\nEvery Occasion',
  ];
  final List<String> _subTitles = [
    'Stay on top of birthdays, anniversaries,\nand big days without breaking a sweat',
    'Get smart reminders and gift suggestions\nfor every important person in your life.',
    'Individual gift ideas that keep you thoughtful,\nsmooth, and on point, every time.',
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.authBg,
      body: SafeArea(
        child: Column(
          children: [
            UIHelper.verticalSpace(20.h),
            _currentPage == 2 ? SizedBox(height: 0, width: 0,) :
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  NavigationService.navigateTo(Routes.signUpScreen);
                },
                child:  Text(
                  "Skip",
                  style: TextFontStyle.textStyle12InterW300.copyWith(
                      fontSize: 16,
                      color: AppColor.cFFFFFF
                  ),
                ),
              ),
            ),
            UIHelper.verticalSpace(28.h),

            _currentPage == 0 ?
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              SvgPicture.asset(AppIcons.rightOnbArrow, height: 13.h, width: 60.w,),
              SizedBox(width: 20.w,),
              Text(
                "Welcome to BroBrain!",
                style: TextFontStyle.textStyle12InterW300.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Color(0xffD01C21)
                ),
              ),
              SizedBox(width: 20.w,),
              SvgPicture.asset(AppIcons.leftOnbArrow, height: 13.h, width: 60.w,),
            ],) : SizedBox(height: 0, width: 0,),

            UIHelper.verticalSpace(28.h),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _images.length,
                onPageChanged: _onPageChanged,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Expanded(
                        child: Image.asset(
                          _images[index],
                          fit: BoxFit.contain,
                        ),
                      ),
                      UIHelper.verticalSpace(10.h),
                      Text(
                        _titles[index],
                        textAlign: TextAlign.center,
                        style: TextFontStyle.textStyle12InterW300.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: AppColor.cFFFFFF
                        ),
                      ),
                      UIHelper.verticalSpace(10.h),
                      Text(
                        _subTitles[index],
                        textAlign: TextAlign.center,
                        style: TextFontStyle.textStyle12InterW400.copyWith(
                            fontSize: 14,
                            color: AppColor.cFFFFFF
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            UIHelper.verticalSpace(14.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_images.length, (index) {
                final isSelected = index == _currentPage;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 3.w),
                  width: isSelected ? 32.w : 8.w,
                  height: 8.h,
                  decoration: BoxDecoration(
                    color: Color(0xffC4CDD5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
            UIHelper.verticalSpace(40.h),
            Container(
              height: 1,
              width: double.infinity,
              color: Color(0xff3F4355),
            ),
            UIHelper.verticalSpace(32.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: OnboardingButton(
                text: _currentPage == _images.length - 1 ? "Get Started" : "Next",
                onPressed: () {
                  if (_currentPage < _images.length - 1) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    NavigationService.navigateTo(Routes.signUpScreen);
                  }
                },
              ),
            ),
            UIHelper.verticalSpace(40.h),

          ],
        ),
      ),
    );
  }
}
