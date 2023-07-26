import 'package:bloc/bloc.dart';
import 'package:erp/model/login_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:equatable/equatable.dart';
import '../../../../model/hrm_model/attendance_model.dart';
import '../../../../model/hrm_model/employee_model.dart';
import '../../../../network/api_provider.dart';
part 'timekeeping_event.dart';
part 'timekeeping_state.dart';

class TimekeepingBloc extends Bloc<TimekeepingEvent, TimekeepingState> {
  TimekeepingBloc() : super(const TimekeepingState()) {
    on<InitialTimekeepingEvent>((event, emit) async {
      List<SalaryPeriodModel> listSalaryPeriodModel = await ApiProvider()
          .getListSalaryPeriod(UserModel.siteName, User.token);
      emit(TimekeepingState(listSalaryPeriodModel: listSalaryPeriodModel));
    });

    on<ChooseSalaryPeriod>((event, emit) async {
      emit(state.copyWith(status: TimekeepingStatus.loading));
      List<AttendanceModel> listAttendanceModel = await _getListAttendance(
          event.salaryPeriod.fromDate, event.salaryPeriod.toDate);
      List<TimeSheetModel> listTimeSheetModel =
          await _getTimeSheets(event.salaryPeriod.id);
      List<SummaryOffsetModel> listSummaryOffsetModel =
          await _getOffsetAndOnLeave(event.salaryPeriod.id);
      int nOffset = -1;
      int nOnleave = -1;
      if (listSummaryOffsetModel.length == 1) {
        nOffset = listSummaryOffsetModel.first.offset;
        nOnleave = listSummaryOffsetModel.first.onLeave;
      }
      int nAttendanceInvalid = await _getListAttendanceInvalid(
          event.salaryPeriod.fromDate, event.salaryPeriod.toDate);

      emit(state.copyWith(
          listAttendanceModel: listAttendanceModel,
          listTimeSheetModel: listTimeSheetModel,
          salaryPeriodModel: event.salaryPeriod,
          nAttendanceInvalid: nAttendanceInvalid,
          nOffset: nOffset,
          nOnLeave: nOnleave,
          status: TimekeepingStatus.success));
    });
  }
}

Future<List<AttendanceModel>> _getListAttendance(
    DateTime fromDate, DateTime toDate) async {
  Map<String, dynamic> data = {
    'employeeId': UserModel.id,
    'fromDate': DateFormat('yyyy-MM-dd').format(fromDate),
    'toDate': DateFormat('yyyy-MM-dd').format(toDate)
  };
  List<AttendanceModel> list = await ApiProvider()
      .getListAttendance(UserModel.siteName, data, User.token);
  return list.reversed.toList();
}

Future<int> _getListAttendanceInvalid(
    DateTime fromDate, DateTime toDate) async {
  Map<String, dynamic> data = {
    'deptId': 0,
    'empCode': UserModel.id.toString(),
    'fromDate': DateFormat('yyyy-MM-dd').format(fromDate),
    'toDate': DateFormat('yyyy-MM-dd').format(toDate)
  };
  // int n = await ApiProvider()
  //     .getListAttendanceInvalid(UserModel.siteName, data, User.token);
  return await ApiProvider()
      .getListAttendanceInvalid(UserModel.siteName, data, User.token);
}

Future<List<TimeSheetModel>> _getTimeSheets(int periodId) async {
  Map<String, dynamic> data = {
    'listEmpId': [UserModel.id],
    'period': periodId,
    'siteID': UserModel.siteName
  };
  // List<TimeSheetModel> list =
  //     await ApiProvider().getTimeSheets(data, User.token);
  return await ApiProvider().getTimeSheets(data, User.token);
}

Future<List<SummaryOffsetModel>> _getOffsetAndOnLeave(int periodId) async {
  Map<String, dynamic> data = {
    'listEmpId': [UserModel.id],
    'period': periodId,
    'siteID': UserModel.siteName
  };
  // List<SummaryOffsetModel> list =
  //     await ApiProvider().getOffsetAndOnLeave(data, User.token);
  return await ApiProvider().getOffsetAndOnLeave(data, User.token);
}
