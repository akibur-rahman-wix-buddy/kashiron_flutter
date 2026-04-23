import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:kashirons_flutter/constants/app_constants.dart';
import 'package:kashirons_flutter/feature/spark/data/interesert_wise_product/api.dart';
import 'package:kashirons_flutter/feature/spark/data/vip_spark_details/api.dart';
import 'package:kashirons_flutter/feature/spark/model/interest_wise_product_model.dart';
import 'package:kashirons_flutter/feature/spark/model/spark_show_model.dart';
import 'package:kashirons_flutter/helpers/all_routes.dart';
import 'package:kashirons_flutter/helpers/di.dart';
import 'package:kashirons_flutter/helpers/navigation_service.dart';
import 'package:kashirons_flutter/helpers/toast.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../../networks/exception_handler/data_source.dart';
import '../../../../../../networks/rx_base.dart';

final class InterestWiseProductApiRx
    extends RxResponseInt<VipInterestWiseProductModel> {
  final api = InterestWiseProductApi.instance;

  InterestWiseProductApiRx({required super.empty, required super.dataFetcher});

  ValueStream<VipInterestWiseProductModel> get ServiceName =>
      dataFetcher.stream;

  Future<void> getInterestWideProducts({required dynamic id}) async {
    try {
      VipInterestWiseProductModel allData =
          await api.interestWiseProductApi(id: id);
      handleSuccessWithReturn(allData);
    } catch (error) {
      handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(VipInterestWiseProductModel data) {
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
