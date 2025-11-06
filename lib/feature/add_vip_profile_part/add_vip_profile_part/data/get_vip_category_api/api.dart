





import 'dart:developer';

import 'package:kashirons_flutter/feature/add_vip_profile_part/add_vip_profile_part/model/relation_vip_data_model.dart';
import 'package:kashirons_flutter/feature/add_vip_profile_part/add_vip_profile_part/model/vip_category_data_model.dart';
import 'package:kashirons_flutter/networks/dio/dio.dart';
import 'package:kashirons_flutter/networks/endpoints.dart';
import 'package:kashirons_flutter/networks/exception_handler/data_source.dart';



final class GetVipCategoryApi {
  static final GetVipCategoryApi _singleton = GetVipCategoryApi._internal();
  GetVipCategoryApi._internal();

  static GetVipCategoryApi get instance => _singleton;

  Future<VipCategoryDataModel> getPeopleInfo() async {

    try {
      final response = await getHttp(Endpoints.getVipInterestList() );
      if (response.statusCode == 200) {
        return VipCategoryDataModel.fromJson(response.data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      log("Errlllor in API: $error");
      rethrow;
    }
  }
}
