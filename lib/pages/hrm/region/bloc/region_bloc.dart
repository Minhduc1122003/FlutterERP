import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../model/hrm_model/company_model.dart';
import '../../../../network/api_provider.dart';

part 'region_event.dart';
part 'region_state.dart';

class RegionBloc extends Bloc<RegionEvent, RegionState> {
  RegionBloc() : super(RegionInitial()) {
    on<RegionLoadEvent>((event, emit) async {
      emit(RegionWaiting());
      List<RegionModel> regionList = await ApiProvider().getRegion();
      emit(RegionSuccess(regionList: regionList));
    });
  }
}
