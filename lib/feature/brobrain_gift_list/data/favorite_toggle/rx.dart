import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:kashirons_flutter/helpers/toast.dart';
import 'package:kashirons_flutter/networks/rx_base.dart';
import 'package:rxdart/streams.dart';
import 'api.dart';

final class FavoriteToggleApiRx extends RxResponseInt<Map<String, dynamic>> {
  final api = FavoriteToggleApi.instance;

  FavoriteToggleApiRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> favoriteToggle({
    required dynamic id,
  }) async {
    try {
      Map<String, dynamic> data = await api.favoriteToggle(id: id);
      await handleSuccessWithReturn(data);

      return true;
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(Map<String, dynamic> data) {
    dataFetcher.sink.add(data);

    return data;
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      final responseData = error.response?.data;

      if (error.response?.statusCode == 422) {
        // Handle validation errors
        final errorMessage = responseData is Map
            ? responseData["data"]?.toString() ?? "Validation failed"
            : "Validation failed";
        ToastUtil.showShortToast(errorMessage);
      } else if (error.response?.statusCode == 400) {
        ToastUtil.showShortToast(
            error.response!.data["error"]?.toString() ?? "Bad request");
      } else {
        ToastUtil.showShortToast(
            error.response!.data["message"]?.toString() ?? "An error occurred");
      }
    } else {
      ToastUtil.showShortToast("An unexpected error occurred");
    }

    log(error.toString());
    dataFetcher.sink.addError(error);
    return false;
  }
}
