import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:kashirons_flutter/helpers/toast.dart';
import 'package:kashirons_flutter/networks/dio/dio.dart';
import 'package:kashirons_flutter/networks/endpoints.dart';
import 'package:kashirons_flutter/networks/exception_handler/data_source.dart';

final class DeleteUserApi {
  static final DeleteUserApi _singleton = DeleteUserApi._internal();

  DeleteUserApi._internal();

  static DeleteUserApi get instance => _singleton;

  Future<Map<String, dynamic>> deleteUserApi() async {
    try {
      Response response = (await deleteHttp(Endpoints.deleteUser()));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(json.encode(response.data));
        ToastUtil.showShortToast('User Deleted Successfully');
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
