import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:talk_a_tive/data_layer/data_provider/network/http_api_services.dart';
import 'package:talk_a_tive/data_layer/data_provider/network/network_api_services.dart';
import 'package:talk_a_tive/data_layer/model/user_sign_up_model.dart';

class UserSignupRepository {
  HttpApiServices apiServices = NetworkApiServices();

  Future<Either<dynamic, UserSignupModel>> getUserSignUp({
    required String url,
    required Map data,
  }) async {
    try {
      final response = await apiServices.httpPostethod(url: url, body: data);
      log("signup repo success");
      return right(userSignupModelFromJson(response));
    } catch (e) {
      log("signup repo failed");
      return left(e);
    }
  }
}
