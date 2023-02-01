part of 'timekeeping_bloc.dart';

//import 'package:equatable/equatable.dart';
enum TimekeepingStatus { success, loading }

@immutable
class TimekeepingState extends Equatable {
  final List<AttendanceModel> listAttendanceModel;
  final List<TimeSheetModel> listTimeSheetModel;
  final List<SalaryPeriodModel> listSalaryPeriodModel;
  final SalaryPeriodModel? salaryPeriodModel;
  final TimekeepingStatus status;

  const TimekeepingState(
      {this.listAttendanceModel = const [],
      this.listTimeSheetModel = const [],
      this.listSalaryPeriodModel = const [],
      this.salaryPeriodModel,
      this.status = TimekeepingStatus.success
   });
  TimekeepingState copyWith(
      {List<AttendanceModel>? listAttendanceModel,
      List<TimeSheetModel>? listTimeSheetModel,
      List<SalaryPeriodModel>? listSalaryPeriodModel,
      SalaryPeriodModel? salaryPeriodModel,
      TimekeepingStatus? status}) {
    return TimekeepingState(
      listAttendanceModel: listAttendanceModel ?? this.listAttendanceModel,
      listTimeSheetModel: listTimeSheetModel ?? this.listTimeSheetModel,
      listSalaryPeriodModel:
          listSalaryPeriodModel ?? this.listSalaryPeriodModel,
      salaryPeriodModel: salaryPeriodModel ?? this.salaryPeriodModel,     
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [listAttendanceModel,listTimeSheetModel,salaryPeriodModel,status];
}
