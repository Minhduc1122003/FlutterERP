import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../model/hrm_model/company_model.dart';
import '../../../../network/api_provider.dart';

part 'region_event.dart';
part 'region_state.dart';

class RegionBloc extends Bloc<RegionEvent, RegionState> {
  RegionBloc() : super(RegionInitial()) {
    on<GetRegionEvent>((event, emit) async {
      emit(RegionWaiting());
      List<RegionModel> regionList = await ApiProvider().getRegion(event.site, event.token);
      emit(RegionSuccess(regionList: regionList));
    });
    on<AddRegionEvent>((event, emit) async {
      emit(RegionWaiting());
      String result = await ApiProvider().postAddRegion(event.id ,event.site, event.name, event.description, event.token);
      emit(RegionAddSuccess(message: result));
    });
  }
}
