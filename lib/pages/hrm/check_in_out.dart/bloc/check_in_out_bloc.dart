import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:erp/network/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../model/hrm_model/company_model.dart';
import '../../../../model/hrm_model/employee_model.dart';
import '../../../../model/hrm_model/shift_model.dart';
import '../../../../model/login_model.dart';
part 'check_in_out_event.dart';
part 'check_in_out_state.dart';

class CheckInOutBloc extends Bloc<CheckInOutEvent, CheckInOutState> {
  CheckInOutBloc() : super(const CheckInOutState()) {
    on<InitialCheckInOutEvent>((event, emit) async {
      List<ShiftModel> listShiftModel = await ApiProvider()
          .getListShiftModel(EmployeeModel.siteName, User.token);
      List<LocationModel> locationList = await ApiProvider().getLocation();
      emit(state.copyWith(
          listShiftModel: listShiftModel, listLocationModel: locationList));
    });
    // on<CheckInOutLoadLocationEvent>((event, emit) async {
    //   List<LocationModel> locationList = await ApiProvider().getLocation();
    //   emit(state.copyWith(listLocationModel: locationList));
    // });
    on<CheckInOutConfirmEvent>((event, emit) async {
      emit(state.copyWith(
          confirmStatus: CheckInOutConfirmStatus.loadingConfirm));
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(
          confirmStatus: CheckInOutConfirmStatus.successConfirm));
    });
    on<ChoosseLocationEvent>((event, emit) {
      emit(state.copyWith(locationModel: event.location));
    });

    on<ChoosseShiftEvent>((event, emit) {
      emit(state.copyWith(shiftModel: event.shiftModel));
    });
  }
}
