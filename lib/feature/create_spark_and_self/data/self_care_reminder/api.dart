import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:kashirons_flutter/networks/dio/dio.dart';
import 'package:kashirons_flutter/networks/endpoints.dart';
import 'package:kashirons_flutter/networks/exception_handler/data_source.dart';

final class SelfReminderApi {
  static final SelfReminderApi _singleton = SelfReminderApi._internal();

  SelfReminderApi._internal();

  static SelfReminderApi get instance => _singleton;

  Future<Map<String, dynamic>> selfReminderApi(
      {required String title,
      required String description,
      required String date,
      required String time}) async {
    try {
      Map<String, dynamic> data = {
        "title": title,
        "description": description,
        "date": date,
        "time": time,
      };
      Response response = (await postHttp(Endpoints.selfReminder(), data));

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
