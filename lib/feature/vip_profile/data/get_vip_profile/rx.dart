import 'package:kashirons_flutter/feature/vip_profile/data/get_vip_profile/api.dart';
import 'package:kashirons_flutter/feature/vip_profile/data/get_vip_profile_list/api.dart';
import 'package:kashirons_flutter/feature/vip_profile/model/vip_profile_list_model.dart';
import 'package:kashirons_flutter/feature/vip_profile/model/vip_profile_model.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../../networks/exception_handler/data_source.dart';
import '../../../../../../networks/rx_base.dart';

final class GetVipProfileApiRx extends RxResponseInt<VipProfileModel> {
  final api = GetVipProfileApi.instance;

  GetVipProfileApiRx({required super.empty, required super.dataFetcher});

  ValueStream<VipProfileModel> get ServiceName => dataFetcher.stream;

  Future<void> getVipProfile({required dynamic id}) async {
    try {
      VipProfileModel allData = await api.getVipProfileApi(id: id);
      handleSuccessWithReturn(allData);
    } catch (error) {
      handleErrorWithReturn(ErrorHandler.handle(error).failure);
    }
  }

  @override
  handleSuccessWithReturn(VipProfileModel data) {
    dataFetcher.sink.add(data);
    return data;
  }
}
