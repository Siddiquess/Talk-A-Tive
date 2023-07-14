import 'dart:developer';
import 'package:talk_a_tive/data_layer/data_provider/network/http_api_services.dart';
import '../app_exceptions.dart';
import 'package:dio/dio.dart';

class NetworkApiServices extends HttpApiServices {
  @override
  Future httpGetMethod({
    required String url,
    bool haveHeader = false,
  }) async {
    // Map<String, String>? headers = haveHeader ? {} : {};

    final dio = Dio();
    try {
      final response = await dio.get(url);

      return returnResponse(response);
    } on DioException catch (e) {
      return returnResponse(e.response!);
    }
  }

  @override
  Future httpPostethod({
    required String url,
    required Map body,
    bool haveHeader = false,
  }) async {
    final dio = Dio();
    try {
      final response = await dio.post(
        url,
        data: {"email": "siddiquekp240@gmail.com", "password": "siddik@123"},
      );
      log("11111111111111111");
      // log(response.data.toString());
      // log(response.statusCode.toString());

      return returnResponse(response);
    } on DioException catch (e) {
      return returnResponse(e.response!);
    }
  }

  dynamic returnResponse(Response response) {
    final jsonBody = response.data;
    log("here========================");
    switch (response.statusCode) {
      case 200:
        log("1");
        return response.data;
      case 201:
        log("2");
        return response.data;
      case 400:
        log("3");
        return FetchDataExceptions(jsonBody["error"]);
      case 401:
        log("4");
        return UnauthorizedExeptions(jsonBody["message"]);
      default:
        log("5");
        return InvalidException("Unknown error ${response.statusCode}");
    }
  }
}
