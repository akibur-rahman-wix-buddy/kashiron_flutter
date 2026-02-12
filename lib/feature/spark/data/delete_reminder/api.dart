import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:kashirons_flutter/networks/dio/dio.dart';
import 'package:kashirons_flutter/networks/endpoints.dart';
import 'package:kashirons_flutter/networks/exception_handler/data_source.dart';

final class ReminderDeleteApi {
  static final ReminderDeleteApi _singleton = ReminderDeleteApi._internal();

  ReminderDeleteApi._internal();

  static ReminderDeleteApi get instance => _singleton;

  Future<Map<String, dynamic>> reminderDeleteApi({
    required String id,
  }) async {
    try {
      Map<String, dynamic> data = {
        "id": id,
      };
      Response response =
          (await deleteHttp(Endpoints.reminderDelete(id: id), data));

      if (response.statusCode == 200 || response.statusCode == 201) {
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
