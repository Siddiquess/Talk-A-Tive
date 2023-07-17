import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:talk_a_tive/core/constant.dart';
import 'package:talk_a_tive/data_layer/data_provider/response/api_response.dart';
import 'package:talk_a_tive/data_layer/model/get_individual_messages_model.dart';
import 'package:talk_a_tive/data_layer/model/individual_chat_model.dart';
import 'package:talk_a_tive/data_layer/repository/individual_chat_repository.dart';

part 'individual_chat_event.dart';
part 'individual_chat_state.dart';

class IndividualChatBloc
    extends Bloc<IndividualChatEvent, IndividualChatState> {
  final individualChatRepo = IndividualChatRepository();
  IndividualChatBloc() : super(IndividualChatState()) {
    on<OnCreatIndividualChat>(
      (event, emit) async {
        final response = await individualChatRepo.creatChatRoom(
            url: AppUrls.createIndiChatRoom, body: event.roomChatBody());

        response.fold(
          (failure) => {
            emit(
              IndividualChatState(
                indChatModel: ApiResponse.error(
                  failure.toString(),
                ),
              ),
            )
          },
          (success) => {
            emit(
              IndividualChatState(
                indChatModel: ApiResponse.completed(
                  success,
                ),
              ),
            )
          },
        );
      },
    );

    on<OnGetAllIndividualMessages>(
      (event, emit) async {
        List<String> updatedMessage = List.from(state.messages);
        final response = await individualChatRepo.getAllMessages(
            url: AppUrls.getAllMessages + event.chatRoomId);

        response.fold(
          (failure) => {},
          (success) => {
            success.forEach((element) {
              updatedMessage.add(element.content!);
              log(element.content.toString());
            }),
            emit(
              IndividualChatState(
                messages: updatedMessage,
                getAllindChatModel: ApiResponse.completed(success),
              ),
            ),
          },
        );
      },
    );

    on<OnSendChatMessageEvent>(
      (event, emit) {
        List<String> updatedMessage = List.from(state.messages);
        updatedMessage.add(event.message);
        emit(
          IndividualChatState(messages: updatedMessage),
        );
      },
    );
  }
}
