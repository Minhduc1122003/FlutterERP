import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:equatable/equatable.dart';
import '../../hrm_method.dart';
import '../../hrm_model/attendance_model.dart';
import '../../hrm_model/employee_model.dart';
import '../../network/api_provider.dart';
part 'shift_calendar_event.dart';
part 'shift_calendar_state.dart';

class ShiftCalendarBloc extends Bloc<ShiftCalendarEvent, ShiftCalendarState> {
  ShiftCalendarBloc() : super(ShiftCalendarInitial()) {
    on<ShiftCalendarLoadToday>(_getListAttendanceToday);
    on<ShiftCalendarLoadWeek>(_getListAttendanceWeek);
    on<ShiftCalendarLoadMonth>(_getListAttendanceMonth);
    on<ShiftCalendarLoadRangeDate>(_getListAttendanceRangeDate);
  }
}

void _getListAttendanceToday(
    ShiftCalendarLoadToday event, Emitter<ShiftCalendarState> emit) async {
  emit(ShiftCalendarLoading());
  DateTime now = DateTime.now();
  List<AttendanceModel> list = await _getListAttendance(now, now);
  emit(ShiftCalendarLoaded(
      listAttendanceModel: list,
      fromDate: now,
      toDate: now,
      selectDateText:
          '${getDay(now.weekday)}, ${DateFormat('dd.MM').format(now)}'));
}

void _getListAttendanceWeek(
    ShiftCalendarLoadWeek event, Emitter<ShiftCalendarState> emit) async {
  emit(ShiftCalendarLoading());
  DateTime now = DateTime.now();
  DateTime fromDate = now.subtract(Duration(days: now.weekday - 1));
  DateTime toDate = DateTime(fromDate.year, fromDate.month, fromDate.day)
      .add(const Duration(days: 6));
  List<AttendanceModel> list = await _getListAttendance(fromDate, toDate);
  emit(ShiftCalendarLoaded(
      listAttendanceModel: list,
      fromDate: fromDate,
      toDate: toDate,
      selectDateText:
          '${DateFormat('dd.MM').format(fromDate)} - ${DateFormat('dd.MM').format(toDate)}'));
}

void _getListAttendanceMonth(
    ShiftCalendarLoadMonth event, Emitter<ShiftCalendarState> emit) async {
  emit(ShiftCalendarLoading());
  DateTime now = DateTime.now();
  int numberDay = daysInMonth(now);
  DateTime fromDate = DateTime(now.year, now.month, 1);
  DateTime toDate = DateTime(now.year, now.month, numberDay);
  List<AttendanceModel> list = await _getListAttendance(fromDate, toDate);
  emit(ShiftCalendarLoaded(
      listAttendanceModel: list,
      fromDate: fromDate,
      toDate: toDate,
      selectDateText:
          '${DateFormat('dd.MM').format(fromDate)} - ${DateFormat('dd.MM').format(toDate)}'));
}

void _getListAttendanceRangeDate(
    ShiftCalendarLoadRangeDate event, Emitter<ShiftCalendarState> emit) async {
  emit(ShiftCalendarLoading());

  List<AttendanceModel> list =
      await _getListAttendance(event.fromDate, event.toDate);
  emit(ShiftCalendarLoaded(
      listAttendanceModel: list,
      fromDate: event.fromDate,
      toDate: event.toDate,
      selectDateText:
          '${DateFormat('dd.MM').format(event.fromDate)} - ${DateFormat('dd.MM').format(event.toDate)}'));
}

Future<List<AttendanceModel>> _getListAttendance(
    DateTime fromDate, DateTime toDate) async {
  Map<String, dynamic> data = {
    'employeeId': EmployeeModel.id,
    'fromDate': DateFormat('yyyy-MM-dd').format(fromDate),
    'toDate': DateFormat('yyyy-MM-dd').format(toDate)
  };
  List<AttendanceModel> list =
      await ApiProvider().getListAttendance(EmployeeModel.siteName, data, '');
  return list;
}
