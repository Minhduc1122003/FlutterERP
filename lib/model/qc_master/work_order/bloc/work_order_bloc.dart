// ignore_for_file: unused_import, depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:erp/model/qc_master/work_order/work_order_model.dart';
import 'package:erp/network/qc_master/api_provider.dart';
import 'package:meta/meta.dart';

part 'work_order_event.dart';
part 'work_order_state.dart';

class WorkOrderBloc extends Bloc<WorkOrderEvent, WorkOrderState> {
  WorkOrderBloc() : super(WorkOrderInitial()) {
    on<WorkOrder>(_workOrder);
  }
}

void _workOrder(WorkOrder event, Emitter<WorkOrderState> emit) async {
  ApiProvider apiProvider = ApiProvider();

  emit(GetWaiting());
  try {
    List<WorkOrderModel> data = await apiProvider.getWorkOrderByUserStatus(
        event.site, event.assign, event.status, event.apiToken);
    emit(GetSuccess(data: data));
  } catch (ex) {
    if (ex != 'cancel') {
      emit(GetError(errorMessage: ex.toString()));
    }
  }
}
