import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:kashirons_flutter/networks/dio/dio.dart';
import 'package:kashirons_flutter/networks/endpoints.dart';
import 'package:kashirons_flutter/networks/exception_handler/data_source.dart';

final class SparkUpdateApi {
  static final SparkUpdateApi _singleton = SparkUpdateApi._internal();

  SparkUpdateApi._internal();

  static SparkUpdateApi get instance => _singleton;

  Future<Map<String, dynamic>> sparkupdateApi(
      {required String vip_id,
      required String spark_id,
      required String title,
      required String description,
      required String date,
      required String time}) async {
    try {
      Map<String, dynamic> data = {
        "vip_id": vip_id,
        "title": title,
        "description": description,
        "date": date,
        "time": time,
      };
      Response response =
          (await postHttp(Endpoints.sparkUpdate(id: spark_id), data));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      print("Error during spark update: $error");
      rethrow;
    }
  }
}
