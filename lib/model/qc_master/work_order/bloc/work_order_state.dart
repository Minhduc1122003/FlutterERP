part of 'work_order_bloc.dart';

@immutable
abstract class WorkOrderState {}

class WorkOrderInitial extends WorkOrderState {}

class GetError extends WorkOrderState {
  final String errorMessage;

  GetError({required this.errorMessage});
}

class GetWaiting extends WorkOrderState {}

class GetSuccess extends WorkOrderState {
  final List<WorkOrderModel> data;
  GetSuccess({required this.data});
}
