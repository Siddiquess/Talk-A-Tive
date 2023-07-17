part of 'home_chat_list_bloc.dart';

@immutable
abstract class HomeChatListEvent {}

class GetHomeChatListEvent extends HomeChatListEvent {}

class GetSearchChatList extends HomeChatListEvent {
  final String chatQuery;

  GetSearchChatList({required this.chatQuery});
}