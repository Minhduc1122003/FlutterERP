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
      List<ShiftModel> listShiftModel =
          await ApiProvider().getListShiftModelByUser(
              // id 9087 có data nên sử dụng
              9087,
              // UserModel.id
              User.site,
              User.token);
      print('getListShiftModelByUser ');

      List<LocationModel> locationList =
          await ApiProvider().getLocation(UserModel.siteName, User.token);
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
      emit(state.copyWith(
          confirmStatus: CheckInOutConfirmStatus.successConfirm));
      emit(state.copyWith(
          confirmStatus: CheckInOutConfirmStatus.initialConfirm));
    });
    on<ChooseLocationEvent>((event, emit) {
      emit(state.copyWith(locationModel: event.location));
    });

    on<ChooseShiftEvent>((event, emit) {
      emit(state.copyWith(shiftModel: event.shiftModel));
    });
    on<CheckInPostEvent>((event, emit) async {
      emit(CheckInWaitingEvent());
      //List<RegionModel> regionList = await ApiProvider().getRegion();
      await ApiProvider().postCheckin(event.id, event.employeeID,
          event.authDate, event.authTime, event.locationID, event.token);
      emit(CheckInSuccessEvent());
    });
  }
}
