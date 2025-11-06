import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:kashirons_flutter/helpers/toast.dart';
import 'package:kashirons_flutter/networks/dio/dio.dart';
import 'package:kashirons_flutter/networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';


final class OtpVerificationApi {

  static final  OtpVerificationApi _singleton = OtpVerificationApi._internal();

  OtpVerificationApi._internal();

  static  OtpVerificationApi get instance => _singleton;

  Future<Map<String, dynamic>> otpVerificationApi({required String email, required dynamic otp, required dynamic action}) async {
    try {
      // Create the request data map
      Map<String, dynamic> data = {
        "email": email,
        "otp": otp,
        "action":action
      };
      // Make the POST request
      Response response = (await postHttp(Endpoints.otpVerification(), data));

      if (response.statusCode == 200) {
        final data = json.decode(json.encode(response.data));
        ToastUtil.showShortToast(' Verification Successfully');
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
