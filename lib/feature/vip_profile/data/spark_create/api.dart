import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:kashirons_flutter/networks/dio/dio.dart';
import 'package:kashirons_flutter/networks/endpoints.dart';
import 'package:kashirons_flutter/networks/exception_handler/data_source.dart';

final class SparkCreateApi {
  static final SparkCreateApi _singleton = SparkCreateApi._internal();

  SparkCreateApi._internal();

  static SparkCreateApi get instance => _singleton;

  Future<Map<String, dynamic>> sparkCreateApi(
      {required dynamic vip_id,
      required dynamic title,
      required dynamic description,
      required dynamic date,
      required dynamic time}) async {
    try {
      Map<String, dynamic> data = {
        "vip_id": vip_id,
        "title": title,
        "description": description,
        "date": date,
        "time": time,
      };
      Response response = (await postHttp(Endpoints.sparkCreate(), data));

      if (response.statusCode == 200) {
        final data = json.decode(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      print("Error during spark create: $error");
      rethrow;
    }
  }
}
