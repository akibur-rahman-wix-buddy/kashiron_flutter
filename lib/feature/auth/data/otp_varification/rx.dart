import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:kashirons_flutter/constants/app_constants.dart';
import 'package:kashirons_flutter/helpers/di.dart';
import 'package:kashirons_flutter/helpers/toast.dart';
import 'package:kashirons_flutter/networks/dio/dio.dart';
import 'package:kashirons_flutter/networks/rx_base.dart';
import 'package:rxdart/streams.dart';

import 'api.dart';

final class OtpVerificationRx extends RxResponseInt<Map<String, dynamic>> {
  final api = OtpVerificationApi.instance;

  OtpVerificationRx({required super.empty, required super.dataFetcher});


  ValueStream get getFileData => dataFetcher.stream;

   String? setToken ;

  Future<bool> otpVerification({
    required String email,
    required dynamic otp,
    required dynamic action,
  }) async {
    try {
      Map<String, dynamic> data =
      await api.otpVerificationApi(email:email , otp: otp,action: action);


      await handleSuccessWithReturn(data);

      return true;
    } catch (error) {
      // Handle error
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(Map<String, dynamic> data) {



    setToken = data["data"]["set_token"];

    print(">>>>>>>>>>>>>>>>> here is the token ");
    print(">>>>>>>>>>>>>>>>> here is the token ${data["data"]["set_token"]}");

    dataFetcher.sink.add(data);

    return data;
  }

  @override
  handleErrorWithReturn(dynamic error) {
    // Handle API error using DioException
    if (error is DioException) {
      if (error.response != null) {
        if (error.response!.statusCode == 400) {
          // Show error message from the response
          ToastUtil.showShortToast(error.response!.data["message"]);
        } else {
          // Show general message for other status codes
          ToastUtil.showShortToast(error.response!.data["message"]);
        }
      } else {
        // Handle case when response is null
        ToastUtil.showShortToast("No response data available");
      }
    }

    // Log the error and add it to the stream
    log(error.toString());
    dataFetcher.sink.addError(error);

    return false;
  }

}
