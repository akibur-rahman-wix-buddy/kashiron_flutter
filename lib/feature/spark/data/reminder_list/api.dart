import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:kashirons_flutter/feature/spark/model/reminder_list_model.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

class ReminderListApi {
  static final ReminderListApi _singleton = ReminderListApi._internal();

  ReminderListApi._internal();

  static ReminderListApi get instance => _singleton;

  Future<ReminderListModel> reminderListApiData() async {
    try {
      Response response = await getHttp(
        Endpoints.reminderList(),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(json.encode(response.data));

        return ReminderListModel.fromJson(data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      throw ErrorHandler.handle(error).failure;
    }
  }
}
