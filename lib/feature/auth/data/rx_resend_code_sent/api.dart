import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:kashirons_flutter/networks/dio/dio.dart';
import 'package:kashirons_flutter/networks/endpoints.dart';

import '../../../../../networks/exception_handler/data_source.dart';


final class OtpResendApi {

  static final  OtpResendApi _singleton = OtpResendApi._internal();

  OtpResendApi._internal();

  static  OtpResendApi get instance => _singleton;

  Future<Map<String, dynamic>> otpSentApi({required String email,required String action,}) async {
    try {
      // Create the request data map
      Map<String, dynamic> data = {
        "email": email,
        "action":action
      };
      // Make the POST request
      Response response = (await postHttp(Endpoints.postResendApiLink(), data));

      if (response.statusCode == 200) {
        final data = json.decode(json.encode(response.data));
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
