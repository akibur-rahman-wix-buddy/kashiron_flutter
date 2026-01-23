import 'dart:developer';
import 'package:kashirons_flutter/feature/settings/model/favorite_gifts_model.dart';
import 'package:kashirons_flutter/networks/dio/dio.dart';
import 'package:kashirons_flutter/networks/endpoints.dart';
import 'package:kashirons_flutter/networks/exception_handler/data_source.dart';

final class FavoriteGiftsApi {
  static final FavoriteGiftsApi _singleton = FavoriteGiftsApi._internal();
  FavoriteGiftsApi._internal();

  static FavoriteGiftsApi get instance => _singleton;

  Future<FavouriteGiftsModel> favoriteGiftsApi() async {
    try {
      final response = await getHttp(Endpoints.favoriteGifts());
      if (response.statusCode == 200) {
        return FavouriteGiftsModel.fromJson(response.data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      log("Errlllor in API: $error");
      rethrow;
    }
  }
}
