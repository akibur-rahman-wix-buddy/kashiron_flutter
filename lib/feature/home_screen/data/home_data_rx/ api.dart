import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:kashirons_flutter/feature/home_screen/model/home_api_data_model.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

class HomeApiDataApi  {
  static final HomeApiDataApi _singleton = HomeApiDataApi._internal();
  HomeApiDataApi._internal();

  static HomeApiDataApi get instance => _singleton;

  Future<HomeApiDataModel> homeApiDataapiData() async {
    try {
      Response response = await getHttp(
        Endpoints.homeDataApiLink(),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data =
        json.decode(json.encode(response.data));

        return HomeApiDataModel.fromJson(data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      throw ErrorHandler.handle(error).failure;
    }
  }
}

