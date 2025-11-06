import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:kashirons_flutter/constants/app_constants.dart';
import 'package:kashirons_flutter/helpers/di.dart';
import 'package:kashirons_flutter/helpers/toast.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../networks/rx_base.dart';
import 'api.dart';

final class PostLogOutRX extends RxResponseInt {
  final api = LogOutApi.instance;

  String message = "Something went wrong";

  PostLogOutRX({required super.empty, required super.dataFetcher});

  ValueStream get getLogoutData => dataFetcher.stream;

  Future<bool> logOut() async {
    try {
      Map responseData = await api.logOut();
      return handleSuccessWithReturn(responseData);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) {

    appData.write(kKeyIsLoggedIn,false);

    String massage = data['message'];
    ToastUtil.showLongToast(massage);

    dataFetcher.sink.add(data);

    return true;
  }

  @override
  handleErrorWithReturn(error) {
    String errorMessage = 'Something went wrong';
    log(error.toString());

    errorMessage = error.response?.data["message"] ?? "Something went wrong";
    return super.handleErrorWithReturn(errorMessage);
  }
}
