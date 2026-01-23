import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:kashirons_flutter/constants/app_constants.dart';
import 'package:kashirons_flutter/feature/brobrain_gift_list/data/gift_details/api.dart';
import 'package:kashirons_flutter/feature/brobrain_gift_list/model/gift_details_model.dart';
import 'package:kashirons_flutter/helpers/all_routes.dart';
import 'package:kashirons_flutter/helpers/di.dart';
import 'package:kashirons_flutter/helpers/navigation_service.dart';
import 'package:kashirons_flutter/helpers/toast.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../../networks/exception_handler/data_source.dart';
import '../../../../../../networks/rx_base.dart';

final class GiftDetailsApiRx extends RxResponseInt<GiftDetailsModel> {
  final api = GiftDetailsApi.instance;

  GiftDetailsApiRx({required super.empty, required super.dataFetcher});

  ValueStream<GiftDetailsModel> get ServiceName => dataFetcher.stream;

  Future<void> getGiftDetails({required dynamic id}) async {
    try {
      GiftDetailsModel allData = await api.giftDetailsApi(id: id);
      handleSuccessWithReturn(allData);
    } catch (error) {
      handleErrorWithReturn(ErrorHandler.handle(error).failure);
    }
  }

  @override
  handleSuccessWithReturn(GiftDetailsModel data) {
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
