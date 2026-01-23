import 'dart:developer';
import 'package:kashirons_flutter/feature/notification/model/notification_screen_model.dart';
import 'package:kashirons_flutter/feature/settings/model/upcomng_sparks.dart';
import 'package:kashirons_flutter/networks/dio/dio.dart';
import 'package:kashirons_flutter/networks/endpoints.dart';
import 'package:kashirons_flutter/networks/exception_handler/data_source.dart';

final class NotificationScreenApi {
  static final NotificationScreenApi _singleton =
      NotificationScreenApi._internal();
  NotificationScreenApi._internal();

  static NotificationScreenApi get instance => _singleton;

  Future<NotificationScreenModel> notificationScreenApi() async {
    try {
      final response = await getHttp(Endpoints.getNotification());
      if (response.statusCode == 200) {
        return NotificationScreenModel.fromJson(response.data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      log("Error in API: $error");
      rethrow;
    }
  }
}
