part of 'individual_chat_bloc.dart';

@immutable
abstract class IndividualChatEvent {}

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

class OnSendChatMessageEvent extends IndividualChatEvent {
  final String message;
  final String chatRoomId;
  OnSendChatMessageEvent({
    required this.message,
    required this.chatRoomId,
  }) {
    log(chatRoomId);
  }

  Map<String, dynamic> sendMessageBody() {
    final sendMsgBody = SendIndividualMessageModel(
      chatId: chatRoomId,
      content: message,
    );

    return sendMsgBody.toJson();
  }
}

class OnSocketRecivedMessage extends IndividualChatEvent {
  final dynamic response;
  OnSocketRecivedMessage({required this.response});
}

class OnChatRoomFunctions extends IndividualChatEvent {
  final String isConnectedUser;
  final bool isConnected;
  final bool isTyping;
  OnChatRoomFunctions({
    this.isConnectedUser ="",
    this.isConnected = false,
    this.isTyping = false,
  });
}

class OnEnterInidvidualChatRoom extends IndividualChatEvent {}

class OnLeaveIndividualChatRoom extends IndividualChatEvent {}
