import 'dart:developer';
import 'package:talk_a_tive/data_layer/data_provider/network/http_api_services.dart';
import '../app_exceptions.dart';
import 'package:dio/dio.dart';

class NetworkApiServices extends HttpApiServices {
  @override
  Future httpGetMethod({
    required String url,
    String? headers,
  }) async {

    final dio = Dio();
    try {
       dio.options.headers["Authorization"] = "Bearer $headers";
      final response = await dio.get(url);

      return returnResponse(response);
    } on DioException catch (e) {
      return returnResponse(e.response);
    }
  }

  @override
  Future httpPostethod({
    required String url,
    required Map body,
    String? headers,
  }) async {
    final dio = Dio();
    try {
      dio.options.headers["Authorization"] = "Bearer $headers";
      final response = await dio.post(
        url,
        data: body,
      );
      // log(response.data.toString());
      // log(response.statusCode.toString());

      return returnResponse(response);
    } on DioException catch (e) {
      return returnResponse(e.response);
    }
  }

  dynamic returnResponse(Response<dynamic>? response) {
    if (response != null) {
      final jsonBody = response.data;
      log("-----------------------");
      switch (response.statusCode) {
        case 200:
          log("1");
          return response.data;
        case 201:
          log("2");
          return response.data;
        case 400:
          log("3");
          throw FetchDataExceptions(jsonBody["message"]);
        case 401:
          log("4");
          throw UnauthorizedExeptions(jsonBody["message"]);
        case 500:
          log("5");
          throw UnauthorizedExeptions(jsonBody["message"]);
        default:
          log("6");
          throw InvalidException("Unknown error ${response.data}");
      }
    } else {
      throw FetchDataExceptions("No internet connection");
    }
  }
}
