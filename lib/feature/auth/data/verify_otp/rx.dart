// import 'dart:developer';
// import 'package:dio/dio.dart';
// import 'package:rxdart/streams.dart';
// import 'package:kashirons_flutter/helpers/toast.dart';
// import 'package:kashirons_flutter/networks/rx_base.dart';
//
// import 'api.dart';
//
//
// final class OtpForgetRx extends RxResponseInt<Map<String, dynamic>> {
//   final api = OtpForgetApi.instance;
//
//   OtpForgetRx({required super.empty, required super.dataFetcher});
//
//   String? setToken;
//
//   ValueStream get getFileData => dataFetcher.stream;
//
//   Future<bool> forgetOtpInfo({required String email,required String otp,required String action}) async {
//     try {
//       // Call the sign-in API
//       Map<String, dynamic> data = await api.forgetOtpApi(email: email,otp:otp,action: action );
//
//       await handleSuccessWithReturn(data);
//
//       return true;
//     } catch (error) {
//       // Handle error
//       return await handleErrorWithReturn(error);
//     }
//   }
//
//   @override
//   handleSuccessWithReturn(Map<String, dynamic> data) {
//     print(" this is token>>>>>>>>>>>>>>>>>>>> no data}");
//     // print(" this is token>>>>>>>>>>>>>>>>>>>> ${data["data"]["set_token"]}");
//
//
//     return data;
//   }
//
//   @override
//   handleErrorWithReturn(dynamic error) {
//     // Handle API error using DioException
//     if (error is DioException) {
//       if (error.response!.statusCode == 400) {
//         ToastUtil.showShortToast(error.response!.data["message"]);
//       } else {
//         ToastUtil.showShortToast(error.response!.data["message"]);
//       }
//     }
//
//     log(error.toString());
//     dataFetcher.sink.addError(error);
//
//     return false;
//   }
// }
