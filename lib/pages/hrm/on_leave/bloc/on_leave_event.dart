part of 'on_leave_bloc.dart';

abstract class OnLeaveEvent extends Equatable {
  //const OnLeaveEvent();

  @override
  List<Object> get props => [];
}

class InitialOnLeaveEvent extends OnLeaveEvent {}

class SendOnLeaveEvent extends OnLeaveEvent {
  final String note;
  SendOnLeaveEvent({required this.note});
}

class ChoosseOnLeaveKindEvent extends OnLeaveEvent {
  final OnLeaveKindModel onLeaveKind;
  ChoosseOnLeaveKindEvent({required this.onLeaveKind});
}

class ChoosseExpirationDateEvent extends OnLeaveEvent {
  final DateTime expirationDate;
  ChoosseExpirationDateEvent({required this.expirationDate});
}

class ChoosseFromDateEvent extends OnLeaveEvent {
  final DateTime fromDate;
  ChoosseFromDateEvent({required this.fromDate});
}

class ChoosseToDateEvent extends OnLeaveEvent {
  final DateTime toDate;
  ChoosseToDateEvent({required this.toDate});
}

class ChoosseOnDayEvent extends OnLeaveEvent {
  final int onDay;
  ChoosseOnDayEvent({required this.onDay});
}
