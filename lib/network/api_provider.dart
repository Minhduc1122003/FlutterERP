import 'dart:convert';
import 'package:http/http.dart';
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

  Future<List<OnLeaveRequestModel>> getListOnLeaveRequest(
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

  Future<List<AdvanceRequestModel>> getListAdvanceRequest(
      String siteName, int employeeID, String token) async {
    response = await getConnect(
        '$getListAdvanceRequestAPI$siteName/$employeeID', token);
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

  Future<List<ShiftModel>> getListShiftModelByUser(
      int employeeID, String siteName, String token) async {
    response = await getConnect(
        "$getListShiftModelByUserAPI$employeeID/$siteName", token);
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
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      List responseList = json.decode(response.body);
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

  Future<List<RegionModel>> getRegion(String site, String token) async {
    // await Future.delayed(const Duration(milliseconds: 500), () {});
    // return CompanyModel.regionList;
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
    // await Future.delayed(const Duration(milliseconds: 500), () {});
    // return CompanyModel.regionList;
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
    // await Future.delayed(const Duration(milliseconds: 500), () {});
    // List<RegionModel> regionList = CompanyModel.regionList;
    // List<BranchModel> branchList = [];
    // for (RegionModel model in regionList) {
    //   branchList.addAll(model.branchList);
    // }
    // return branchList;
    response = await getConnect('$getBranchAPI$site', token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      List responseList = json.decode(response.body);
      List<BranchModel> lst =
          responseList.map((f) => BranchModel.fromMap(f)).toList();
      return lst;
    } else {
      return [];
    }
  }

  Future<String> postAddBranch(int id, int idArea, String site, String name,
      String description, String token) async {
    // await Future.delayed(const Duration(milliseconds: 500), () {});
    // return CompanyModel.regionList;
    var postData;
    if (id == -1) {
      postData = {
        'areaID': idArea,
        'name': name,
        'description': description,
        'siteID': site
      };
    } else {
      postData = {
        'id': id,
        'areaID': idArea,
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

  Future<String> postCheckin(int id, String employeeID, String authDate,
      String authTime, int location, String token) async {
    // await Future.delayed(const Duration(milliseconds: 500), () {});
    // return CompanyModel.regionList;
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
    // await Future.delayed(const Duration(milliseconds: 500), () {});
    // return CompanyModel.locationList;
    response = await getConnect('$getLocationAPI$site', token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      List responseList = json.decode(response.body);
      List<LocationModel> lst =
          responseList.map((f) => LocationModel.fromMap(f)).toList();
      return lst;
    } else {
      return [];
    }
  }

  Future<String> postAddLocation(
      int id,
      int branchID,
      String name,
      String address,
      String longitude,
      String latitude,
      String site,
      String token) async {
    // await Future.delayed(const Duration(milliseconds: 500), () {});
    // return CompanyModel.regionList;
    var postData;
    if (id == -1) {
      postData = {
        "id": id,
        "branchID": branchID,
        "name": name,
        "address": address,
        "longitude": longitude,
        "latitude": latitude,
        "siteID": site
      };
    } else {
      postData = {
        "branchID": branchID,
        "name": name,
        "address": address,
        "longitude": longitude,
        "latitude": latitude,
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

  Future<bool> getCheckInStatus() async {
    await Future.delayed(const Duration(milliseconds: 200), () {});
    return CompanyModel.checkInStatus;
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
}
