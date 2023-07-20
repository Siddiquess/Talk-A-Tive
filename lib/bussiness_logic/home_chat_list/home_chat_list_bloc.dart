import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:talk_a_tive/core/constant.dart';
import 'package:talk_a_tive/data_layer/data_provider/response/api_response.dart';
import 'package:talk_a_tive/data_layer/model/get_all_user_list_model.dart';
import 'package:talk_a_tive/data_layer/repository/home_chat_list_repository.dart';
import '../../data_layer/model/home_chat_list_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
part 'home_chat_list_event.dart';
part 'home_chat_list_state.dart';

class HomeChatListBloc extends Bloc<HomeChatListEvent, HomeChatListState> {
  final homechatRepo = HomeChatListRepository();
  final io.Socket socket = io.io(AppUrls.baseUrl, <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
  });

  HomeChatListBloc()
      : super(HomeChatListState(homeChatList: ApiResponse.initial())) {
    socket.connect();
    socket.onConnect((_) {
      log("connected in home");
    });
    socket.on('message', (data) {});
    socket.on("message recieved", (data) {
      add(GetHomeChatListEvent(shouldTriggered: true));
    });

    on<GetHomeChatListEvent>(
      (event, emit) async {
        UserID.getUserID().then(
          (userID) => {
            socket.emit("setup", {"_id": userID}),
          },
        );

        if (state.homeChatList.data != null && event.shouldTriggered == false) {
          if (state.homeChatList.data!.isNotEmpty) {
            emit(
              HomeChatListState(
                homeChatList: state.homeChatList,
              ),
            );
          }
        }
        if (event.shouldTriggered == false) {
          emit(
            HomeChatListState(
              homeChatList: ApiResponse.loading(),
            ),
          );
        }

        final response =
            await homechatRepo.getHomeChatList(url: AppUrls.homeChatList);

        response.fold(
          (failure) => {
            emit(
              HomeChatListState(
                homeChatList: ApiResponse.error(
                  failure.toString(),
                ),
              ),
            ),
          },
          (success) => {
            emit(
              HomeChatListState(
                homeChatList: ApiResponse.completed(success),
              ),
            ),
            log(state.homeChatList.data.toString()),
          },
        );
      },
    );

    on<GetSearchChatList>(
      (event, emit) async {
        emit(
          state.copyWith(),
        );

        final response = await homechatRepo.getUserList(
          url: AppUrls.searchUserList + event.chatQuery,
        );

        response.fold(
          (failure) => {
            emit(
              state.copyWith(
                searchUserList: ApiResponse.error(
                  failure.toString(),
                ),
              ),
            ),
          },
          (success) => {
            emit(
              state.copyWith(
                searchUserList: ApiResponse.completed(success),
              ),
            ),
          },
        );
      },
    );
  }
}
