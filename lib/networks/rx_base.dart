import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:kashirons_flutter/constants/app_constants.dart';
import 'package:kashirons_flutter/helpers/all_routes.dart';
import 'package:kashirons_flutter/helpers/di.dart';
import 'package:kashirons_flutter/helpers/navigation_service.dart';
import 'package:kashirons_flutter/helpers/toast.dart';
import 'package:rxdart/subjects.dart';

// abstract class RxResponseInt<T> {
//   T empty;
//   BehaviorSubject<T> dataFetcher;
//   Map? map;
//   BehaviorSubject? dataFetcher2;
//
//   RxResponseInt(
//       {required this.empty,
//       required this.dataFetcher,
//       this.map,
//       this.dataFetcher2});
//
//   dynamic handleSuccessWithReturn(T data) {
//     dataFetcher.sink.add(data);
//     return data;
//   }
//
//   dynamic handleErrorWithReturn(dynamic error) {
//     log(error.toString());
//     dataFetcher.sink.addError(error);
//     throw error;
//   }
//
//   void clean() {
//     dataFetcher.sink.add(empty);
//   }
//
//   void dispose() {
//     dataFetcher.close();
//   }
// }

abstract class RxResponseInt<T> {
  T empty;
  BehaviorSubject<T> dataFetcher;
  Map? map;
  BehaviorSubject? dataFetcher2;

  RxResponseInt(
      {required this.empty,
      required this.dataFetcher,
      this.map,
      this.dataFetcher2});

  dynamic handleSuccessWithReturn(T data) {
    dataFetcher.sink.add(data);
    return data;
  }

  dynamic handleErrorWithReturn(dynamic error) {
    log(error.toString());

    // Check for 401 Unauthorized error
    if (error is DioException) {
      final statusCode = error.response?.statusCode;

      // Authentication - MUST have
      if (statusCode == 401) {
        appData.write(kKeyIsLoggedIn, false);
        NavigationService.navigateToUntilReplacement(Routes.loginScreen);
        ToastUtil.showShortToast("Session expired. Please login again.");
      }

      // No internet - MUST have
      else if (error.type == DioExceptionType.connectionError) {
        ToastUtil.showShortToast("No internet connection");
      }

      // Timeouts - MUST have
      else if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        ToastUtil.showShortToast("Connection timeout");
      }

      // Server errors - SHOULD have
      else if (statusCode == 500) {
        ToastUtil.showShortToast("Server error. Please try again.");
      }
    }

    dataFetcher.sink.addError(error);
    throw error;
  }

  void clean() {
    dataFetcher.sink.add(empty);
  }

  void dispose() {
    dataFetcher.close();
  }
}
