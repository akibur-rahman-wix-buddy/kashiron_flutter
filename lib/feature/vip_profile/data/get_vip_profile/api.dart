import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:kashirons_flutter/feature/home_screen/model/home_api_data_model.dart';
import 'package:kashirons_flutter/feature/vip_profile/model/vip_profile_list_model.dart';
import 'package:kashirons_flutter/feature/vip_profile/model/vip_profile_model.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

class GetVipProfileApi {
  static final GetVipProfileApi _singleton = GetVipProfileApi._internal();

  GetVipProfileApi._internal();

  static GetVipProfileApi get instance => _singleton;

  Future<VipProfileModel> getVipProfileApi({required dynamic id}) async {
    try {
      Response response = await getHttp(
        Endpoints.getVipProfile(id: id),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(json.encode(response.data));

        return VipProfileModel.fromJson(data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      throw ErrorHandler.handle(error).failure;
    }
  }
}
