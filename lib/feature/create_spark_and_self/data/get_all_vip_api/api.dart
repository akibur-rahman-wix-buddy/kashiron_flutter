
import 'dart:developer';
import 'package:kashirons_flutter/feature/create_spark_and_self/model/get_all_vip_data_model.dart';
import 'package:kashirons_flutter/networks/dio/dio.dart';
import 'package:kashirons_flutter/networks/endpoints.dart';
import 'package:kashirons_flutter/networks/exception_handler/data_source.dart';



final class GetAllVipApi {
  static final GetAllVipApi _singleton = GetAllVipApi._internal();
  GetAllVipApi._internal();

  static GetAllVipApi get instance => _singleton;

  Future<GetAllVipModelData> getVipPeopleInfo() async {

    try {
      final response = await getHttp(Endpoints.getVipRelationList() );
      if (response.statusCode == 200) {
        return GetAllVipModelData.fromJson(response.data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      log("Errlllor in API: $error");
      rethrow;
    }
  }
}
