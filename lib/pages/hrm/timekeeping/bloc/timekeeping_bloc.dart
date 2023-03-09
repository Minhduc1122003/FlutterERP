import 'package:bloc/bloc.dart';
import 'package:erp/model/login_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:equatable/equatable.dart';
import '../../hrm_method.dart';
import '../../hrm_model/attendance_model.dart';
import '../../hrm_model/employee_model.dart';
import '../../network/api_provider.dart';
part 'timekeeping_event.dart';
part 'timekeeping_state.dart';

class TimekeepingBloc extends Bloc<TimekeepingEvent, TimekeepingState> {
  TimekeepingBloc() : super(const TimekeepingState()) {
    on<InitialTimekeepingEvent>((event, emit) async {
      List<SalaryPeriodModel> listSalaryPeriodModel = await ApiProvider()
          .getListSalaryPeriod(EmployeeModel.siteName, User.token);
      emit(TimekeepingState(listSalaryPeriodModel: listSalaryPeriodModel));
    });

    on<ChooseSalaryPeriod>((event, emit) async {
      emit(state.copyWith(status: TimekeepingStatus.loading));
      List<AttendanceModel> listAttendanceModel = await _getListAttendance(
          event.salaryPeriod.fromDate, event.salaryPeriod.toDate);
      List<TimeSheetModel> listTimeSheetModel =
          await _getTimeSheets(event.salaryPeriod.id);
      List<AttendanceInvalidModel> listAttendanceInvalidModel =
          await _getListAttendanceInvalid(
              event.salaryPeriod.fromDate, event.salaryPeriod.toDate);
      emit(state.copyWith(
          listAttendanceModel: listAttendanceModel,
          listTimeSheetModel: listTimeSheetModel,
          salaryPeriodModel: event.salaryPeriod,
          status: TimekeepingStatus.success));
    });
  }
}

Future<List<AttendanceModel>> _getListAttendance(
    DateTime fromDate, DateTime toDate) async {
  Map<String, dynamic> data = {
    'employeeId': EmployeeModel.id,
    'fromDate': DateFormat('yyyy-MM-dd').format(fromDate),
    'toDate': DateFormat('yyyy-MM-dd').format(toDate)
  };
  List<AttendanceModel> list = await ApiProvider()
      .getListAttendance(EmployeeModel.siteName, data, User.token);
  return list.reversed.toList();
}

Future<List<AttendanceInvalidModel>> _getListAttendanceInvalid(
    DateTime fromDate, DateTime toDate) async {
  Map<String, dynamic> data = {
    'deptId': 0,
    'empCode': EmployeeModel.id.toString(),
    'fromDate': DateFormat('yyyy-MM-dd').format(fromDate),
    'toDate': DateFormat('yyyy-MM-dd').format(toDate)
  };
  List<AttendanceInvalidModel> list = await ApiProvider()
      .getListAttendanceInvalid(EmployeeModel.siteName, data, User.token);
  return list.reversed.toList();
}

Future<List<TimeSheetModel>> _getTimeSheets(int periodId) async {
  Map<String, dynamic> data = {
    'listEmpId': [EmployeeModel.id],
    'period': periodId,
    'siteID': EmployeeModel.siteName
  };
  List<TimeSheetModel> list =
      await ApiProvider().getTimeSheets(data, User.token);
  return list;
}
