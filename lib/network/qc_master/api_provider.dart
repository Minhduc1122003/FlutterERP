import 'package:dio/dio.dart';
import 'package:erp/config/constant.dart';
import 'package:erp/model/login/login_model.dart';

class ApiProvider {
  Dio dio = Dio();
  late Response response;
  String connErr = 'Please check your internet connection and try again';

  Future<Response> postConnect(url, data, apiToken) async {
    try {
      dio.options.headers['content-Type'] = 'application/json; charset=utf-8';
      dio.options.connectTimeout = 3000;
      dio.options.receiveTimeout = 2400;

      return await dio.post(url, data: data, cancelToken: apiToken);
    } on DioError catch (e) {
      //print(e.toString()+' | '+url.toString());
      if (e.type == DioErrorType.response) {
        int? statusCode = e.response!.statusCode;
        if (statusCode == STATUS_NOT_FOUND) {
          throw "Api not found";
        } else if (statusCode == STATUS_INTERNAL_ERROR) {
          throw "Internal Server Error";
        } else {
          throw e.error.message.toString();
        }
      } else if (e.type == DioErrorType.connectTimeout) {
        throw e.message.toString();
      } else if (e.type == DioErrorType.cancel) {
        throw 'cancel';
      }
      throw connErr;
    } finally {
      dio.close();
    }
  }

  Future<LoginModel> login(
      String email, String password, String site, apiToken) async {
    var postData = {'No_': email, 'Password': password, 'site': site};
    response = await postConnect(LOGIN_API, postData, apiToken);
    // ignore: unnecessary_null_comparison
    if (response.data['accessToken'].toString() != null) {
      LoginModel listData = LoginModel.fromJson(response.data['profile']);
      return listData;
    } else {
      throw response.data['msg'];
    }
  }
}
