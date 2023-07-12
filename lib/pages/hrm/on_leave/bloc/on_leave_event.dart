part of 'on_leave_bloc.dart';

abstract class OnLeaveEvent extends Equatable {
  //const OnLeaveEvent();

  @override
  List<Object> get props => [];
}

class InitialOnLeaveEvent extends OnLeaveEvent {}

class SendOnLeaveEvent extends OnLeaveEvent {
  final String note;
  final double qty;
  SendOnLeaveEvent({required this.note, required this.qty});
}

class ChooseOnLeaveKindEvent extends OnLeaveEvent {
  final OnLeaveKindModel onLeaveKind;
  ChooseOnLeaveKindEvent({required this.onLeaveKind});
}

class ChooseExpirationDateEvent extends OnLeaveEvent {
  final DateTime expirationDate;
  ChooseExpirationDateEvent({required this.expirationDate});
}

class ChooseFromDateEvent extends OnLeaveEvent {
  final DateTime fromDate;
  ChooseFromDateEvent({required this.fromDate});
}

class ChooseToDateEvent extends OnLeaveEvent {
  final DateTime toDate;
  ChooseToDateEvent({required this.toDate});
}

class ChooseOnDayEvent extends OnLeaveEvent {
  final int onDay;
  ChooseOnDayEvent({required this.onDay});
}
