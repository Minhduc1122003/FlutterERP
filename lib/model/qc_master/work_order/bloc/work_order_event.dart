// ignore_for_file: prefer_typing_uninitialized_variables

part of 'work_order_bloc.dart';

@immutable
abstract class WorkOrderEvent {}

class WorkOrder extends WorkOrderEvent {
  final String site;
  final String assign;
  final String status;
  final apiToken;
  WorkOrder(this.site, this.assign, this.status, this.apiToken);
}
