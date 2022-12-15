// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:erp/model/qc_master/work_order_line/work_order_line_model.dart';
import 'package:erp/network/qc_master/api_provider.dart';
import 'package:meta/meta.dart';

part 'work_order_line_event.dart';
part 'work_order_line_state.dart';

class WorkOrderLineBloc extends Bloc<WorkOrderLineEvent, WorkOrderLineState> {
  WorkOrderLineBloc() : super(WorkOrderLineInitial()) {
    on<WorkOrderLine>(_workOrderLine);
  }
}

void _workOrderLine(WorkOrderLine event, Emitter<WorkOrderLineState> emit) async {
  ApiProvider apiProvider = ApiProvider();

  emit(GetWaiting());
  try {
    List<WorkOrderLineModel> data = await apiProvider.getWorkOrderLineByWO(
        event.site, event.woNum, event.apiToken);
    emit(GetSuccess(data: data));
  } catch (ex) {
    if (ex != 'cancel') {
      emit(GetError(errorMessage: ex.toString()));
    }
  }
}
