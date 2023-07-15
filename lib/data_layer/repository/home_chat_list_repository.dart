import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:talk_a_tive/core/constant.dart';
import 'package:talk_a_tive/data_layer/data_provider/network/http_api_services.dart';
import 'package:talk_a_tive/data_layer/data_provider/network/network_api_services.dart';
import 'package:talk_a_tive/data_layer/model/home_chat_list_model.dart';

class HomeChatListRepository {
  HttpApiServices apiServices = NetworkApiServices();

  Future<Either<dynamic, List<HomeChatListModel>>> getHomeChatList({
    required String url,
  }) async {
    try {
      final accessToken = await AccessToken.getAccessToken();
      final response = await apiServices.httpGetMethod(
        url: url,
        headers: accessToken,
      );
      log("Home repo success");
      return right(homeChatListModelFromJson(response));
    } catch (e) {
      log("Home repo failed");
      log(e.toString());
      return left(e);
    }
  }
}
