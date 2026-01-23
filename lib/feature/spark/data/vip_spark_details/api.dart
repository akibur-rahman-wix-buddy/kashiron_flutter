import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:kashirons_flutter/feature/spark/model/spark_show_model.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

class VipSparksDetailsApi {
  static final VipSparksDetailsApi _singleton = VipSparksDetailsApi._internal();

  VipSparksDetailsApi._internal();

  static VipSparksDetailsApi get instance => _singleton;

  Future<SparkShowModel> vipSparksDetailsApi({required dynamic id}) async {
    try {
      Response response = await getHttp(
        Endpoints.sparkDetails(id: id),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(json.encode(response.data));

        return SparkShowModel.fromJson(data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      throw ErrorHandler.handle(error).failure;
    }
  }
}
