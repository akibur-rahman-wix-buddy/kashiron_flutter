// import 'dart:developer';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
// import 'package:kashirons_flutter/helpers/all_routes.dart';
// import 'package:kashirons_flutter/helpers/navigation_service.dart';
// import 'package:kashirons_flutter/networks/endpoints.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:kashirons_flutter/constants/app_constants.dart';
// import 'package:kashirons_flutter/helpers/di.dart';
// import 'package:kashirons_flutter/helpers/toast.dart';
// import 'package:kashirons_flutter/networks/dio/dio.dart';
// import 'package:kashirons_flutter/networks/rx_base.dart';
// import 'api.dart';
//
// final class SignInApiRx extends RxResponseInt<Map<String, dynamic>> {
//   final api = SignInApi.instance;
//
//   static const Color dialogBackgroundColor = Color(0xFF1976D2);
//   final BehaviorSubject<Map<String, dynamic>> _dataFetcher = BehaviorSubject<Map<String, dynamic>>();
//
//   SignInApiRx({required super.empty, required super.dataFetcher});
//
//   ValueStream<Map<String, dynamic>> get getFileData => _dataFetcher.stream;
//
//   Future<bool> signIn({required String email, required String password}) async {
//     try {
//       final data = await api.signInApi(email: email, password: password);
//       return await handleSuccessWithReturn(data);
//     } catch (error) {
//       return await handleErrorWithReturn(_ErrorWithEmail(error, email)) as bool;
//     }
//   }
//
//   @override
//   Future<dynamic> handleSuccessWithReturn(Map<String, dynamic> data) async {
//     try {
//
//
//       if(data["data"]['email_verified_at'] == null|| data["data"]['email_verified_at'] =="null"){
//
//         NavigationService.navigateToWithArgs(Routes.signupOtpScreen, {
//           "email": data['data']['email'],
//           "isForgetScreen": false
//         });
//
//         ToastUtil.showLongToast(data["message"]);
//
//       }else if (data["data"]['set_token'] != null|| data["data"]['set_token'] !="null" ){
//
//         print(">>>>>>>>>>>>>>>> this is the set token ${data["data"]['set_token'].toString()}");
//         NavigationService.navigateToWithArgs(Routes.setPasswordScreen, {
//           "isForget":false,
//           "email": data['data']['email'].toString(),
//           "setToken":data["data"]['set_token'].toString()
//         });
//       }
//
//
//
//
//       final token = data['data']["token"]["original"]['access_token'].toString();
//       log("Login token: $token");
//
//       await appData.write(kKeyAccessToken, token);
//       await appData.write(kKeyIsLoggedIn, true);
//
//       DioSingleton.instance.update(token);
//       _dataFetcher.sink.add(data);
//       return true;
//     } catch (e) {
//       log("Error in handleSuccessWithReturn: $e");
//       _dataFetcher.sink.addError(e);
//       return false;
//     }
//   }
//
//   @override
//   dynamic handleErrorWithReturn(dynamic error) {
//     try {
//       if (error is _ErrorWithEmail) {
//         final dioError = error.error;
//         final email = error.email;
//
//         if (dioError is DioException) {
//           final response = dioError.response;
//
//           if (response?.statusCode == 400) {
//             ToastUtil.showShortToast(response?.data["error"] ?? "Bad request");
//           }
//           else if (response?.data["message"] == "Please verify your email address.") {
//             _showVerificationDialog(email);
//             return false;
//           }
//           else {
//             ToastUtil.showShortToast(response?.data["message"] ?? "An error occurred");
//           }
//         }
//         else {
//           log("Non-Dio error: $dioError");
//           ToastUtil.showShortToast("An unexpected error occurred");
//         }
//       }
//       else {
//         log("Unknown error type: $error");
//         ToastUtil.showShortToast("An unexpected error occurred");
//       }
//
//       _dataFetcher.sink.addError(error is _ErrorWithEmail ? error.error : error);
//       return false;
//     } catch (e) {
//       log("Error in handleErrorWithReturn: $e");
//       return false;
//     }
//   }
//
//   void _showVerificationDialog(String email) {
//     Get.dialog(
//       AlertDialog(
//         backgroundColor: AppColor.authBg,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         title: const Text(
//           "Please Verify Your Account",
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         content: Text(
//           "A verification link has been sent to your email. Please verify to continue.",
//           style: TextStyle(
//             color: Colors.white.withOpacity(0.9),
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Get.back();
//               // Get.to(() => VerifiedAccountScreen(email: email));
//             },
//             child: const Text(
//               "OK",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       ),
//       barrierDismissible: false,
//     );
//   }
//
//   void dispose() {
//     _dataFetcher.close();
//   }
// }
//
// // Helper class to wrap error with email
// class _ErrorWithEmail {
//   final dynamic error;
//   final String email;
//
//   _ErrorWithEmail(this.error, this.email);
// }



import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/helpers/all_routes.dart';
import 'package:kashirons_flutter/helpers/navigation_service.dart';
import 'package:kashirons_flutter/networks/endpoints.dart';
import 'package:rxdart/rxdart.dart';
import 'package:kashirons_flutter/constants/app_constants.dart';
import 'package:kashirons_flutter/helpers/di.dart';
import 'package:kashirons_flutter/helpers/toast.dart';
import 'package:kashirons_flutter/networks/dio/dio.dart';
import 'package:kashirons_flutter/networks/rx_base.dart';
import 'api.dart';

final class SignInApiRx extends RxResponseInt<Map<String, dynamic>> {
  final api = SignInApi.instance;

  static const Color dialogBackgroundColor = Color(0xFF1976D2);
  final BehaviorSubject<Map<String, dynamic>> _dataFetcher = BehaviorSubject<Map<String, dynamic>>();

  SignInApiRx({required super.empty, required super.dataFetcher});

  ValueStream<Map<String, dynamic>> get getFileData => _dataFetcher.stream;

  /// Sign In API call
  Future<bool> signIn({required String email, required String password}) async {
    try {
      final data = await api.signInApi(email: email, password: password);
      return await handleSuccessWithReturn(data, );
    } catch (error) {
      return await handleErrorWithReturn(_ErrorWithEmail(error, email)) as bool;
    }
  }

  @override
  Future<dynamic> handleSuccessWithReturn(Map<String, dynamic> data , ) async {
    try {
      final userData = data['data'] ?? {};

      final emailVerifiedAt = userData['email_verified_at'];



      final accessToken = userData['token']?['original']?['access_token'];
      if (accessToken == null || accessToken == "null") {
        log("Access token is null!");
        print(">>>>>>>>>>>>> email = ${data["data"]["email"]}");
        // Navigate to OTP / email verification screen
        NavigationService.navigateToWithArgs(Routes.signupOtpScreen, {
          "email": data["data"]["email"],
          "isForgetScreen": false
        });
        ToastUtil.showShortToast("Login failed: token missing.");
        return false;
      }


      if (emailVerifiedAt == null || emailVerifiedAt == "null") {
        print(">>>>>>>>>>>>> email = ${data["data"]["email"]}");
        // Navigate to OTP / email verification screen
        NavigationService.navigateToWithArgs(Routes.signupOtpScreen, {
          "email": data["data"]["email"],
          "isForgetScreen": false
        });

        ToastUtil.showLongToast(data["message"] ?? "Please verify your email.");
        return false;
      }

      //
      // // Case 2: Account has set_token (force set password)
      // if (setToken != null && setToken != "null") {
      //   NavigationService.navigateToWithArgs(Routes.setPasswordScreen, {
      //     "isForget": false,
      //     "email": userData['email']?.toString() ?? "",
      //     "setToken": setToken.toString()
      //   });
      //   return false;
      // }

      final token = accessToken.toString();
      log("Login token: $token");

      await appData.write(kKeyAccessToken, token);
      await appData.write(kKeyIsLoggedIn, true);

      DioSingleton.instance.update(token);

      _dataFetcher.sink.add(data);
      return true;
    } catch (e) {
      log("Error in handleSuccessWithReturn: $e");
      _dataFetcher.sink.addError(e);
      return false;
    }
  }


  @override
  dynamic handleErrorWithReturn(dynamic error) {
    try {
      if (error is _ErrorWithEmail) {
        final dioError = error.error;
        final email = error.email;

        if (dioError is DioException) {
          final response = dioError.response;

          if (response?.statusCode == 400) {
            ToastUtil.showShortToast(response?.data["error"] ?? "Bad request");
          } else if (response?.data["message"] == "Please verify your email address.") {
            _showVerificationDialog(email);
            return false;
          } else {
            ToastUtil.showShortToast(response?.data["message"] ?? "An error occurred");
          }
        } else {
          log("Non-Dio error: $dioError");
          ToastUtil.showShortToast("An unexpected error occurred");
        }
      } else {
        log("Unknown error type: $error");
        ToastUtil.showShortToast("An unexpected error occurred");
      }

      _dataFetcher.sink.addError(error is _ErrorWithEmail ? error.error : error);
      return false;
    } catch (e) {
      log("Error in handleErrorWithReturn: $e");
      return false;
    }
  }

  void _showVerificationDialog(String email) {
    Get.dialog(
      AlertDialog(
        backgroundColor: AppColor.authBg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: const Text(
          "Please Verify Your Account",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          "A verification link has been sent to your email. Please verify to continue.",
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              // Navigate to VerifiedAccountScreen if needed
            },
            child: const Text(
              "OK",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  void dispose() {
    _dataFetcher.close();
  }
}

/// Helper class to wrap error with email
class _ErrorWithEmail {
  final dynamic error;
  final String email;

  _ErrorWithEmail(this.error, this.email);
}
