// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:kashirons_flutter/feature/settings/presentation/setting_screen.dart';
//
// import '../assets_helperfdg/app_colors.dart';
// import '../assets_helperfdg/app_fonts.dart';
// import '../assets_helperfdg/app_icons.dart';
// import 'home_screen/presentation/home_screen.dart';
// import 'vip_profile/presentation/vip_profile_screen.dart';
//
// class CustomBottomNavBar extends StatefulWidget {
//   const CustomBottomNavBar({super.key});
//
//   @override
//   State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
// }
//
// class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
//   int selectedIndex = 0;
//
//   final List<Widget> pages = [
//     HomeScreen(),
//     VipProfileScreen(), // Example page
//     SettingScreen( ),  // Example page
//   ];
//
//   void _onTabTap(int index) {
//     setState(() {
//       selectedIndex = index;
//     });
//   }
//
//   BottomNavigationBarItem _buildNavItem({
//     required String icon,
//     required String activeIcon,
//     required String label,
//   }) {
//     return BottomNavigationBarItem(
//       icon: Padding(
//         padding: EdgeInsets.only(top: 6, bottom: 4.h), // extra bottom padding
//         child: SvgPicture.asset(
//           icon,
//           height: 24.h,
//           width: 24.w,
//         ),
//       ),
//       activeIcon: Padding(
//         padding: EdgeInsets.only(top: 6, bottom: 4.h), // same for active
//         child: SvgPicture.asset(
//           activeIcon,
//           height: 24.h,
//           width: 24.w,
//         ),
//       ),
//       label: label,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: pages[selectedIndex],
//       bottomNavigationBar: SizedBox(
//         height: 95.h,
//         child: BottomNavigationBar(
//           type: BottomNavigationBarType.fixed,
//           backgroundColor: AppColor.authBg,
//           currentIndex: selectedIndex,
//           onTap: _onTabTap,
//
//           // ✅ Proper label colors
//           selectedItemColor: AppColor.cEDEDED,
//           unselectedItemColor: const Color(0xff6C6E77),
//
//           // ✅ Label styles
//           selectedLabelStyle: TextFontStyle.textStyle10InterW400.copyWith(
//             fontSize: 12.sp,
//             fontWeight: FontWeight.w500,
//           ),
//           unselectedLabelStyle: TextFontStyle.textStyle10InterW400.copyWith(
//             fontSize: 12.sp,
//             fontWeight: FontWeight.w500,
//           ),
//
//
//
//
//           items: [
//             _buildNavItem(
//               icon: AppIcons.home,
//               activeIcon: AppIcons.homeFill,
//               label: "Home",
//             ),
//             _buildNavItem(
//               icon: AppIcons.vip,
//               activeIcon: AppIcons.vipFill,
//               label: "VIP Profile",
//             ),
//             _buildNavItem(
//               icon: AppIcons.settings,
//               activeIcon: AppIcons.settingsFill,
//               label: "Settings",
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kashirons_flutter/feature/settings/presentation/setting_screen.dart';

import '../assets_helperfdg/app_colors.dart';
import '../assets_helperfdg/app_fonts.dart';
import '../assets_helperfdg/app_icons.dart';
import 'home_screen/presentation/home_screen.dart';
import 'vip_profile/presentation/vip_profile_screen.dart';

class CustomBottomNavBar extends StatefulWidget {
  /// 👇 Add a parameter to accept an index
  final int initialIndex;

  const CustomBottomNavBar({
    Key? key,
    this.initialIndex = 0, // Default = Home tab
  }) : super(key: key);

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  late int selectedIndex;

  final List<Widget> pages = [
    HomeScreen(),
    VipProfileScreen(),
    SettingScreen(),
  ];

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex; // ✅ Use the passed index
  }

  void _onTabTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  BottomNavigationBarItem _buildNavItem({
    required String icon,
    required String activeIcon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: EdgeInsets.only(top: 6, bottom: 4.h),
        child: SvgPicture.asset(icon, height: 24.h, width: 24.w),
      ),
      activeIcon: Padding(
        padding: EdgeInsets.only(top: 6, bottom: 4.h),
        child: SvgPicture.asset(activeIcon, height: 24.h, width: 24.w),
      ),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: SizedBox(
        height: 95.h,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColor.authBg,
          currentIndex: selectedIndex,
          onTap: _onTabTap,
          selectedItemColor: AppColor.cEDEDED,
          unselectedItemColor: const Color(0xff6C6E77),
          selectedLabelStyle: TextFontStyle.textStyle10InterW400.copyWith(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
          unselectedLabelStyle: TextFontStyle.textStyle10InterW400.copyWith(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
          items: [
            _buildNavItem(
              icon: AppIcons.home,
              activeIcon: AppIcons.homeFill,
              label: "Home",
            ),
            _buildNavItem(
              icon: AppIcons.vip,
              activeIcon: AppIcons.vipFill,
              label: "VIP Profile",
            ),
            _buildNavItem(
              icon: AppIcons.settings,
              activeIcon: AppIcons.settingsFill,
              label: "Settings",
            ),
          ],
        ),
      ),
    );
  }
}
