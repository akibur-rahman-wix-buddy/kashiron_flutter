import 'package:kashirons_flutter/feature/vip_profile/data/get_vip_profile_list/api.dart';
import 'package:kashirons_flutter/feature/vip_profile/model/vip_profile_list_model.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../../networks/exception_handler/data_source.dart';
import '../../../../../../networks/rx_base.dart';

final class GetVipProfileListApiRx extends RxResponseInt<VipProfileListModel> {
  final api = GetVipProfileListApi.instance;

  GetVipProfileListApiRx({required super.empty, required super.dataFetcher});

  ValueStream<VipProfileListModel> get ServiceName => dataFetcher.stream;

  Future<void> getVipProfileList() async {
    try {
      VipProfileListModel allData = await api.getVipProfileListApi();
      handleSuccessWithReturn(allData);
    } catch (error) {
      handleErrorWithReturn(ErrorHandler.handle(error).failure);
    }
  }

  @override
  handleSuccessWithReturn(VipProfileListModel data) {
    dataFetcher.sink.add(data);
    return data;
  }
}
