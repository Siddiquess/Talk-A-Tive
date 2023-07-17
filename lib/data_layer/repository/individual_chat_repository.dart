import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:talk_a_tive/data_layer/data_provider/network/http_api_services.dart';
import 'package:talk_a_tive/data_layer/data_provider/network/network_api_services.dart';
import 'package:talk_a_tive/data_layer/model/get_individual_messages_model.dart';
import 'package:talk_a_tive/data_layer/model/individual_chat_model.dart';
import 'package:talk_a_tive/data_layer/model/send_individual_message_model.dart';
import '../../core/constant.dart';

class IndividualChatRepository {
  HttpApiServices apiServices = NetworkApiServices();

  Future<Either<dynamic, IndividualChatModel>> creatChatRoom(
      {required String url, required Map body}) async {
    try {
      final accessToken = await AccessToken.getAccessToken();
      final response = await apiServices.httpPostethod(
        url: url,
        body: body,
        headers: accessToken,
      );
      log("Individual chat repo success");
      return right(individualChatModelFromJson(response));
    } catch (e) {
      log("Individual chat repo failed");
      log(e.toString());
      return left(e);
    }
  }

  Future<Either<dynamic, List<GetIndividualMessagesModel>>> getAllMessages(
      {required String url}) async {
    try {
      final accessToken = await AccessToken.getAccessToken();
      final response = await apiServices.httpGetMethod(
        url: url,
        headers: accessToken,
      );
      log("get all msg repo success");
      return right(getIndividualMessagesModelFromJson(response));
    } catch (e) {
      log("get all msg repo failed");
      log(e.toString());
      return left(e);
    }
  }

  Future<Either<dynamic, SendIndividualMessageModel>> sendMessages(
      {required String url, required Map body}) async {
    try {
      final accessToken = await AccessToken.getAccessToken();
      final response = await apiServices.httpPostethod(
        url: url,
        body: body,
        headers: accessToken,
      );
      log("send msg repo success");
      return right(sendIndividualMessageModelFromJson(response));
    } catch (e) {
      log("send msg repo failed");
      log(e.toString());
      return left(e);
    }
  }
}
