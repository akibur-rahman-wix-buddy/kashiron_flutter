import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:kashirons_flutter/feature/home_screen/model/home_api_data_model.dart';
import 'package:kashirons_flutter/feature/vip_profile/model/vip_profile_list_model.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

class GetVipProfileListApi {
  static final GetVipProfileListApi _singleton =
      GetVipProfileListApi._internal();
  GetVipProfileListApi._internal();

  static GetVipProfileListApi get instance => _singleton;

  Future<VipProfileListModel> getVipProfileListApi() async {
    try {
      Response response = await getHttp(
        Endpoints.getVipProfileList(),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(json.encode(response.data));

        return VipProfileListModel.fromJson(data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      throw ErrorHandler.handle(error).failure;
    }
  }
}
