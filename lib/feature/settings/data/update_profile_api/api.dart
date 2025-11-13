import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kashirons_flutter/helpers/toast.dart';
import 'package:kashirons_flutter/networks/dio/dio.dart';
import 'package:kashirons_flutter/networks/endpoints.dart';
import 'package:kashirons_flutter/networks/exception_handler/data_source.dart';

final class UpdateProfileApi {
  static final UpdateProfileApi _singleton = UpdateProfileApi._internal();

  UpdateProfileApi._internal();

  static UpdateProfileApi get instance => _singleton;

  Future<Map<String, dynamic>> updateProfileData({
    required String name,
    required String dateOfBirth,
    XFile? avatar,
  }) async {
    try {
      // Create FormData for multipart request
      FormData formData = FormData.fromMap({
        "name": name,
        "date_of_birth": dateOfBirth,
      });

      // Add avatar file if provided
      if (avatar != null) {
        formData.files.add(MapEntry(
          'avatar',
          await MultipartFile.fromFile(
            avatar.path,
            filename: avatar.name.split('/').last, // Extract filename from path
          ),
        ));
      }

      // Make the POST request - Use correct endpoint for profile update
      Response response = (await postHttp(Endpoints.updateProfile(), formData));

      if (response.statusCode == 200) {
        final data = json.decode(json.encode(response.data));
        ToastUtil.showShortToast('Profile updated successfully');
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