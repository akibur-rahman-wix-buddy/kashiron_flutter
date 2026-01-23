import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:kashirons_flutter/feature/notification/data/notification_toggle/api.dart';
import 'package:kashirons_flutter/helpers/toast.dart';
import 'package:kashirons_flutter/networks/rx_base.dart';
import 'package:rxdart/rxdart.dart';
//
// final class NotificationToggleApiRx {
//   final api = NotificationToggleApi.instance;
//
//   Future<bool> notificationToggle({required dynamic id}) async {
//     try {
//       await api.notificationToggle(id: id);
//       return true;
//     } catch (error) {
//       _handleError(error);
//       return false;
//     }
//   }
//
//   void _handleError(dynamic error) {
//     String msg = "Something went wrong";
//
//     if (error is DioException) {
//       final res = error.response?.data;
//       if (res != null) {
//         if (res['message'] is Map) {
//           msg = res['message']
//               .values
//               .map((v) => v is List ? v.join(", ") : v.toString())
//               .join("\n");
//         } else if (res['message'] is String) {
//           msg = res['message'];
//         }
//       }
//     }
//
//     ToastUtil.showShortToast(msg);
//     log(error.toString(), stackTrace: StackTrace.current);
//   }
// }

final class NotificationToggleApiRx {
  final api = NotificationToggleApi.instance;

  Future<bool> notificationToggle({required dynamic id}) async {
    try {
      await api.notificationToggle(id: id);
      return true;
    } catch (error) {
      return false;
    }
  }
}
