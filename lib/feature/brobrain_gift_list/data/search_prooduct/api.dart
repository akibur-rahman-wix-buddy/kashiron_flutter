import 'package:dio/dio.dart';
import 'package:kashirons_flutter/feature/brobrain_gift_list/model/search_products_model.dart';
import 'package:kashirons_flutter/networks/dio/dio.dart';
import 'package:kashirons_flutter/networks/endpoints.dart';
import 'package:kashirons_flutter/networks/exception_handler/data_source.dart';

final class SearchProductApi {
  static final SearchProductApi _singleton = SearchProductApi._internal();
  SearchProductApi._internal();

  static SearchProductApi get instance => _singleton;
  Future<SearchProductsModel> searchProductsApi(String keyword) async {
    try {
      Response response =
          await getHttp(Endpoints.searchProduct(keyword: keyword));
      if (response.statusCode == 200) {
        final data = SearchProductsModel.fromJson(response.data);
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
