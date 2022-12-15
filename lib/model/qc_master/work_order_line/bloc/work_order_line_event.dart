part of 'work_order_line_bloc.dart';

@immutable
abstract class WorkOrderLineEvent {}

class WorkOrderLine extends WorkOrderLineEvent {
  final String site;
  final String woNum;
  final apiToken;
  WorkOrderLine(this.site, this.woNum, this.apiToken);
}
