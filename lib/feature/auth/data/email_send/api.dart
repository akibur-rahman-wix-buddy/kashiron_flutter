import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:kashirons_flutter/helpers/toast.dart';
import 'package:kashirons_flutter/networks/dio/dio.dart';
import 'package:kashirons_flutter/networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';


final class EmailForgetApi {

  static final  EmailForgetApi _singleton = EmailForgetApi._internal();

  EmailForgetApi._internal();

  static  EmailForgetApi get instance => _singleton;

  Future<Map<String, dynamic>> forgetEmailApi({required String email,}) async {
    try {
      // Create the request data map
      Map<String, dynamic> data = {
        "email": email,
      };
      // Make the POST request
      Response response = (await postHttp(Endpoints.forgetPassword(), data));

      if (response.statusCode == 200) {
        final data = json.decode(json.encode(response.data));
        ToastUtil.showShortToast('OTP send success');
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
