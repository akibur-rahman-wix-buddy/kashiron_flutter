import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:kashirons_flutter/constants/app_constants.dart';
import 'package:kashirons_flutter/helpers/di.dart';
import 'package:rxdart/streams.dart';
import 'package:kashirons_flutter/helpers/toast.dart';
import 'package:kashirons_flutter/networks/rx_base.dart';
import 'package:rxdart/subjects.dart';

import '../../../../networks/dio/dio.dart';
import 'api.dart';


final class ResetPasswordRx extends RxResponseInt<Map<String, dynamic>> {
  final api = ResetPasswordApi.instance;

  ResetPasswordRx({required super.empty, required super.dataFetcher});
  final BehaviorSubject<Map<String, dynamic>> _dataFetcher = BehaviorSubject<Map<String, dynamic>>();

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> resetPasswordInfo({required String email,required dynamic setToken,required String password,required String password_confirmation,}) async {
    try {
      // Call the sign-in API
      Map<String, dynamic> data = await api.resetPasswordApi(email: email,setToken: setToken,
      password: password,password_confirmation: password_confirmation);

      await handleSuccessWithReturn(data);

      return true;
    } catch (error) {
      // Handle error
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(Map<String, dynamic> data) async {
    final token = data['data']["token"]["original"]['access_token'].toString();
    log("Login token: $token");

    await appData.write(kKeyAccessToken, token);
    await appData.write(kKeyIsLoggedIn, true);

    DioSingleton.instance.update(token);
    _dataFetcher.sink.add(data);
    return true;
  }

  @override
  handleErrorWithReturn(dynamic error) {
    // Handle API error using DioException
    if (error is DioException) {
      if (error.response!.statusCode == 400) {
        ToastUtil.showShortToast(error.response!.data["error"]);
      } else {
        ToastUtil.showShortToast(error.response!.data["message"]);
      }
    }

    log(error.toString());
    dataFetcher.sink.addError(error);

    return false;
  }
}
