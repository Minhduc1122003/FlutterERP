part of 'timekeeping_bloc.dart';
//import 'package:equatable/equatable.dart';

@immutable
abstract class TimekeepingState extends Equatable {
  const TimekeepingState();
  @override
  List<Object> get props => [];
}

class TimekeepingInitial extends TimekeepingState {}

class TimekeepingLoading extends TimekeepingState {}

class TimekeepingLoaded extends TimekeepingState {
  final List<AttendanceModel> listAttendanceModel;
  final DateTime fromDate;
  final DateTime toDate;
  final String selectDateText;
  const TimekeepingLoaded(
      {required this.listAttendanceModel,
      required this.fromDate,
      required this.toDate,
      required this.selectDateText});
}