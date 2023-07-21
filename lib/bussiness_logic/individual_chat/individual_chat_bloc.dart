import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  final io.Socket socket = io.io(AppUrls.baseUrl, <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
  });

  IndividualChatBloc() : super(IndividualChatState()) {
    on<OnConnectSocketIO>((event, emit) {
      socket.connect();
      socket.onConnect((_) {
        log("connected in chat");
      });
    });

    socket.on(
      "message recieved",
      (data) {
        log("socket message recieved");
        add(OnSocketRecivedMessage(response: data));
      },
    );

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
                messages: state.messages,
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
        List<Map<String, String>> updatedMessage = [];
        final response = await individualChatRepo.getAllMessages(
            url: AppUrls.getAllMessages + event.chatRoomId);

        response.fold(
          (failure) => {
            emit(
              state.copyWith(
                messages: state.messages,
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
                  'chatTime': DateFormat('h:mm a').format(element.createdAt!),
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
              {
                "id": userID!,
                "content": event.message,
                "chatTime": DateFormat('h:mm a').format(DateTime.now())
              },
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
            socket.emit("new message", success.toJson())
          },
        );
      },
    );

    on<OnSocketRecivedMessage>(
      (event, emit) {
        List<Map<String, String>> updatedMessage = List.from(state.messages);
        Map<String, String> recievedMsg = {
          "id": event.response["sender"]["_id"],
          "content": event.response["content"],
          "chatTime": DateFormat('h:mm a')
              .format(DateTime.now())
        };
        updatedMessage.add(recievedMsg);
        emit(
          state.copyWith(
            messages: updatedMessage,
          ),
        );
      },
    );

    on<OnDisconnectSocketIO>((event, emit) {
      log("disconnected");
      // socket.disconnect();
    });
  }
}
