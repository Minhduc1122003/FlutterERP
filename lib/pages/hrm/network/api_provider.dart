import 'dart:convert';
import 'package:erp/pages/hrm/hrm_model/user_model.dart';
import 'package:http/http.dart';

import '../hrm_config/hrm_constant.dart';
import '../hrm_model/on_leave_model.dart';
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

  Future<List<OnLeaveKindModel>> getListOnLeaveKind(
      SiteModel siteModel, String token) async {
    response = await getConnect(getOnLeaveKindAPI + siteModel.code, token);
    if (response.statusCode == statusOk) {
      List responseList = json.decode(response.body);
      return responseList.map((val) => OnLeaveKindModel.fromJson(val)).toList();
    } else {
      return [];
    }
  }

  Future<List<ShiftModel>> getListShiftModel(
      SiteModel siteModel, String token) async {
    response = await getConnect(getListShiftModelAPI + siteModel.code, token);
    if (response.statusCode == statusOk) {
      List responseList = json.decode(response.body);
      return responseList.map((val) => ShiftModel.fromJson(val)).toList();
    } else {
      return [];
    }
  }

  // Future<Map<String, dynamic>> login(Map<String, dynamic> map) async {
  //   response = await postConnect(loginAPI, map, '');
  //   if (response.statusCode == statusOk) {
  //     return json.decode(response.body);
  //   } else {
  //     return {};
  //   }
  // }

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

  Future<String> sendWorkdayCompensationRequest(
      Map<String, dynamic> map, String token) async {
    response = await postConnect(sendWorkdayCompensationRequestAPI, map, token);
    if (response.statusCode == statusOk ||
        response.statusCode == statusCreated) {
      return response.body;
    } else {
      return '';
    }
  }

  // Future<List<SellerModel>> getSellers(
  //     String site, int recShop, String token) async {
  //   response = await getConnect('$sellerAPI$site/$recShop/0/1', token);
  //   if (response.statusCode == statusOk) {
  //     List responseList = json.decode(response.body);
  //     return responseList.map((val) => SellerModel.fromJson(val)).toList();
  //   } else {
  //     return [];
  //   }
  // }
}
