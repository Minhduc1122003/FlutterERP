part of 'shift_calendar_bloc.dart';
//import 'package:equatable/equatable.dart';

@immutable
abstract class ShiftCalendarState extends Equatable {
  //onst ShiftCalendarState();
  @override
  List<Object> get props => [];
}

class ShiftCalendarInitial extends ShiftCalendarState {}

class ShiftCalendarLoading extends ShiftCalendarState {

}

class ShiftCalendarLoaded extends ShiftCalendarState {
  final List<AttendanceModel> listAttendanceModel;
  final DateTime fromDate;
  final DateTime toDate;
  final String selectDateText;
  ShiftCalendarLoaded(
      {required this.listAttendanceModel,
      required this.fromDate,
      required this.toDate,
      required this.selectDateText});
  // ShiftCalendarLoaded copyWith(
  //     {List<AttendanceModel>? listAttendanceModel,
  //     DateTime? fromDate,
  //     DateTime? toDate,
  //     String? selectDateText}) {
  //   return ShiftCalendarLoaded(
  //     listAttendanceModel: listAttendanceModel ?? this.listAttendanceModel,
  //     fromDate: fromDate ?? this.fromDate,
  //     toDate: toDate ?? this.toDate,
  //     selectDateText: selectDateText ?? this.selectDateText,
  //   );
  // }
}
