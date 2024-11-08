import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:erp/model/hrm_model/employee_model.dart';
import 'package:erp/pages/hrm/create_shift/create_shift_model.dart';
import 'package:erp/pages/hrm/create_shift/get_list_shift_model.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import '../model/hrm_model/advance_model.dart';
import '../model/hrm_model/attendance_model.dart';
import '../model/hrm_model/company_model.dart';
import '../model/hrm_model/on_leave_model.dart';
import '../model/hrm_model/request_management_model.dart';
import '../model/hrm_model/salary_model.dart';
import '../model/hrm_model/shift_model.dart';
import '../model/login_model.dart';
import '../config/hrm_constant.dart';

class ApiProvider {
  late Response response;
  final mapApiKey = 'AIzaSyCQc5-z5GzthnqCu1Ow1zUbndwnxNCF88Y';
  //final mapApiKey = 'AIzaSyA8ak7h0EO5GAIj7EfIzuMHzmHJ1y8g-0Q';
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

  Future<Response> patchConnect(
      String url, Map<String, dynamic> map, String token) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final uri = Uri.parse(url);
    var body = jsonEncode(map);
    final encoding = Encoding.getByName('utf-8');
    try {
      return await patch(
        uri,
        headers: headers,
        body: body,
        encoding: encoding,
      );
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Response> postConnect2(String url, String body, String token) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final uri = Uri.parse(url);
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

  Future<Response> deleteConnect(String url, String token) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final uri = Uri.parse(url);
    final encoding = Encoding.getByName('utf-8');
    try {
      return await delete(
        uri,
        headers: headers,
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
      LoginModel model = LoginModel.fromJson(jsonDecode(response.body));
      return model;
    } else {
      return null;
    }
  }

  // GET INFO EMPLOYEE
  Future<Map<String, dynamic>> getInfoEmployee(
      int id, String siteName, String token) async {
    response =
        await getConnect('$getInfoEmployeeAPI$id/$siteName/salary', token);
    if (response.statusCode == statusOk) {
      List<dynamic> model = json.decode(response.body);
      return model[0]; // Trả về phần tử đầu tiên của danh sách dưới dạng Map
    } else {
      throw Exception(
          'Failed to load employee data'); // Ném ngoại lệ khi có lỗi
    }
  }

  Future<Map<String, dynamic>?> getInfoMobile(
      int id, String siteID, String token) async {
    response = await getConnect('$getInfoMobileAPI$id/$siteID', token);
    print(response.body);
    if (response.statusCode == statusOk) {
      dynamic responseBody = json.decode(response.body);
      if (responseBody is List && responseBody.isNotEmpty) {
        Map<String, dynamic> model = responseBody.first as Map<String, dynamic>;
        return model;
      }
    }
    return null;
  }

  Future<Map<String, dynamic>?> GetInsuranceAreaByIdEmployee(
      int id, String siteID, String token) async {
    var postData = {'IdEmployee': id, 'siteID': siteID};
    response =
        await postConnect(GetInsuranceAreaByIdEmployeeAPI, postData, token);
    dynamic responseBody = json.decode(response.body);
    if (responseBody is List && responseBody.isNotEmpty) {
      Map<String, dynamic> model = responseBody.first as Map<String, dynamic>;
      return model;
    }
  }

  // GET LIST ONLEAVE KIND
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

  Future<List<OnLeaveRequestModel>> getListOnLeaveRequest(
      String siteName, int employeeID, int year, String token) async {
    response = await getConnect(
        '$getListOnLeaveRequestAPI$employeeID/$year/$siteName', token);
    print(response.statusCode);
    print('OnLeaveRequestModel body: ${response.body}');

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
    print(response.statusCode);
    print('TimekeepingOffsetRequestModelResponse body: ${response.body}');

    if (response.statusCode == statusOk) {
      List responseList = json.decode(response.body);
      return responseList
          .map((val) => TimekeepingOffsetRequestModel.fromJson(val))
          .toList();
    } else {
      return [];
    }
  }

  Future<List<AdvanceRequestModel>> getListAdvanceRequest(
      String siteName, int employeeID, String token) async {
    response = await getConnect(
        '$getListAdvanceRequestAPI$siteName/$employeeID', token);
    print(response.statusCode);
    print('AdvanceRequestModel body: ${response.body}');

    if (response.statusCode == statusOk) {
      List responseList = json.decode(response.body);
      return responseList
          .map((val) => AdvanceRequestModel.fromJson(val))
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

  Future<List<GetListShiftModel>> getAllListShift(String token) async {
    final response = await getConnect('$getAllListShiftAPI/REEME', token);
    if (response.statusCode == statusOk) {
      List responseList = json.decode(response.body);
      return responseList
          .map((val) => GetListShiftModel.fromJson(val))
          .toList();
    } else {
      return [];
    }
  }

  Future<String> createShift(CreateShiftModel createShift, String token) async {
    var postData = {
      'code': createShift.code,
      'title': createShift.title,
      'shiftType': createShift.shiftType,
      'status': createShift.status,
      'fromTime': createShift.fromTime,
      'toTime': createShift.toTime,
      'workTime': createShift.workTime,
      'timeCalculate': createShift.timeCalculate,
      'coefficient': createShift.coefficient,
      'startBreak': createShift.startBreak,
      'endBreak': createShift.endBreak,
      'totalBreak': createShift.totalBreak,
      'isCrossDay': createShift.isCrossDay,
      'createdBy': createShift.createdBy,
      'siteID': createShift.siteID,
      'note': createShift.note
    };

    // Print postData
    print('Post Data: $postData');

    // Make the POST request
    final response = await postConnect(createShiftAPI, postData, token);
    print('Status Code: ${response.statusCode}');

    // Handle response
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      return response.body;
    } else {
      return '';
    }
  }

  Future<String> updateShift(
      CreateShiftModel updateShift, int id, String token) async {
    var postData = {
      'code': updateShift.code,
      'title': updateShift.title,
      'shiftType': updateShift.shiftType,
      'status': updateShift.status,
      'fromTime': updateShift.fromTime,
      'toTime': updateShift.toTime,
      'workTime': updateShift.workTime,
      'timeCalculate': updateShift.timeCalculate,
      'coefficient': updateShift.coefficient,
      'startBreak': updateShift.startBreak,
      'endBreak': updateShift.endBreak,
      'totalBreak': updateShift.totalBreak,
      'isCrossDay': updateShift.isCrossDay,
      'createdBy': updateShift.createdBy,
      'siteID': updateShift.siteID,
      'note': updateShift.note
    };

    // Print postData
    print('Post Data: $postData');

    // Make the POST request
    final response = await patchConnect('$createShiftAPI/$id', postData, token);
    print('Status Code: ${response.statusCode}');

    // Handle response
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      return response.body;
    } else {
      return '';
    }
  }

  Future<String> deleteShift(int id, String token) async {
    final response = await deleteConnect('$createShiftAPI/$id', token);
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
      return responseList.map((val) => ShiftModel.fromMap(val)).toList();
    } else {
      return [];
    }
  }

  Future<List<ShiftModel>> getListShiftModelByUser(
      int employeeID, String siteName, String token) async {
    DateTime now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    var postData = {
      "employeeID": employeeID,
      "date": formattedDate,
      "siteID": siteName
    };
    print('postData getListShiftModelByUser: $postData');

    response = await postConnect(getListShiftModelByUserAPI, postData, token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      List responseList = json.decode(response.body);
      print(responseList);

      List<ShiftModel> lst =
          responseList.map((f) => ShiftModel.fromMap(f)).toList();
      return lst;
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

  Future<String?> sendAdvanceRequest(
      Map<String, dynamic> map, String token) async {
    List<dynamic> listData = [];
    listData.add(map);
    // var json = {'listKey': jsonEncode(listData)};
    response =
        await postConnect2(sendAdvanceRequestAPI, jsonEncode(listData), token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      return response.body;
    } else {
      return null;
    }
  }

  Future<List<AttendanceModel>> getListAttendance(
      String siteName, Map<String, dynamic> map, String token) async {
    response = await postConnect(getListAttendanceAPI + siteName, map, token);
    print('data map: ${map}');

    print('data getListAttendance: ${response.statusCode}');

    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      List responseList = json.decode(response.body);
      print('body: $responseList');

      return responseList.map((val) => AttendanceModel.fromJson(val)).toList();
    } else {
      return [];
    }
  }

  Future<int> getListAttendanceInvalid(
      String siteName, Map<String, dynamic> map, String token) async {
    response =
        await postConnect(getListAttendanceInvalidAPI + siteName, map, token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      List responseList = json.decode(response.body);
      return responseList.length;
    } else {
      return -1;
    }
  }

  Future<List<SalaryPeriodModel>> getListSalaryPeriod(
      String siteName, String token) async {
    response = await getConnect(getListSalaryPeriodAPI + siteName, token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      List responseList = json.decode(response.body);
      print('responseList ${responseList}');
      List<SalaryPeriodModel> lst =
          responseList.map((val) => SalaryPeriodModel.fromJson(val)).toList();
      return lst;
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

  Future<List<SummaryOffsetModel>> getOffsetAndOnLeave(
      Map<String, dynamic> map, String token) async {
    response = await postConnect(getOffsetAndOnLeaveAPI, map, token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      List responseList = json.decode(response.body);
      return responseList
          .map((val) => SummaryOffsetModel.fromJson(val))
          .toList();
    } else {
      return [];
    }
  }

  Future<List<SalaryCaculateModel>> getSalaryCaculate(
      int employeeId, int periodId, String token) async {
    response =
        await getConnect('$getSalaryCaculateAPI$employeeId/$periodId', token);
    print("listSalaryCaculateModel: ${response.statusCode}");

    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      List responseList = json.decode(response.body);
      print("listSalaryCaculateModel: $responseList");

      return responseList
          .map((val) => SalaryCaculateModel.fromJson(val))
          .toList();
    } else {
      return [];
    }
  }

  Future<List<RegionModel>> getRegion(String site, String token) async {
    response = await getConnect('$getRegionAPI$site', token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      List responseList = json.decode(response.body);
      List<RegionModel> lst =
          responseList.map((f) => RegionModel.fromMap(f)).toList();
      return lst;
    } else {
      return [];
    }
  }

  Future<String> postAddRegion(int id, String site, String name,
      String description, String token) async {
    var postData;
    if (id == -1) {
      postData = {'name': name, 'description': description, 'siteID': site};
    } else {
      postData = {
        'id': id,
        'name': name,
        'description': description,
        'siteID': site
      };
    }

    response = await postConnect(postAddRegionAPI, postData, token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      return "OK";
    } else {
      return "";
    }
  }

  Future<List<BranchModel>> getBranch(String site, String token) async {
    response = await getConnect('$getBranchAPI$site', token);
    print('response: ${response.statusCode}');
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      List responseList = json.decode(response.body);
      print('responseList body: $responseList');
      List<BranchModel> lst =
          responseList.map((f) => BranchModel.fromMap(f)).toList();
      return lst;
    } else {
      return [];
    }
  }

  Future<String> postAddBranch(int id, int areaID, String site, String name,
      String description, String token) async {
    var postData;
    if (id == -1) {
      postData = {
        'areaID': areaID,
        'name': name,
        'description': description,
        'siteID': site
      };
    } else {
      postData = {
        'id': id,
        'areaID': areaID,
        'name': name,
        'description': description,
        'siteID': site
      };
    }

    response = await postConnect(postAddBranchAPI, postData, token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      return "OK";
    } else {
      return "";
    }
  }

  Future<String> deleteBranch(int id, String token) async {
    response = await deleteConnect('$getBranchAPI$id', token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      return "OK";
    } else {
      return "";
    }
  }

  Future<String> postCheckin(int id, String employeeID, String authDate,
      String authTime, int location, String token) async {
    var postData;
    if (id == -1) {
      postData = {
        "employeeID": employeeID,
        "authDate": authDate,
        "authTime": authTime,
        "location": location
      };
    } else {
      postData = {
        'id': id,
        "employeeID": employeeID,
        "authDate": authDate,
        "authTime": authTime,
        "location": location
      };
    }

    response = await postConnect(postCheckInAPI + User.site, postData, token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      return "OK";
    } else {
      return "";
    }
  }

  Future<List<LocationModel>> getLocation(String site, String token) async {
    response = await getConnect('$getLocationAPI$site', token);
    print('response${response.statusCode}');
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      List responseList = json.decode(response.body);
      print('responseList${responseList}');

      List<LocationModel> lst =
          responseList.map((f) => LocationModel.fromMap(f)).toList();
      return lst;
    } else {
      return [];
    }
  }

  Future<String> postUpdateLocation(
      int id,
      int branchID,
      String name,
      String address,
      String longitude,
      String latitude,
      String site,
      int radius,
      String token) async {
    var postData = {
      "id": id,
      "branchID": branchID,
      "name": name,
      "address": address,
      "longitude": longitude,
      "latitude": latitude,
      "radius": radius,
      "createdBy": site,
    };

    response = await patchConnect('$updateLocationAPI/$id', postData, token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      print('Update OK');
      return "OK";
    } else {
      return "";
    }
  }

  Future<String> postAddLocation(
      int id,
      int branchID,
      String name,
      String address,
      String longitude,
      String latitude,
      int radius,
      String site,
      String token) async {
    var postData;
    if (id == -1) {
      postData = {
        "id": id,
        "branchID": branchID,
        "name": name,
        "address": address,
        "longitude": longitude,
        "latitude": radius,
        "radius": latitude,
        "siteID": site
      };
    } else {
      postData = {
        "branchID": branchID,
        "name": name,
        "address": address,
        "longitude": longitude,
        "latitude": latitude,
        "radius": radius,
        "siteID": site
      };
    }

    response = await postConnect(getLocationAPI, postData, token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      return "OK";
    } else {
      return "";
    }
  }

  Future<String> deleteLocation(int id, String token) async {
    response = await deleteConnect('$getLocationAPI$id', token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      return "OK";
    } else {
      return "";
    }
  }

  Future<bool> getCheckInStatus(String site, String token) async {
    DateTime now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    var postData = {"employeeID": UserModel.id, "day": formattedDate};

    response = await postConnect('$getScanByDay$site', postData, token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      List responseList = json.decode(response.body);
      if (responseList.length % 2 == 0) {
        return false;
      }
    }
    return true;
  }

  Future<ShiftModel?> getCheckInShift() async {
    await Future.delayed(const Duration(milliseconds: 200), () {});
    return CompanyModel.shiftModel;
  }

  Future<List<PlaceSearchModel>> getAutocomplete(String search) async {
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&components=country:VN&types=address&language=vi&key=$mapApiKey');
    var response = await get(url);
    var json = jsonDecode(response.body);
    var jsonResults = json['predictions'] as List;
    return jsonResults
        .map((place) => PlaceSearchModel.fromJson(place))
        .toList();
  }

  Future<PlaceModel> getPlace(String placeId) async {
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$mapApiKey');
    var response = await get(url);
    var json = jsonDecode(response.body);
    var jsonResult = json['result'] as Map<String, dynamic>;
    return PlaceModel.fromJson(jsonResult);
  }

  Future<int> getScanByDate(String site, int employeeID, String token) async {
    DateTime now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    var postData = {"employeeID": employeeID, "day": formattedDate};

    response = await postConnect('$getScanByDay$site', postData, token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      List responseList = json.decode(response.body);
      return responseList.length;
    } else {
      return -1;
    }
  }
}
