import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../../model/login_model.dart';
import '../../hrm_model/employee_model.dart';
import '../../hrm_model/shift_model.dart';
import '../../network/api_provider.dart';

part 'timekeeping_offset_event.dart';
part 'timekeeping_offset_state.dart';

class TimekeepingOffsetBloc
    extends Bloc<TimekeepingOffsetEvent, TimekeepingOffsetState> {
  TimekeepingOffsetBloc() : super(const TimekeepingOffsetState()) {
    on<InitialTimekeepingOffsetEvent>((event, emit) async {
      List<ShiftModel> listShiftModel =
          await ApiProvider().getListShiftModel(EmployeeModel.siteName, User.token);
      emit(TimekeepingOffsetState(listShiftModel: listShiftModel));
    });
    on<ChoosseShiftEvent>((event, emit) {
      emit(state.copyWith(
          shiftModel: event.shiftModel, sendStatus: SendTimekeepingOffsetStatus.initial));
    });
    on<ChoosseApplyDateEvent>((event, emit) {
      emit(state.copyWith(
          applyDate: event.applyDate, sendStatus: SendTimekeepingOffsetStatus.initial));
    });
    on<SendTimekeepingOffsetEvent>((event, emit) async {
      if (state.sendStatus == SendTimekeepingOffsetStatus.loading) return;
      if (state.shiftModel == null || state.applyDate == null) {
        emit(state.copyWith(sendStatus: SendTimekeepingOffsetStatus.lack));
        emit(state.copyWith(sendStatus: SendTimekeepingOffsetStatus.initial));
        return;
      }
      emit(state.copyWith(sendStatus: SendTimekeepingOffsetStatus.loading));
      Map<String, dynamic> data = {
        'shiftID': state.shiftModel!.id,
        'employeeID': EmployeeModel.id, //8758,
        'dateApply': state.applyDate!.toIso8601String(),
        'fromTime': state.shiftModel!.fromTime.toIso8601String(),
        'toTime': state.shiftModel!.toTime.toIso8601String(),
        'status': 0,
        'reason': event.reason,
        'note': event.note,
        'siteID': EmployeeModel.siteName,
      };
      String result =
          await ApiProvider().sendTimekeepingOffsetRequest(data, User.token);
      if (result == "ADD") {
        emit(state.copyWith(sendStatus: SendTimekeepingOffsetStatus.success));
      } else {
        emit(state.copyWith(sendStatus: SendTimekeepingOffsetStatus.failure));
        emit(state.copyWith(sendStatus: SendTimekeepingOffsetStatus.initial));
      }
    });
  }
}
