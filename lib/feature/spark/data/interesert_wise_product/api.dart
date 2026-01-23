import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:kashirons_flutter/feature/spark/model/interest_wise_product_model.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

class InterestWiseProductApi {
  static final InterestWiseProductApi _singleton =
      InterestWiseProductApi._internal();

  InterestWiseProductApi._internal();

  static InterestWiseProductApi get instance => _singleton;

  Future<VipInterestWiseProductModel> interestWiseProductApi(
      {required dynamic id}) async {
    try {
      Response response = await getHttp(
        Endpoints.interestWiseProduct(id: id),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(json.encode(response.data));

        return VipInterestWiseProductModel.fromJson(data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      throw ErrorHandler.handle(error).failure;
    }
  }
}
