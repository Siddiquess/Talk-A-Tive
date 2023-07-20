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
import 'package:socket_io_client/socket_io_client.dart' as io;

part 'individual_chat_event.dart';
part 'individual_chat_state.dart';

class IndividualChatBloc
    extends Bloc<IndividualChatEvent, IndividualChatState> {
  final individualChatRepo = IndividualChatRepository();

  IndividualChatBloc() : super(IndividualChatState()) {
    final io.Socket socket = io.io(AppUrls.baseUrl,
        io.OptionBuilder().setTransports(['websocket']).build());

    socket.onConnect((_) {
      log("connected");
    });
    socket.on("message recieved", (data) {
      add(OnGetAllIndividualMessages(chatRoomId: data["chat"]["_id"]));
    });

    on<OnCreatIndividualChat>(
      (event, emit) async {
        final response = await individualChatRepo.creatChatRoom(
          url: AppUrls.createIndiChatRoom,
          body: event.roomChatBody(),
        );

        response.fold(
          (failure) => {
            emit(
              state.copyWith(
                indChatModel: ApiResponse.error(
                  failure.toString(),
                ),
              ),
            )
          },
          (success) => {
            emit(
              state.copyWith(
                indChatModel: ApiResponse.completed(
                  success,
                ),
              ),
            ),
            socket.emit("join chat", success.id),
          },
        );
      },
    );

    on<OnGetAllIndividualMessages>(
      (event, emit) async {
        List<Map<String, String>> updatedMessage = List.from(state.messages);
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
            updatedMessage.addAll(
              success.map(
                (element) => {
                  'id': element.sender!.id!,
                  'content': element.content!,
                },
              ),
            ),
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
        List<Map<String, String>> updatedMessage = List.from(state.messages);
        await UserID.getUserID().then(
          (userID) {
            updatedMessage.add(
              {"id": userID!, "content": event.message},
            );
          },
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
            emit(
              state.copyWith(
                messages: updatedMessage,
              ),
            ),
            log(success.toJson().toString()),
            socket.emit("new message", success.toJson())
          },
        );
      },
    );

    on<OnDisconnectSocketIO>((event, emit) {
      socket.dispose();
    });
  }
}
