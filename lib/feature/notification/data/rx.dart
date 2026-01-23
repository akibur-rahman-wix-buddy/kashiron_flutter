import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:kashirons_flutter/constants/app_constants.dart';
import 'package:kashirons_flutter/feature/notification/data/api.dart';
import 'package:kashirons_flutter/feature/notification/model/notification_screen_model.dart';
import 'package:kashirons_flutter/helpers/all_routes.dart';
import 'package:kashirons_flutter/helpers/di.dart';
import 'package:kashirons_flutter/helpers/navigation_service.dart';
import 'package:kashirons_flutter/helpers/toast.dart';
import 'package:kashirons_flutter/networks/rx_base.dart';
import 'package:rxdart/rxdart.dart';

final class NotificationScreenApiRx
    extends RxResponseInt<NotificationScreenModel> {
  final api = NotificationScreenApi.instance;

  // Add a loading state controller
  final BehaviorSubject<bool> _isLoading = BehaviorSubject<bool>.seeded(false);

  NotificationScreenApiRx({required super.empty, required super.dataFetcher});

  ValueStream get getAvailableItemsStream => dataFetcher.stream;
  ValueStream<bool> get isLoadingStream => _isLoading.stream;
  NotificationScreenModel? get current => dataFetcher.valueOrNull;

  void emit(NotificationScreenModel model) {
    dataFetcher.sink.add(model);
  }

  void clearData() {
    dataFetcher.sink.add(empty);
    _isLoading.add(false);
  }

  Future<NotificationScreenModel?> getNotification() async {
    try {
      _isLoading.add(true); // Start loading
      final data = await api.notificationScreenApi();
      _isLoading.add(false); // Stop loading
      return handleSuccessWithReturn(data);
    } catch (error) {
      _isLoading.add(false); // Stop loading even on error
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleErrorWithReturn(dynamic error) {
    _isLoading.add(false); // Ensure loading is stopped
    if (error is DioException) {
      final statusCode = error.response?.statusCode;
      final errorMessage = error.response?.data?["error"] ??
          error.response?.data?["message"] ??
          "An unknown error occurred.";

      if (statusCode == 401) {
        appData.write(kKeyIsLoggedIn, false);
        NavigationService.navigateToUntilReplacement(Routes.loginScreen);
      } else {
        ToastUtil.showShortToast(errorMessage);
      }
    } else {
      ToastUtil.showShortToast("An unexpected error occurred.");
    }

    log(error.toString());
    dataFetcher.sink.addError(error);
    return null;
  }

  @override
  void dispose() {
    _isLoading.close();
    super.dispose();
  }
}
