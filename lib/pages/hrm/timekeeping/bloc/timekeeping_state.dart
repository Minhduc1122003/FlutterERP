part of 'timekeeping_bloc.dart';

//import 'package:equatable/equatable.dart';
enum LoadTimekeepingStatus { loading, success, failure }

@immutable
class TimekeepingState extends Equatable {
  final List<AttendanceModel> listAttendanceModel;
  final DateTime? fromDate;
  final DateTime? toDate;
  final String selectDateText;
  final LoadTimekeepingStatus loadStatus;
  const TimekeepingState(
      {this.listAttendanceModel = const [],
      this.fromDate,
      this.toDate,
      this.selectDateText = '',
      this.loadStatus = LoadTimekeepingStatus.success});
  TimekeepingState copyWith({
    List<AttendanceModel>? listAttendanceModel,
    DateTime? fromDate,
    DateTime? toDate,
    String? selectDateText,
    LoadTimekeepingStatus? loadStatus,
  }) {
    return TimekeepingState(
        listAttendanceModel: listAttendanceModel ?? this.listAttendanceModel,
        fromDate: fromDate ?? this.fromDate,
        toDate: toDate ?? this.toDate,
        selectDateText: selectDateText ?? this.selectDateText,
        loadStatus: loadStatus ?? this.loadStatus);
  }

  @override
  List<Object?> get props => [listAttendanceModel, selectDateText, loadStatus];
}

// class TimekeepingInitial extends TimekeepingState {}

// class TimekeepingLoading extends TimekeepingState {}

// class TimekeepingLoaded extends TimekeepingState {
//   final List<AttendanceModel> listAttendanceModel;
//   final DateTime fromDate;
//   final DateTime toDate;
//   final String selectDateText;
//   const TimekeepingLoaded(
//       {required this.listAttendanceModel,
//       required this.fromDate,
//       required this.toDate,
//       required this.selectDateText});
// }
