import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:talk_a_tive/core/constant.dart';
import 'package:talk_a_tive/data_layer/data_provider/response/api_response.dart';
import 'package:talk_a_tive/data_layer/model/get_individual_messages_model.dart';
import 'package:talk_a_tive/data_layer/model/individual_chat_model.dart';
import 'package:talk_a_tive/data_layer/repository/individual_chat_repository.dart';
import '../../data_layer/model/send_individual_message_model.dart';

part 'individual_chat_event.dart';
part 'individual_chat_state.dart';

class IndividualChatBloc
    extends Bloc<IndividualChatEvent, IndividualChatState> {
  final individualChatRepo = IndividualChatRepository();
  IndividualChatBloc() : super(IndividualChatState()) {
    on<OnCreatIndividualChat>(
      (event, emit) async {
        final response = await individualChatRepo.creatChatRoom(
          url: AppUrls.createIndiChatRoom,
          body: event.roomChatBody(),
        );

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
          (failure) => {
            emit(
              state.copyWith(
                messages: updatedMessage,
                getAllindChatModel: ApiResponse.error(failure.toString()),
              ),
            ),
          },
          (success) => {
            for (var element in success)
              {
                updatedMessage.add(element.content!),
              },
            emit(
              state.copyWith(
                messages: updatedMessage,
                getAllindChatModel: ApiResponse.completed(success),
              ),
            ),
          },
        );
      },
    );

    on<OnSendChatMessageEvent>(
      (event, emit) async {
        List<String> updatedMessage = List.from(state.messages);
        updatedMessage.add(event.message);
        emit(
          state.copyWith(),
        );

        final response = await individualChatRepo.sendMessages(
          url: AppUrls.sendMessages,
          body: event.sendMessageBody(),
        );

        response.fold(
          (failure) => {
            state.copyWith(),
          },
          (success) => {
            log("updated ${updatedMessage.length}"),
            log("updated getall  length ${state.getAllindChatModel.data!.map((e) => e.content).last}"),
            emit(
              state.copyWith(
                messages: updatedMessage,
              ),
            )
          },
        );
      },
    );
  }
}
