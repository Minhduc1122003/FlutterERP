part of 'check_in_out_bloc.dart';

abstract class CheckInOutEvent extends Equatable {
  const CheckInOutEvent();

  @override
  List<Object> get props => [];
}

class InitialCheckInOutEvent extends CheckInOutEvent {}

class CheckInOutLoadLocationEvent extends CheckInOutEvent {}

class CheckInOutConfirmEvent extends CheckInOutEvent {}

class ChoosseLocationEvent extends CheckInOutEvent {
  final LocationModel location;
  const ChoosseLocationEvent({required this.location});
}

class ChoosseShiftEvent extends CheckInOutEvent {
  final ShiftModel shiftModel;
  const ChoosseShiftEvent({required this.shiftModel});
}

class CheckInPostEvent extends CheckInOutEvent {
  final int id;
  final String attendCode;
  final String authDate;
  final String authTime;
  final int locationID;
  final String token;
  const CheckInPostEvent(
      {required this.id,
      required this.attendCode,
      required this.authDate,
      required this.authTime,
      required this.locationID,
      required this.token});
}


