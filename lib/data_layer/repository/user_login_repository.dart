import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:talk_a_tive/data_layer/data_provider/network/http_api_services.dart';
import 'package:talk_a_tive/data_layer/data_provider/network/network_api_services.dart';
import 'package:talk_a_tive/data_layer/model/user_login_model.dart';

class UserLoginRepository {
  HttpApiServices apiServices = NetworkApiServices();

  Future<Either<dynamic,UserLoginModel>> getUserLogin({
    required String url,
    required Map body,
  }) async {
    try {
      final response = await apiServices.httpPostethod(url: url, body: body);
      log("repo success");
      return right(userLoginModelFromJson(response));
    } catch (e) {
      log(e.toString());
      log("repo failed");
      return left(e);
    }
  }
}
