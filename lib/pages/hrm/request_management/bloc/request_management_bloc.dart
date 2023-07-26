import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:erp/model/login_model.dart';
import '../../../../model/hrm_model/employee_model.dart';
import '../../../../model/hrm_model/request_management_model.dart';
import '../../../../network/api_provider.dart';

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
      listRequestAll.addAll(await _getListAdvanceRequest());
      for (var request in listRequestAll) {
        if (request.status == 0) {
          listRequestNew.add(request);
        } else if (request.status == 3) {
          listRequestApprove.add(request);
        } else if (request.status == 4) {
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
          UserModel.siteName, UserModel.id, User.token);
  return list;
}

Future<List<OnLeaveRequestModel>> _getListOnLeaveRequest() async {
  List<OnLeaveRequestModel> list = await ApiProvider().getListOnLeaveRequest(
      UserModel.siteName, UserModel.id, DateTime.now().year, User.token);
  return list;
}

Future<List<AdvanceRequestModel>> _getListAdvanceRequest() async {
  List<AdvanceRequestModel> list = await ApiProvider()
      .getListAdvanceRequest(UserModel.siteName, UserModel.id, User.token);
  return list;
}
