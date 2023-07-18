class ChatUsers {
  String messageText;
  String time;
  ChatUsers({
    required this.messageText,
    required this.time,
  });
}

class UserChatDetailList {
  static List<ChatUsers> chatUsers = [
    ChatUsers(messageText: "Awesome Setup", time: "Now"),
    ChatUsers(messageText: "That's Great", time: "Yesterday"),
    ChatUsers(messageText: "Hey where are you?", time: "31 Mar"),
    ChatUsers(messageText: "Busy! Call me in 20 mins", time: "28 Mar"),
    ChatUsers(messageText: "Thankyou, It's awesome", time: "23 Mar"),
    ChatUsers(messageText: "will update you in evening", time: "17 Mar"),
    ChatUsers(messageText: "Can you please share the file?", time: "24 Feb"),
    ChatUsers(messageText: "How are you?", time: "18 Feb"),
  ];
}
