import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:kashirons_flutter/feature/brobrain_gift_list/data/search_prooduct/api.dart';
import 'package:kashirons_flutter/feature/brobrain_gift_list/model/search_products_model.dart';
import 'package:kashirons_flutter/helpers/all_routes.dart';
import 'package:kashirons_flutter/helpers/navigation_service.dart';
import 'package:kashirons_flutter/helpers/toast.dart';
import 'package:kashirons_flutter/networks/rx_base.dart';

class SearchProductApiRx extends RxResponseInt<SearchProductsModel> {
  final api = SearchProductApi.instance;
  SearchProductApiRx({required super.empty, required super.dataFetcher});

  Future<SearchProductsModel?> searchProduct(String keyword) async {
    try {
      SearchProductsModel data = await api.searchProductsApi(keyword);
      handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
    return null;
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      if (error.response!.statusCode == 400) {
        ToastUtil.showShortToast(error.response!.data["message"]);
      } else if (error.response!.statusCode == 401) {
        NavigationService.navigateTo(Routes.loginScreen);
      } else {
        ToastUtil.showShortToast(error.response!.data["message"]);
      }
    }
    log(error.toString());
    dataFetcher.sink.addError(error);
    return null;
  }
}
