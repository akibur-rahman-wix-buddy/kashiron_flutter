import 'package:dio/dio.dart';
import 'package:kashirons_flutter/networks/dio/dio.dart';
import 'package:kashirons_flutter/networks/endpoints.dart';
import 'package:kashirons_flutter/networks/exception_handler/data_source.dart';

final class NotificationToggleApi {
  static final NotificationToggleApi _singleton =
      NotificationToggleApi._internal();

  NotificationToggleApi._internal();
  static NotificationToggleApi get instance => _singleton;

  Future<Map<String, dynamic>> notificationToggle({
    required dynamic id,
  }) async {
    try {
      Response response = await postHttp(
        Endpoints.notificationToggle(id: id),
      );

      // Successful response
      if (response.statusCode == 200) {
        return response.data;
      } else {
        // Any other status code
        throw DataSource.DEFAULT.getFailure();
      }
    } on DioException catch (dioError) {
      throw dioError;
    } catch (error) {
      print("Error : $error");
      rethrow;
    }
  }
}
