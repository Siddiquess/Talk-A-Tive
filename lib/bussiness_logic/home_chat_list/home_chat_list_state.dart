part of 'home_chat_list_bloc.dart';

class HomeChatListState {
  ApiResponse<List<HomeChatListModel>> homeChatList;
  ApiResponse<List<GetAllUserListModel>> searchUserList = ApiResponse.initial();

  HomeChatListState({
    ApiResponse<List<HomeChatListModel>>? homeChatList,
     searchUserList,
  })  : homeChatList = homeChatList ?? ApiResponse.initial(),
        searchUserList = searchUserList ?? ApiResponse.initial();

  HomeChatListState copyWith({
    ApiResponse<List<HomeChatListModel>>? homeChatList,
    ApiResponse<List<GetAllUserListModel>>? searchUserList,
  }) {
    return HomeChatListState(
      homeChatList: homeChatList ?? this.homeChatList,
      searchUserList: searchUserList ?? this.searchUserList,
    );
  }
}
