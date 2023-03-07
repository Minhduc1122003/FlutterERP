part of 'advance_bloc.dart';

abstract class AdvanceEvent extends Equatable {
  const AdvanceEvent();

  @override
  List<Object> get props => [];
}

class InitialAdvanceEvent extends AdvanceEvent {}

class ChoosseAdvanceKindEvent extends AdvanceEvent {
  final AdvanceKindModel advanceKind;
  const ChoosseAdvanceKindEvent({required this.advanceKind});
}

class ChoosseAdvanceFromDateEvent extends AdvanceEvent {
  final DateTime fromDate;
  const ChoosseAdvanceFromDateEvent({required this.fromDate});
}

class ChoosseAdvanceToDateEvent extends AdvanceEvent {
  final DateTime toDate;
  const ChoosseAdvanceToDateEvent({required this.toDate});
}

class SendAdvanceEvent extends AdvanceEvent {
  final String money;
  final String note;
  const SendAdvanceEvent({required this.money,required this.note});
}
