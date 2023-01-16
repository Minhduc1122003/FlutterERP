part of 'timekeeping_offset_bloc.dart';

@immutable
abstract class TimekeepingOffsetEvent extends Equatable {
  //const TimekeepingOffsetEvent({required this.payload});
  //final dynamic payload;

  @override
  List<Object> get props => [];
}

class InitialTimekeepingOffsetEvent extends TimekeepingOffsetEvent {}
class SendingTimekeepingOffsetEvent extends TimekeepingOffsetEvent {}

class ChoosseShiftEvent extends TimekeepingOffsetEvent {
  final ShiftModel shiftModel;
  ChoosseShiftEvent({required this.shiftModel});
}

class ChoosseApplyDateEvent extends TimekeepingOffsetEvent {
  final DateTime applyDate;
  ChoosseApplyDateEvent({required this.applyDate});
}
