import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../hrm_model/employee_model.dart';
import '../../hrm_model/request_management_model.dart';
import '../../network/api_provider.dart';

part 'request_management_event.dart';
part 'request_management_state.dart';

class RequestManagementBloc
    extends Bloc<RequestManagementEvent, RequestManagementState> {
  RequestManagementBloc() : super(RequestManagementInitial()) {
    on<RequestManagementLoadEvent>((event, emit) async {
      emit(RequestManagementLoading());
      List<dynamic> listRequestAll = [];
      List<dynamic> listRequestNew = [];
      List<dynamic> listRequestApprove = [];
      List<dynamic> listRequestReject = [];
      listRequestAll.addAll(await _getListTimekeepingOffsetRequest());
      listRequestAll.addAll(await _getListOnLeaveRequest());
      for (var request in listRequestAll) {
        if (request.status == 0) {
          listRequestNew.add(request);
        } else if (request.status == 1) {
          listRequestApprove.add(request);
        } else if (request.status == 2) {
          listRequestReject.add(request);
        }
      }
      emit(RequestManagementLoaded(
          listRequestNew: listRequestNew,
          listRequestApprove: listRequestApprove,
          listRequestReject: listRequestReject));
    });
  }
}

Future<List<TimekeepingOffsetRequestModel>>
    _getListTimekeepingOffsetRequest() async {
  List<TimekeepingOffsetRequestModel> list = await ApiProvider()
      .getListTimekeepingOffsetRequest(
          EmployeeModel.siteName, EmployeeModel.id, '');
  return list;
}

Future<List<OnLeaveRequestModel>> _getListOnLeaveRequest() async {
  List<OnLeaveRequestModel> list = await ApiProvider()
      .getListOnLeaveRequestModel(
          EmployeeModel.siteName, EmployeeModel.id, DateTime.now().year, '');
  return list;
}