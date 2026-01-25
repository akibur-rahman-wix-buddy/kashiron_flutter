import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/streams.dart';
import 'package:kashirons_flutter/helpers/toast.dart';
import 'package:kashirons_flutter/networks/rx_base.dart';

import 'api.dart';

final class CreateVipProfileRx extends RxResponseInt<Map<String, dynamic>> {
  final api = CreateVipProfileApi.instance;

  CreateVipProfileRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> createVipProfileInfo({
    String? name,
    String? dateOfBirth,
    dynamic relationId,
    dynamic specialNotes,
    dynamic streetAddress,
    dynamic country,
    dynamic city,
    dynamic zipCode,
    dynamic phone,
    List<dynamic>? interests,
    dynamic anniversaryDate,
    XFile? avatar,
  }) async {
    try {
      // Call the sign-in API
      Map<String, dynamic> data = await api.createVipProfileApi(
          name: name,
          dateOfBirth: dateOfBirth,
          relationId: relationId,
          specialNotes: specialNotes,
          streetAddress: streetAddress,
          country: country,
          city: city,
          zipCode: zipCode,
          phone: phone,
          interests: interests,
          anniversaryDate: anniversaryDate,
          avatar: avatar);

      String message = data['message'];
      log(">>>>>>>>>>>>>>> massage : $message");
      await handleSuccessWithReturn(data);

      return true;
    } catch (error) {
      // Handle error
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(Map<String, dynamic> data) {
    ToastUtil.showLongToast(data['message']);

    dataFetcher.sink.add(data);

    return data;
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      if (error.response != null) {
        if (error.response!.statusCode == 422) {
          ToastUtil.showShortToast(error.response?.data["message"]);
          var errors = error.response!.data["message"];
          if (errors is Map<String, dynamic>) {
            // Combine all error messages into a single string
            StringBuffer buffer = StringBuffer();
            errors.forEach((key, value) {
              if (value is List) {
                for (var msg in value) {
                  buffer.writeln(msg); // Add each error message
                }
              }
            });
            ToastUtil.showShortToast(buffer.toString());
          } else {
            // ToastUtil.showShortToast(error.response?.data["message"]);
            ToastUtil.showShortToast("Something went wrong!");
          }
        } else {
          ToastUtil.showShortToast(
              error.response!.data["errors"] ?? "Unknown error");
        }
      } else {
        ToastUtil.showShortToast("No response data available");
      }
    }

    log(error.toString());
    dataFetcher.sink.addError(error);

    return false;
  }
}
