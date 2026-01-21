import 'dart:developer';
import 'package:kashirons_flutter/feature/settings/data/model/upcomng_sparks.dart';
import 'package:kashirons_flutter/networks/dio/dio.dart';
import 'package:kashirons_flutter/networks/endpoints.dart';
import 'package:kashirons_flutter/networks/exception_handler/data_source.dart';

final class UpcomingSparksApi {
  static final UpcomingSparksApi _singleton = UpcomingSparksApi._internal();
  UpcomingSparksApi._internal();

  static UpcomingSparksApi get instance => _singleton;

  Future<UpcomingSparksModel> upcomingSparksApi() async {
    try {
      final response = await getHttp(Endpoints.upcomingSparks());
      if (response.statusCode == 200) {
        return UpcomingSparksModel.fromJson(response.data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      log("Error in API: $error");
      rethrow;
    }
  }
}
