





import 'dart:developer';

import 'package:kashirons_flutter/feature/add_vip_profile_part/add_vip_profile_part/model/relation_vip_data_model.dart';
import 'package:kashirons_flutter/networks/dio/dio.dart';
import 'package:kashirons_flutter/networks/endpoints.dart';
import 'package:kashirons_flutter/networks/exception_handler/data_source.dart';



final class GetVipRelationshipAPi {
  static final GetVipRelationshipAPi _singleton = GetVipRelationshipAPi._internal();
  GetVipRelationshipAPi._internal();

  static GetVipRelationshipAPi get instance => _singleton;

  Future<RelationDataModel> getPeopleInfo() async {

    try {
      final response = await getHttp(Endpoints.getVipRelationshipList() );
      if (response.statusCode == 200) {
        return RelationDataModel.fromJson(response.data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      log("Errlllor in API: $error");
      rethrow;
    }
  }
}
