part of 'on_leave_bloc.dart';

enum SendOnLeaveStatus { initial, loading, success, failure }

class OnLeaveState extends Equatable {
  final List<OnLeaveKindModel> listOnLeaveKindModel;
  final OnLeaveKindModel? onLeaveKindModel;
  final DateTime? expirationDate;
  final DateTime? fromDate;
  final DateTime? toDate;
  final int onDay;
  final int totalDay;
  final SendOnLeaveStatus sendStatus;
  final String error;
  const OnLeaveState(
      {this.listOnLeaveKindModel = const [],
      this.onLeaveKindModel,
      this.expirationDate,
      this.fromDate,
      this.toDate,
      this.onDay = 0,
      this.totalDay = 0,
      this.sendStatus = SendOnLeaveStatus.initial,
      this.error = ''});

  OnLeaveState copyWith(
      {List<OnLeaveKindModel>? listOnLeaveKindModel,
      OnLeaveKindModel? onLeaveKindModel,
      DateTime? expirationDate,
      DateTime? fromDate,
      DateTime? toDate,
      int? totalDay,
      int? onDay,
      SendOnLeaveStatus? sendStatus,
      String? error}) {
    return OnLeaveState(
        listOnLeaveKindModel: listOnLeaveKindModel ?? this.listOnLeaveKindModel,
        onLeaveKindModel: onLeaveKindModel ?? this.onLeaveKindModel,
        expirationDate: expirationDate ?? this.expirationDate,
        fromDate: fromDate ?? this.fromDate,
        toDate: toDate ?? this.toDate,
        totalDay: totalDay ?? this.totalDay,
        onDay: onDay ?? this.onDay,
        sendStatus: sendStatus ?? this.sendStatus,
        error: error ?? this.error);
  }

  @override
  List<Object?> get props =>
      [onLeaveKindModel, expirationDate, fromDate, toDate, onDay,sendStatus];
}
