import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kashirons_flutter/helpers/toast.dart';
import 'package:kashirons_flutter/networks/dio/dio.dart';
import 'package:kashirons_flutter/networks/endpoints.dart';
import 'package:kashirons_flutter/networks/exception_handler/data_source.dart';

final class ChangePasswordApi {
  static final ChangePasswordApi _singleton = ChangePasswordApi._internal();

  ChangePasswordApi._internal();

  static ChangePasswordApi get instance => _singleton;

  Future<Map<String, dynamic>> updatePasswordData({
    required String currentPassword,
    required String password,
    required String confirmPassword,

  }) async {
    try {
      // Create FormData for multipart request
      FormData formData = FormData.fromMap({
        "current_password": currentPassword,
        "password": password,
        "password_confirmation": confirmPassword,

      });


      // Make the POST request - Use correct endpoint for profile update
      Response response = (await postHttp(Endpoints.changePasswordApiLink(), formData));

      if (response.statusCode == 200) {
        final data = json.decode(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      print("Error during profile update: $error");
      rethrow;
    }
  }
}