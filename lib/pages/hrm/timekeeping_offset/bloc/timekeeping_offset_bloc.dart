import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../hrm_model/employee_model.dart';
import '../../hrm_model/shift_model.dart';
import '../../network/api_provider.dart';

part 'timekeeping_offset_event.dart';
part 'timekeeping_offset_state.dart';

class TimekeepingOffsetBloc
    extends Bloc<TimekeepingOffsetEvent, TimekeepingOffsetState> {
  TimekeepingOffsetBloc()
      : super(const TimekeepingOffsetState(
            listShiftModel: [],
            applyDate: null,
            shiftModel: null,
            isSending: false)) {
    on<InitialTimekeepingOffsetEvent>((event, emit) async {
      List<ShiftModel> listShiftModel =
          await ApiProvider().getListShiftModel(EmployeeModel.siteName, '');
      emit(TimekeepingOffsetState(
          listShiftModel: listShiftModel,
          shiftModel: null,
          applyDate: null,
          isSending: false));
    });
    on<ChoosseShiftEvent>((event, emit) {
      emit(state.copyWith(shiftModel: event.shiftModel));
    });
    on<ChoosseApplyDateEvent>((event, emit) {
      emit(state.copyWith(applyDate: event.applyDate));
    });
    on<SendingTimekeepingOffsetEvent>((event, emit) async{
      emit(state.copyWith(isSending: true));
      await Future<void>.delayed(const Duration(seconds: 2));
       emit(state.copyWith(isSending: false));
    });
  }
}
