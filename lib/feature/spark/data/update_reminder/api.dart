import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:kashirons_flutter/networks/dio/dio.dart';
import 'package:kashirons_flutter/networks/endpoints.dart';
import 'package:kashirons_flutter/networks/exception_handler/data_source.dart';

final class ReminderUpdateApi {
  static final ReminderUpdateApi _singleton = ReminderUpdateApi._internal();

  ReminderUpdateApi._internal();

  static ReminderUpdateApi get instance => _singleton;

  Future<Map<String, dynamic>> reminderUpdateApi(
      {required String reminder_id,
      required String date,
      required String time}) async {
    try {
      Map<String, dynamic> data = {
        "date": date,
        "time": time,
      };
      Response response =
          (await postHttp(Endpoints.reminderUpdate(id: reminder_id), data));

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
