part of 'work_order_line_bloc.dart';

@immutable
abstract class WorkOrderLineState {}

class WorkOrderLineInitial extends WorkOrderLineState {}

class GetError extends WorkOrderLineState {
  final String errorMessage;

  GetError({required this.errorMessage});
}

class GetWaiting extends WorkOrderLineState {}

class GetSuccess extends WorkOrderLineState {
  final List<WorkOrderLineModel> data;
  GetSuccess({required this.data});
}