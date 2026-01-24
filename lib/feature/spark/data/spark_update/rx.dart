import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/streams.dart';
import 'package:kashirons_flutter/helpers/toast.dart';
import 'package:kashirons_flutter/networks/rx_base.dart';

import 'api.dart';

final class SparkUpdateApiRx extends RxResponseInt<Map<String, dynamic>> {
  final api = SparkUpdateApi.instance;

  SparkUpdateApiRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> sparkUpdate({
    required String vip_id,
    required String title,
    required String description,
    required String date,
    required String time,
    required String spark_id,
  }) async {
    try {
      Map<String, dynamic> data = await api.sparkupdateApi(
        vip_id: vip_id,
        title: title,
        description: description,
        date: date,
        time: time,
        spark_id: spark_id,
      );
      await handleSuccessWithReturn(data);
      return true;
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(Map<String, dynamic> data) {
    return data;
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      if (error.response!.statusCode == 400) {
        ToastUtil.showShortToast(error.response!.data["message"]);
      } else {
        ToastUtil.showShortToast(error.response!.data["message"]);
      }
    }
    log(error.toString());
    dataFetcher.sink.addError(error);

    return false;
  }
}
