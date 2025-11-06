// import 'dart:convert';
// import 'package:dio/dio.dart';
// import 'package:kashirons_flutter/helpers/toast.dart';
// import 'package:kashirons_flutter/networks/dio/dio.dart';
// import 'package:kashirons_flutter/networks/endpoints.dart';
//
// import '../../../../../networks/exception_handler/data_source.dart';
//
//
// final class OtpForgetApi {
//
//   static final  OtpForgetApi _singleton = OtpForgetApi._internal();
//
//   OtpForgetApi._internal();
//
//   static  OtpForgetApi get instance => _singleton;
//
//   Future<Map<String, dynamic>> forgetOtpApi({required String email,required String otp,required String action}) async {
//     try {
//       // Create the request data map
//       Map<String, dynamic> data = {
//         "email": email,
//         "otp": otp,
//         "action":action
//       };
//       // Make the POST request
//       Response response = (await postHttp(Endpoints.otpForgetApiLink(), data));
//
//       if (response.statusCode == 200) {
//         final data = json.decode(json.encode(response.data));
//         ToastUtil.showShortToast('Verified successful');
//         return data;
//
//       } else {
//         throw DataSource.DEFAULT.getFailure();
//       }
//
//     } catch (error) {
//       print("Error during signup: $error");
//       rethrow;
//     }
//   }
// }
