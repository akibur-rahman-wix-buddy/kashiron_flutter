import 'package:flutter/material.dart';
import 'constants/app_constants.dart';

import 'feature/onboarding/presentation/onboarding_screen.dart';
import 'helpers/di.dart';
import 'helpers/helper_methods.dart';
import 'networks/dio/dio.dart';
import 'welcome_screen.dart';

final class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool _isLoading = true;
  bool isFirstTime = false;

  @override
  void initState() {
    loadInitialData();

    super.initState();
  }

  loadInitialData() async {
    //AutoAppUpdateUtil.instance.checkAppUpdate();
    await setInitValue();

    if (appData.read(kKeyIsLoggedIn)) {
      String token = appData.read(kKeyAccessToken);
      DioSingleton.instance.update(token);
    } else {
      //  NotificationService().cancelAllNotifications();
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const OnboardingScreen();
    } else {
      return appData.read(kKeyIsLoggedIn)
          ? OnboardingScreen()
          : appData.read(kKeyfirstTime)
              ? OnboardingScreen() //AuthRuleScreen()
              : OnboardingScreen();
    }
    /* return TimeAppointmentScreen();

              ? HomeScreen()
              : HomeScreen();
    }
    */
  }
}
