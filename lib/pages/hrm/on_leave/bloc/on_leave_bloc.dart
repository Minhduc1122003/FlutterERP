import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../model/hrm_model/employee_model.dart';
import '../../../../model/hrm_model/on_leave_model.dart';
import '../../../../model/login_model.dart';
import '../../../../method/hrm_method.dart';
import '../../../../network/api_provider.dart';

part 'on_leave_event.dart';
part 'on_leave_state.dart';

class OnLeaveBloc extends Bloc<OnLeaveEvent, OnLeaveState> {
  OnLeaveBloc() : super(const OnLeaveState()) {
    //on<OnLeaveEvent>((event, emit) {});
    on<InitialOnLeaveEvent>((event, emit) async {
      List<OnLeaveKindModel> listOnLeaveKindModel = await ApiProvider()
          .getListOnLeaveKind(UserModel.siteName, User.token);
      emit(OnLeaveState(listOnLeaveKindModel: listOnLeaveKindModel));
    });
    on<ChooseOnLeaveKindEvent>((event, emit) {
      emit(state.copyWith(
          onLeaveKindModel: event.onLeaveKind,
          sendStatus: SendOnLeaveStatus.initial));
    });
    on<ChooseExpirationDateEvent>((event, emit) {
      emit(state.copyWith(
          expirationDate: event.expirationDate,
          sendStatus: SendOnLeaveStatus.initial));
    });
    on<ChooseFromDateEvent>((event, emit) {
      if (state.toDate != null) {
        emit(state.copyWith(
            fromDate: event.fromDate, sendStatus: SendOnLeaveStatus.initial));
      } else {
        emit(state.copyWith(
            fromDate: event.fromDate, sendStatus: SendOnLeaveStatus.initial));
      }
    });
    on<ChooseToDateEvent>((event, emit) {
      if (state.fromDate != null) {
        emit(state.copyWith(
            toDate: event.toDate, sendStatus: SendOnLeaveStatus.initial));
      } else {
        emit(state.copyWith(
            toDate: event.toDate, sendStatus: SendOnLeaveStatus.initial));
      }
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
      if (daysBetween(state.fromDate!, state.toDate!) < 0) {
        emit(state.copyWith(
            sendStatus: SendOnLeaveStatus.failure,
            error: 'Ngày kết thúc không được lớn hơn ngày bắt đầu'));
        emit(state.copyWith(sendStatus: SendOnLeaveStatus.initial, error: ''));
        return;
      }
      emit(state.copyWith(sendStatus: SendOnLeaveStatus.loading));
      Map<String, dynamic> data = {
        'permissionType': state.onLeaveKindModel!.id,
        'employeeID': UserModel.id, //8758,
        'expired': state.expirationDate!.toIso8601String(),
        'fromDate': state.fromDate!.toIso8601String(),
        'toDate': state.toDate!.toIso8601String(),
        'qty': event.qty,
        'status': 0,
        'siteID': UserModel.siteName,
        'description': event.note,
        'year': DateTime.now().year,
        'docType': 'OLDocType'
      };
      String result = await ApiProvider().sendOnLeaveRequest(data, User.token);
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
