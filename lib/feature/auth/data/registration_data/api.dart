// import 'dart:convert';
// import 'package:dio/dio.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:kashirons_flutter/helpers/toast.dart';
// import 'package:kashirons_flutter/networks/dio/dio.dart';
// import 'package:kashirons_flutter/networks/endpoints.dart';
// import 'package:kashirons_flutter/networks/exception_handler/data_source.dart';
//
// final class SignUpApi {
//   static final SignUpApi _singleton = SignUpApi._internal();
//
//   SignUpApi._internal();
//
//   static SignUpApi get instance => _singleton;
//
//   Future<Map<String, dynamic>> signInApi(
//       {
//         required String name,
//       required dynamic dateOfBirth,
//       required String email,
//          XFile? avatar
//       }) async {
//     try {
//       // Create the request data map
//       Map<String, dynamic> data = {
//         "email": email,
//         "date_of_birth": dateOfBirth,
//         "name": name,
//
//          'avatar': avatar!= null? await MultipartFile.fromFile(avatar.path):null
//       };
//       // Make the POST request
//       Response response = (await postHttp(Endpoints.signUp(), data));
//
//       if (response.statusCode == 200) {
//         final data = json.decode(json.encode(response.data));
//         ToastUtil.showShortToast('Register Successfully');
//         return data;
//       } else {
//         throw DataSource.DEFAULT.getFailure();
//       }
//     } catch (error) {
//       print("Error during signup: $error");
//       rethrow;
//     }
//   }
// }



import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kashirons_flutter/helpers/toast.dart';
import 'package:kashirons_flutter/networks/dio/dio.dart';
import 'package:kashirons_flutter/networks/endpoints.dart';
import 'package:kashirons_flutter/networks/exception_handler/data_source.dart';

final class SignUpApi {
  static final SignUpApi _singleton = SignUpApi._internal();

  SignUpApi._internal();

  static SignUpApi get instance => _singleton;

  Future<Map<String, dynamic>> signInApi({
    required String name,
    required String dateOfBirth,
    required String email,
    XFile? avatar,
  }) async {
    try {
      // Create FormData for multipart request
      FormData formData = FormData.fromMap({
        "email": email,
        "date_of_birth": dateOfBirth,
        "name": name,
      });

      // Add avatar file if exists
      if (avatar != null) {
        formData.files.add(MapEntry(
          'avatar',
          await MultipartFile.fromFile(
            avatar.path,
            filename: avatar.name, // Optional: provide filename
          ),
        ));
      }

      // Make the POST request with FormData
      Response response = await postHttp(Endpoints.signUp(), formData);

      if (response.statusCode == 200) {
        final data = json.decode(json.encode(response.data));
        ToastUtil.showShortToast('Register Successfully');
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      print("Error during signup: $error");
      rethrow;
    }
  }
}