import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:kashirons_flutter/feature/brobrain_gift_list/model/gift_details_model.dart';
import 'package:kashirons_flutter/feature/spark/model/spark_show_model.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

class GiftDetailsApi {
  static final GiftDetailsApi _singleton = GiftDetailsApi._internal();

  GiftDetailsApi._internal();

  static GiftDetailsApi get instance => _singleton;

  Future<GiftDetailsModel> giftDetailsApi({required dynamic id}) async {
    try {
      Response response = await getHttp(
        Endpoints.giftDetailsApi(id: id),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(json.encode(response.data));

        return GiftDetailsModel.fromJson(data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      throw ErrorHandler.handle(error).failure;
    }
  }
}
