import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:kashirons_flutter/feature/brobrain_gift_list/model/popular_products_model.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

class PopularProductsApi {
  static final PopularProductsApi _singleton = PopularProductsApi._internal();
  PopularProductsApi._internal();

  static PopularProductsApi get instance => _singleton;

  Future<PopularProductsModel> popularProductsApi() async {
    try {
      Response response = await getHttp(
        Endpoints.popularProducts(),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(json.encode(response.data));

        return PopularProductsModel.fromJson(data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      throw ErrorHandler.handle(error).failure;
    }
  }
}
