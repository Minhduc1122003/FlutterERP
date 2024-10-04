import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../model/hrm_model/company_model.dart';
import '../../../../network/api_provider.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial()) {
    on<GetLocationEvent>((event, emit) async {
      emit(LocationWaiting());
      List<LocationModel> locationList =
          await ApiProvider().getLocation(event.site, event.token);
      print('locationList: ${locationList.length}');
      emit(LocationSuccess(locationList: locationList));
    });

    on<LocationAddEVent>((event, emit) async {
      emit(LocationWaiting());
      String result = await ApiProvider().postAddLocation(
          event.id,
          event.branchID,
          event.name,
          event.address,
          event.longitude,
          event.latitude,
          event.site,
          event.token);
      emit(LocationAddSuccess(mess: result));
    });
  }
}
