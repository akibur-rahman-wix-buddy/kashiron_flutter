import 'dart:developer';
import 'package:kashirons_flutter/feature/settings/model/user_infi_data_model.dart';
import 'package:kashirons_flutter/networks/dio/dio.dart';
import 'package:kashirons_flutter/networks/endpoints.dart';
import 'package:kashirons_flutter/networks/exception_handler/data_source.dart';

final class GetUserProfileApi {
  static final GetUserProfileApi _singleton = GetUserProfileApi._internal();
  GetUserProfileApi._internal();

  static GetUserProfileApi get instance => _singleton;

  Future<GetUserProfileModelData> getUserPeopleInfo() async {
    try {
      final response = await getHttp(Endpoints.getUserProfileApiLink());
      if (response.statusCode == 200) {
        return GetUserProfileModelData.fromJson(response.data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      log("Errlllor in API: $error");
      rethrow;
    }
  }
}
