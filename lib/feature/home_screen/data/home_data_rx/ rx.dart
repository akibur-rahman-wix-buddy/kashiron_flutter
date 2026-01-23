import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:kashirons_flutter/constants/app_constants.dart';
import 'package:kashirons_flutter/feature/home_screen/data/home_data_rx/%20api.dart';
import 'package:kashirons_flutter/feature/home_screen/model/home_api_data_model.dart';
import 'package:kashirons_flutter/helpers/all_routes.dart';
import 'package:kashirons_flutter/helpers/di.dart';
import 'package:kashirons_flutter/helpers/navigation_service.dart';
import 'package:kashirons_flutter/helpers/toast.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../../networks/exception_handler/data_source.dart';
import '../../../../../../networks/rx_base.dart';

final class HomeApiDataRx extends RxResponseInt<HomeApiDataModel> {
  final api = HomeApiDataApi.instance;

  HomeApiDataRx({required super.empty, required super.dataFetcher});

  ValueStream<HomeApiDataModel> get ServiceName => dataFetcher.stream;

  Future<void> homeApiDataApiInfo() async {
    try {
      HomeApiDataModel allData = await api.homeApiDataapiData();
      handleSuccessWithReturn(allData);
    } catch (error) {
      handleErrorWithReturn(ErrorHandler.handle(error).failure);
    }
  }

  @override
  handleSuccessWithReturn(HomeApiDataModel data) {
    dataFetcher.sink.add(data);
    return data;
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      final statusCode = error.response?.statusCode;
      final errorMessage = error.response?.data?["error"] ??
          error.response?.data?["message"] ??
          "An unknown error occurred.";

      if (statusCode == 401) {
        appData.write(kKeyIsLoggedIn, false);
        NavigationService.navigateToUntilReplacement(Routes.loginScreen);
      } else if (statusCode == 500) {
        ToastUtil.showShortToast("Internal Server Error");
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
}
