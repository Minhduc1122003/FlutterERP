import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../hrm_method.dart';
import '../../hrm_model/employee_model.dart';
import '../../hrm_model/on_leave_model.dart';
import '../../network/api_provider.dart';

part 'on_leave_event.dart';
part 'on_leave_state.dart';

class OnLeaveBloc extends Bloc<OnLeaveEvent, OnLeaveState> {
  OnLeaveBloc() : super(const OnLeaveState()) {
    //on<OnLeaveEvent>((event, emit) {});
    on<InitialOnLeaveEvent>((event, emit) async {
      List<OnLeaveKindModel> listOnLeaveKindModel =
          await ApiProvider().getListOnLeaveKind(EmployeeModel.siteName, '');
      emit(OnLeaveState(listOnLeaveKindModel: listOnLeaveKindModel));
    });
    on<ChoosseOnLeaveKindEvent>((event, emit) {
      emit(state.copyWith(
          onLeaveKindModel: event.onLeaveKind,
          sendStatus: SendOnLeaveStatus.initial));
    });
    on<ChoosseExpirationDateEvent>((event, emit) {
      emit(state.copyWith(
          expirationDate: event.expirationDate,
          sendStatus: SendOnLeaveStatus.initial));
    });
    on<ChoosseFromDateEvent>((event, emit) {
      if (state.toDate != null) {
        int totalDay = getTotalDay(event.fromDate, state.toDate!);
        int onDay = 0;
        if (totalDay == 1) onDay = 1;
        emit(state.copyWith(
            fromDate: event.fromDate,
            totalDay: totalDay,
            onDay: onDay,
            sendStatus: SendOnLeaveStatus.initial));
      } else {
        emit(state.copyWith(
            fromDate: event.fromDate, sendStatus: SendOnLeaveStatus.initial));
      }
    });
    on<ChoosseToDateEvent>((event, emit) {
      if (state.fromDate != null) {
        int totalDay = getTotalDay(state.fromDate!, event.toDate);
        int onDay = 0;
        if (totalDay == 1) onDay = 1;
        emit(state.copyWith(
            toDate: event.toDate,
            totalDay: totalDay,
            onDay: onDay,
            sendStatus: SendOnLeaveStatus.initial));
      } else {
        emit(state.copyWith(
            toDate: event.toDate, sendStatus: SendOnLeaveStatus.initial));
      }
    });
    on<ChoosseOnDayEvent>((event, emit) {
      if (state.onDay == 0) return;
      emit(state.copyWith(
          onDay: event.onDay, sendStatus: SendOnLeaveStatus.initial));
    });
    on<SendOnLeaveEvent>((event, emit) async {
      if (state.sendStatus == SendOnLeaveStatus.loading) return;
      if (state.onLeaveKindModel == null ||
          state.expirationDate == null ||
          state.fromDate == null ||
          state.toDate == null) {
        emit(state.copyWith(
            sendStatus: SendOnLeaveStatus.failure,
            error: 'Vui lòng điền đầy đủ thông tin'));
        emit(state.copyWith(sendStatus: SendOnLeaveStatus.initial, error: ''));
        return;
      }
      if (state.totalDay < 0) {
        emit(state.copyWith(
            sendStatus: SendOnLeaveStatus.failure,
            error: 'Tổng số ngày nghỉ không hợp lệ'));
        emit(state.copyWith(sendStatus: SendOnLeaveStatus.initial, error: ''));
        return;
      }
      if (daysBetween(state.expirationDate!, state.fromDate!) < 0) {
        emit(state.copyWith(
            sendStatus: SendOnLeaveStatus.failure,
            error: 'Ngày hết hạn không hợp lệ'));
        emit(state.copyWith(sendStatus: SendOnLeaveStatus.initial, error: ''));
        return;
      }
      emit(state.copyWith(sendStatus: SendOnLeaveStatus.loading));
      Map<String, dynamic> data = {
        'permissionType': state.onLeaveKindModel!.id,
        'employeeID': EmployeeModel.id, //8758,
        'expired': state.expirationDate!.toIso8601String(),
        'fromDate': state.fromDate!.toIso8601String(),
        'toDate': state.toDate!.toIso8601String(),
        'totalDay': state.totalDay,
        'isHalfDay': state.onDay == 1,
        'isOneDay': state.onDay == 2,
        'status': 0,
        'siteID': EmployeeModel.siteName,
        'description': event.note,
        'year': DateTime.now().year,
      };
      String result = await ApiProvider().sendOnLeaveRequest(data, '');
      if (result == "ADD") {
        emit(state.copyWith(sendStatus: SendOnLeaveStatus.success, error: ''));
      } else {
        emit(state.copyWith(
            sendStatus: SendOnLeaveStatus.failure,
            error: 'Đã gửi yêu cầu thất bại'));
        emit(state.copyWith(sendStatus: SendOnLeaveStatus.initial, error: ''));
      }
    });
  }
}

int getTotalDay(DateTime fromDate, DateTime toDate) {
  int totalDay = daysBetween(fromDate, toDate);
  if (totalDay >= 0) totalDay += 1;
  if (totalDay == 1) {
    // onDay.value = 1;
  } else {
    //onDay.value = 0;
  }
  return totalDay;
}
