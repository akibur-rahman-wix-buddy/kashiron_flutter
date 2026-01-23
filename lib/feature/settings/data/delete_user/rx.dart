import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:kashirons_flutter/feature/settings/data/delete_user/api.dart';
import 'package:kashirons_flutter/helpers/all_routes.dart';
import 'package:kashirons_flutter/helpers/navigation_service.dart';
import 'package:kashirons_flutter/helpers/toast.dart';
import 'package:kashirons_flutter/networks/rx_base.dart';
import 'package:rxdart/streams.dart';

final class DeleteUserApiRx extends RxResponseInt<Map<String, dynamic>> {
  final api = DeleteUserApi.instance;

  DeleteUserApiRx({
    required super.empty,
    required super.dataFetcher,
  });

  ValueStream<Map<String, dynamic>> get stream => dataFetcher.stream;

  Future<bool> deleteUser() async {
    try {
      final data = await api.deleteUserApi();

      handleSuccessWithReturn(data);
      return true;
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  void handleSuccessWithReturn(Map<String, dynamic> data) {
    dataFetcher.sink.add(data);
  }

  @override
  handleErrorWithReturn(dynamic e) {
    String msg = "Something went wrong";

    if (e is DioException) {
      final response = e.response;
      final d = response?.data;

      if (response?.statusCode == 401) {
        NavigationService.navigateTo(Routes.loginScreen);
        msg = d?["error"] ?? "Unauthorized";
      } else {
        final message = d?["message"];
        msg = message is String
            ? message
            : message is Map
                ? message.values.first.first
                : msg;
      }
    }

    ToastUtil.showShortToast(msg);
    log(e.toString());
    dataFetcher.sink.addError(e);
    return false;
  }
}
