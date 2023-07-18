import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talk_a_tive/data_layer/data_provider/network/http_api_services.dart';
import 'package:talk_a_tive/data_layer/data_provider/network/network_api_services.dart';
import 'package:talk_a_tive/data_layer/model/user_sign_up_model.dart';
import '../../core/global_keys.dart';

class UserSignupRepository {
  HttpApiServices apiServices = NetworkApiServices();

  Future<Either<dynamic, UserSignupModel>> getUserSignUp({
    required String url,
    required Map data,
  }) async {
    try {
      final response = await apiServices.httpPostethod(url: url, body: data);
      log("signup repo success");
      getAccessToken(userSignupModelFromJson(response));
      setUserID(userSignupModelFromJson(response));
      return right(userSignupModelFromJson(response));
    } catch (e) {
      log("signup repo failed");
      return left(e);
    }
  }

  Future<void> getAccessToken(UserSignupModel userLoginModel) async {
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setString(GlobalKeys.accessToken, userLoginModel.token!);
    await sharedPref.setBool(GlobalKeys.userLoginKey, true);
  }

   Future<void> setUserID(UserSignupModel userLoginModel) async {
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setString(GlobalKeys.userIDKey, userLoginModel.id!);
  }
}
