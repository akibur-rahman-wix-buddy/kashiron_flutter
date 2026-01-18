
import 'package:kashirons_flutter/feature/home_screen/data/home_data_rx/%20api.dart';
import 'package:kashirons_flutter/feature/home_screen/model/home_api_data_model.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../../networks/exception_handler/data_source.dart';
import '../../../../../../networks/rx_base.dart';

final class  HomeApiDataRx extends RxResponseInt<HomeApiDataModel> {
  final api = HomeApiDataApi.instance;

  HomeApiDataRx({required super.empty, required super.dataFetcher});

  ValueStream<HomeApiDataModel> get ServiceName => dataFetcher.stream;

  Future<void> homeApiDataApiInfo() async {
    try {
      HomeApiDataModel allData = await api.homeApiDataapiData();
      handleSuccessWithReturn(allData);
    } catch (error) {
      handleErrorWithReturn(ErrorHandler.handle(error).failure);
    }
  }

  @override
  handleSuccessWithReturn(HomeApiDataModel data) {

    dataFetcher.sink.add(data);
    return data;
  }
}
