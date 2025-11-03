import 'package:flutter/material.dart';
import 'package:kashirons_flutter/constants/app_constants.dart';
import 'package:kashirons_flutter/feature/bottom_nav_bar.dart';
import 'package:kashirons_flutter/helpers/di.dart';
import 'package:kashirons_flutter/networks/dio/dio.dart';
import 'feature/auth/presentation/login_screen.dart';
import 'feature/onboarding/presentation/onboarding_screen.dart';
import 'helpers/helper_methods.dart';
import 'welcome_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    loadInitialData();
    super.initState();
  }

  loadInitialData() async {
    await Future.delayed(const Duration(seconds: 2));
    await setInitValue();

    bool isFirstTime = appData.read(kKeyIsFirstTime) ?? true;
    bool isLoggedIn = appData.read(kKeyIsLoggedIn) ?? false;

    print("First Time: $isFirstTime, Logged In: $isLoggedIn");

    if (isFirstTime== true) {
      // First time user - show onboarding
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    } else if (isLoggedIn) {
      // User is logged in - go to main app
      String token = appData.read(kKeyAccessToken) ?? '';
      DioSingleton.instance.update(token);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CustomBottomNavBar()),
      );
    } else {
      // User is not first time and not logged in - go to login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
      // Or use NavigationService if preferred:
      // NavigationService.navigateToReplacement(Routes.loginScreen);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Show welcome screen while loading
    if (_isLoading) {
      return const WelcomeScreen();
    }

    // This part will rarely be used as navigation happens in loadInitialData
    // But it's kept as a fallback
    bool isFirstTime = appData.read(kKeyIsFirstTime) ?? true;
    bool isLoggedIn = appData.read(kKeyIsLoggedIn) ?? false;

    if (isFirstTime) {
      return OnboardingScreen();
    } else if (isLoggedIn) {
      return const CustomBottomNavBar();
    } else {
      return const LoginScreen();
    }
  }
}