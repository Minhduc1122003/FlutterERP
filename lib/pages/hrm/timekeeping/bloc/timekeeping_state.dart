part of 'timekeeping_bloc.dart';

//import 'package:equatable/equatable.dart';
enum TimekeepingStatus { success, loading }

@immutable
class TimekeepingState extends Equatable {
  final List<AttendanceModel> listAttendanceModel;
  final List<TimeSheetModel> listTimeSheetModel;
  final List<SalaryPeriodModel> listSalaryPeriodModel;
  final SalaryPeriodModel? salaryPeriodModel;
  final int nAttendanceInvalid;
  final int nOnLeave;
  final int nOffset;
  final TimekeepingStatus status;

  const TimekeepingState(
      {this.listAttendanceModel = const [],
      this.listTimeSheetModel = const [],
      this.listSalaryPeriodModel = const [],
      this.salaryPeriodModel,
      this.nAttendanceInvalid= -1,
      this.nOnLeave = -1,
      this.nOffset = -1,
      this.status = TimekeepingStatus.success});
  TimekeepingState copyWith(
      {List<AttendanceModel>? listAttendanceModel,
      List<TimeSheetModel>? listTimeSheetModel,
      List<SalaryPeriodModel>? listSalaryPeriodModel,
      SalaryPeriodModel? salaryPeriodModel,
      int? nAttendanceInvalid,
      int? nOnLeave,
      int? nOffset,
      TimekeepingStatus? status}) {
    return TimekeepingState(
      listAttendanceModel: listAttendanceModel ?? this.listAttendanceModel,
      listTimeSheetModel: listTimeSheetModel ?? this.listTimeSheetModel,
      listSalaryPeriodModel:
          listSalaryPeriodModel ?? this.listSalaryPeriodModel,
      salaryPeriodModel: salaryPeriodModel ?? this.salaryPeriodModel,
      nAttendanceInvalid:
          nAttendanceInvalid ?? this.nAttendanceInvalid,
      nOnLeave: nOnLeave ?? this.nOnLeave,
      nOffset: nOffset ?? this.nOffset,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props =>
      [listAttendanceModel, listTimeSheetModel, salaryPeriodModel, status];
}
