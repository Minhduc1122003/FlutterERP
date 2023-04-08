part of 'timekeeping_offset_bloc.dart';

@immutable
abstract class TimekeepingOffsetEvent extends Equatable {
  //const TimekeepingOffsetEvent({required this.payload});
  //final dynamic payload;

  @override
  List<Object> get props => [];
}

class InitialTimekeepingOffsetEvent extends TimekeepingOffsetEvent {}

class SendTimekeepingOffsetEvent extends TimekeepingOffsetEvent {
  final String reason;
  final String note;
  SendTimekeepingOffsetEvent({required this.reason, required this.note});
}

class ChoosseTimekeepingOffsetShiftEvent extends TimekeepingOffsetEvent {
  final ShiftModel shiftModel;
  ChoosseTimekeepingOffsetShiftEvent({required this.shiftModel});
}

class ChoosseApplyDateEvent extends TimekeepingOffsetEvent {
  final DateTime applyDate;
  ChoosseApplyDateEvent({required this.applyDate});
}
