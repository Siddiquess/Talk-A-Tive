
class ChatUsers {
  String name;
  String messageText;
  String imageURL;
  String time;
  ChatUsers({
    required this.name,
    required this.messageText,
    required this.imageURL,
    required this.time,
  });
}

class UserChatDetailList  {
  static List<ChatUsers> chatUsers = [
    ChatUsers(
        name: "Jane Russel",
        messageText: "Awesome Setup",
        imageURL: "https://randomuser.me/api/portraits/men/1.jpg",
        time: "Now"),
    ChatUsers(
        name: "Glady's Murphy",
        messageText: "That's Great",
        imageURL: "https://randomuser.me/api/portraits/men/2.jpg",
        time: "Yesterday"),
    ChatUsers(
        name: "Jorge Henry",
        messageText: "Hey where are you?",
        imageURL: "https://randomuser.me/api/portraits/men/3.jpg",
        time: "31 Mar"),
    ChatUsers(
        name: "Philip Fox",
        messageText: "Busy! Call me in 20 mins",
        imageURL: "https://randomuser.me/api/portraits/men/4.jpg",
        time: "28 Mar"),
    ChatUsers(
        name: "Debra Hawkins",
        messageText: "Thankyou, It's awesome",
        imageURL: "https://randomuser.me/api/portraits/men/5.jpg",
        time: "23 Mar"),
    ChatUsers(
        name: "Jacob Pena",
        messageText: "will update you in evening",
        imageURL: "https://randomuser.me/api/portraits/men/6.jpg",
        time: "17 Mar"),
    ChatUsers(
        name: "Andrey Jones",
        messageText: "Can you please share the file?",
        imageURL: "https://randomuser.me/api/portraits/men/7.jpg",
        time: "24 Feb"),
    ChatUsers(
        name: "John Wick",
        messageText: "How are you?",
        imageURL: "https://randomuser.me/api/portraits/men/8.jpg",
        time: "18 Feb"),
  ];
}
