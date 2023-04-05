import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../model/hrm_model/company_model.dart';
import '../../../../network/api_provider.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial()) {
    on<LocationLoadEvent>((event, emit) async {
      emit(LocationWaiting());
      List<LocationModel> locationList = await ApiProvider().getLocation();
      emit(LocationSuccess(locationList: locationList));
    });
  }
}
