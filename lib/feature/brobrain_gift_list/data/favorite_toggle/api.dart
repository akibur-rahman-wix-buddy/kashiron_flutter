import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:kashirons_flutter/networks/dio/dio.dart';
import 'package:kashirons_flutter/networks/endpoints.dart';
import 'package:kashirons_flutter/networks/exception_handler/data_source.dart';

final class FavoriteToggleApi {
  static final FavoriteToggleApi _singleton = FavoriteToggleApi._internal();

  FavoriteToggleApi._internal();

  static FavoriteToggleApi get instance => _singleton;

  Future<Map<String, dynamic>> favoriteToggle({required dynamic id}) async {
    try {
      Map<String, dynamic> data = {
        "product_id": id,
      };

      Response response = (await postHttp(Endpoints.favoriteToggle(), data));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(json.encode(response.data));
        // ToastUtil.showShortToast('Favorite added successfully');
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      print("Error during signup: $error");
      rethrow;
    }
  }
}
