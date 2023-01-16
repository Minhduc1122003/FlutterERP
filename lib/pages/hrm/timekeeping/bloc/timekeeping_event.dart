part of 'timekeeping_bloc.dart';

@immutable
class TimekeepingEvent extends Equatable{
  const TimekeepingEvent();
  @override
  List<Object> get props => [];
}
class TimekeepingLoadToday extends TimekeepingEvent {}
class TimekeepingLoadMonth extends TimekeepingEvent {}
class TimekeepingLoadWeek extends TimekeepingEvent {}

class TimekeepingLoadRangeDate extends TimekeepingEvent {
  final DateTime fromDate;
  final DateTime toDate;
  const TimekeepingLoadRangeDate(
      {required this.fromDate, required this.toDate});
  @override
  List<Object> get props => [fromDate, toDate];
}