import 'package:bloc/bloc.dart';
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
    // on<TimekeepingLoadToday>(_getListAttendanceToday);
    // on<TimekeepingLoadWeek>(_getListAttendanceWeek);
    // on<TimekeepingLoadMonth>(_getListAttendanceMonth);
    // on<TimekeepingLoadRangeDate>(_getListAttendanceRangeDate);
    on<InitialTimekeepingEvent>((event, emit) async {
      List<SalaryPeriodModel> listSalaryPeriodModel =
          await ApiProvider().getListSalaryPeriod(EmployeeModel.siteName, '');
      emit(TimekeepingState(listSalaryPeriodModel: listSalaryPeriodModel));
    });

    on<ChooseSalaryPeriod>((event, emit) async {
      emit(state.copyWith(status: TimekeepingStatus.loading));
      List<AttendanceModel> listAttendanceModel = await _getListAttendance(
          event.salaryPeriod.fromDate, event.salaryPeriod.toDate);
      List<TimeSheetModel> listTimeSheetModel =
          await _getTimeSheets(event.salaryPeriod.id);
      emit(state.copyWith(
          listAttendanceModel: listAttendanceModel,
          listTimeSheetModel: listTimeSheetModel,
          salaryPeriodModel: event.salaryPeriod,
          status: TimekeepingStatus.success));
    });
  }
}

// void _getListAttendanceToday(
//     TimekeepingLoadToday event, Emitter<TimekeepingState> emit) async {
//   emit(TimekeepingLoading());
//   DateTime now = DateTime.now();
//   List<AttendanceModel> listAttendanceModel =
//       await _getListAttendance(now, now);
//   List<TimeSheetModel> listTimeSheetModel = await _getTimeSheets();
//   emit(TimekeepingLoaded(
//       listAttendanceModel: listAttendanceModel,
//       listTimeSheetModel: listTimeSheetModel,
//       fromDate: now,
//       toDate: now,
//       selectDateText:
//           '${getDay(now.weekday)}, ${DateFormat('dd.MM').format(now)}'));
// }

// void _getListAttendanceWeek(
//     TimekeepingLoadWeek event, Emitter<TimekeepingState> emit) async {
//   emit(TimekeepingLoading());
//   DateTime now = DateTime.now();
//   DateTime fromDate = now.subtract(Duration(days: now.weekday - 1));
//   DateTime toDate = DateTime(fromDate.year, fromDate.month, fromDate.day)
//       .add(const Duration(days: 6));
//   List<AttendanceModel> listAttendanceModel =
//       await _getListAttendance(fromDate, toDate);
//   List<TimeSheetModel> listTimeSheetModel = await _getTimeSheets();
//   emit(TimekeepingLoaded(
//       listAttendanceModel: listAttendanceModel,
//       listTimeSheetModel: listTimeSheetModel,
//       fromDate: fromDate,
//       toDate: toDate,
//       selectDateText:
//           '${DateFormat('dd.MM').format(fromDate)} - ${DateFormat('dd.MM').format(toDate)}'));
// }

// void _getListAttendanceMonth(
//     TimekeepingLoadMonth event, Emitter<TimekeepingState> emit) async {
//   emit(TimekeepingLoading());
//   DateTime now = DateTime.now();
//   int numberDay = daysInMonth(now);
//   DateTime fromDate = DateTime(now.year, now.month, 1);
//   DateTime toDate = DateTime(now.year, now.month, numberDay);
//   List<AttendanceModel> listAttendanceModel =
//       await _getListAttendance(fromDate, toDate);
//   List<TimeSheetModel> listTimeSheetModel = await _getTimeSheets();
//   emit(TimekeepingLoaded(
//       listAttendanceModel: listAttendanceModel,
//       listTimeSheetModel: listTimeSheetModel,
//       fromDate: fromDate,
//       toDate: toDate,
//       selectDateText:
//           '${DateFormat('dd.MM').format(fromDate)} - ${DateFormat('dd.MM').format(toDate)}'));
// }

// void _getListAttendanceRangeDate(
//     TimekeepingLoadRangeDate event, Emitter<TimekeepingState> emit) async {
//   emit(TimekeepingLoading());

//   List<AttendanceModel> listAttendanceModel =
//       await _getListAttendance(event.fromDate, event.toDate);
//   List<TimeSheetModel> listTimeSheetModel = await _getTimeSheets();
//   emit(TimekeepingLoaded(
//       listAttendanceModel: listAttendanceModel,
//       listTimeSheetModel: listTimeSheetModel,
//       fromDate: event.fromDate,
//       toDate: event.toDate,
//       selectDateText:
//           '${DateFormat('dd.MM').format(event.fromDate)} - ${DateFormat('dd.MM').format(event.toDate)}'));
// }

Future<List<AttendanceModel>> _getListAttendance(
    DateTime fromDate, DateTime toDate) async {
  Map<String, dynamic> data = {
    'employeeId': EmployeeModel.id,
    'fromDate': DateFormat('yyyy-MM-dd').format(fromDate),
    'toDate': DateFormat('yyyy-MM-dd').format(toDate)
  };
  List<AttendanceModel> list =
      await ApiProvider().getListAttendance(EmployeeModel.siteName, data, '');
  return list.reversed.toList();
}

Future<List<TimeSheetModel>> _getTimeSheets(int periodId) async {
  Map<String, dynamic> data = {
    'listEmpId': [EmployeeModel.id],
    'period': periodId,
    'siteID': EmployeeModel.siteName
  };
  List<TimeSheetModel> list = await ApiProvider().getTimeSheets(data, '');
  return list;
}
