import 'dart:convert';
import 'package:erp/pages/hrm/hrm_model/user_model.dart';
import 'package:http/http.dart';

import '../../../model/login_model.dart';
import '../hrm_config/hrm_constant.dart';
import '../hrm_model/advance_model.dart';
import '../hrm_model/attendance_model.dart';
import '../hrm_model/on_leave_model.dart';
import '../hrm_model/request_management_model.dart';
import '../hrm_model/salary_model.dart';
import '../hrm_model/shift_model.dart';

class ApiProvider {
  late Response response;
  String connErr = 'Please check your internet connection and try again';

  Future<Response> getConnect(String url, String token) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      return await get(Uri.parse(url), headers: headers);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Response> postConnect(
      String url, Map<String, dynamic> map, String token) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final uri = Uri.parse(url);
    var body = jsonEncode(map);
    final encoding = Encoding.getByName('utf-8');
    try {
      return await post(
        uri,
        headers: headers,
        body: body,
        encoding: encoding,
      );
    } catch (e) {
      throw e.toString();
    }
  }

  Future<LoginModel?> login(
      String email, String password, String site, String token) async {
    var postData = {'no_': email, 'password': password, 'site': site};
    response = await postConnect(loginAPI, postData, token);
    if (response.statusCode == statusOk) {
      //var responseJson = jsonEncode(response.body);
      LoginModel model = LoginModel.fromJson(jsonDecode(response.body));
      return model;
    } else {
      return null;
    }
  }

  Future<List<OnLeaveKindModel>> getListOnLeaveKind(
      String siteName, String token) async {
    response = await getConnect(getOnLeaveKindAPI + siteName, token);
    if (response.statusCode == statusOk) {
      List responseList = json.decode(response.body);
      return responseList.map((val) => OnLeaveKindModel.fromJson(val)).toList();
    } else {
      return [];
    }
  }

  Future<List<OnLeaveRequestModel>> getListOnLeaveRequestModel(
      String siteName, int employeeID, int year, String token) async {
    response = await getConnect(
        '$getListOnLeaveRequestAPI$employeeID/$year/$siteName', token);
    if (response.statusCode == statusOk) {
      List responseList = json.decode(response.body);
      return responseList
          .map((val) => OnLeaveRequestModel.fromJson(val))
          .toList();
    } else {
      return [];
    }
  }

  Future<List<TimekeepingOffsetRequestModel>> getListTimekeepingOffsetRequest(
      String siteName, int employeeID, String token) async {
    response = await getConnect(
        '$getListTimekeepingOffsetRequestAPI$employeeID/$siteName', token);
    if (response.statusCode == statusOk) {
      List responseList = json.decode(response.body);
      return responseList
          .map((val) => TimekeepingOffsetRequestModel.fromJson(val))
          .toList();
    } else {
      return [];
    }
  }

  Future<String> sendOnLeaveRequest(
      Map<String, dynamic> map, String token) async {
    response = await postConnect(sendOnLeaveRequestAPI, map, token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      return response.body;
    } else {
      return '';
    }
  }

  Future<List<ShiftModel>> getListShiftModel(
      String siteName, String token) async {
    response = await getConnect(getListShiftModelAPI + siteName, token);
    if (response.statusCode == statusOk) {
      List responseList = json.decode(response.body);
      return responseList.map((val) => ShiftModel.fromJson(val)).toList();
    } else {
      return [];
    }
  }

  Future<String> sendTimekeepingOffsetRequest(
      Map<String, dynamic> map, String token) async {
    response = await postConnect(sendTimekeepingOffsetRequestAPI, map, token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      return response.body;
    } else {
      return '';
    }
  }

  Future<List<AdvanceKindModel>> getListAdvanceKind(
      String siteName, String token) async {
    response = await getConnect(getAdvanceKindAPI + siteName, token);
    if (response.statusCode == statusOk) {
      List responseList = json.decode(response.body);
      return responseList.map((val) => AdvanceKindModel.fromJson(val)).toList();
    } else {
      return [];
    }
  }

  Future<String> sendAdvanceRequest(
      Map<String, dynamic> map, String token) async {
    response = await postConnect(sendAdvanceRequestAPI, map, token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      return response.body;
    } else {
      return '';
    }
  }

  Future<List<AttendanceModel>> getListAttendance(
      String siteName, Map<String, dynamic> map, String token) async {
    response = await postConnect(getListAttendanceAPI + siteName, map, token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      List responseList = json.decode(response.body);
      return responseList.map((val) => AttendanceModel.fromJson(val)).toList();
    } else {
      return [];
    }
  }

  Future<List<AttendanceModel>> getListAttendanceInvalid(
      String siteName, Map<String, dynamic> map, String token) async {
    response = await postConnect(getListAttendanceInvalidAPI + siteName, map, token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      List responseList = json.decode(response.body);
      return responseList.map((val) => AttendanceModel.fromJson(val)).toList();
    } else {
      return [];
    }
  }

  Future<List<SalaryPeriodModel>> getListSalaryPeriod(
      String siteName, String token) async {
    response = await getConnect(getListSalaryPeriodAPI + siteName, token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      List responseList = json.decode(response.body);
      return responseList
          .map((val) => SalaryPeriodModel.fromJson(val))
          .toList();
    } else {
      return [];
    }
  }

  Future<List<TimeSheetModel>> getTimeSheets(
      Map<String, dynamic> map, String token) async {
    response = await postConnect(getTimeSheetsAPI, map, token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      List responseList = json.decode(response.body);
      return responseList.map((val) => TimeSheetModel.fromJson(val)).toList();
    } else {
      return [];
    }
  }

  Future<List<SalaryCaculateModel>> getSalaryCaculate(
      int employeeId, int periodId, String token) async {
    response =
        await getConnect('$getSalaryCaculateAPI$employeeId/$periodId', token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      List responseList = json.decode(response.body);
      return responseList
          .map((val) => SalaryCaculateModel.fromJson(val))
          .toList();
    } else {
      return [];
    }
  }
}
