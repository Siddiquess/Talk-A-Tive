part of 'individual_chat_bloc.dart';

@immutable
abstract class IndividualChatEvent {}

class OnSendChatMessageEvent extends IndividualChatEvent {
  final String message;
  OnSendChatMessageEvent({required this.message});
}

class OnCreatIndividualChat extends IndividualChatEvent {
  final String userId;
  OnCreatIndividualChat({required this.userId});

  Map<String, dynamic> roomChatBody() {
    final roomChatbody = IndividualChatModel(userId: userId);
    return roomChatbody.toJson();
  }
}

class OnGetAllIndividualMessages extends IndividualChatEvent {
  final String chatRoomId;

  OnGetAllIndividualMessages({required this.chatRoomId}) {
    log(chatRoomId);
  }
}
