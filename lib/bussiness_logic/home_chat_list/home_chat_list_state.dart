part of 'home_chat_list_bloc.dart';

class HomeChatListState {
  ApiResponse<List<HomeChatListModel>> homeChatList;

  HomeChatListState({
    ApiResponse<List<HomeChatListModel>>? homeChatList,
  }) : homeChatList = homeChatList ?? ApiResponse.initial();
}
