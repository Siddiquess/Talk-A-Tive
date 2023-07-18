import 'dart:convert';

SendIndividualMessageModel sendIndividualMessageModelFromJson(Map<String, dynamic> str) =>
    SendIndividualMessageModel.fromJson(str);

String sendIndividualMessageModelToJson(SendIndividualMessageModel data) =>
    json.encode(data.toJson());

class SendIndividualMessageModel {
  List<dynamic>? readBy;
  String? chatId;
  String? id;
  Sender? sender;
  String? content;
  Chat? chat;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  SendIndividualMessageModel({
    this.readBy,
    this.chatId,
    this.id,
    this.sender,
    this.content,
    this.chat,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory SendIndividualMessageModel.fromJson(Map<String, dynamic> json) =>
      SendIndividualMessageModel(
        readBy: json["readBy"] == null
            ? []
            : List<dynamic>.from(json["readBy"]!.map((x) => x)),
        chatId: json["chatId"],
        id: json["_id"],
        sender: json["sender"] == null ? null : Sender.fromJson(json["sender"]),
        content: json["content"],
        chat: json["chat"] == null ? null : Chat.fromJson(json["chat"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "chatId": chatId,
        "content": content,
      };
}

class Chat {
  bool? isGroupChat;
  List<Sender>? users;
  String? id;
  String? chatName;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? latestMessage;

  Chat({
    this.isGroupChat,
    this.users,
    this.id,
    this.chatName,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.latestMessage,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        isGroupChat: json["isGroupChat"],
        users: json["users"] == null
            ? []
            : List<Sender>.from(json["users"]!.map((x) => Sender.fromJson(x))),
        id: json["_id"],
        chatName: json["chatName"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        latestMessage: json["latestMessage"],
      );

  Map<String, dynamic> toJson() => {
        "isGroupChat": isGroupChat,
        "users": users == null
            ? []
            : List<dynamic>.from(users!.map((x) => x.toJson())),
        "_id": id,
        "chatName": chatName,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "latestMessage": latestMessage,
      };
}

class Sender {
  String? pic;
  String? id;
  String? name;
  String? email;

  Sender({
    this.pic,
    this.id,
    this.name,
    this.email,
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        pic: json["pic"],
        id: json["_id"],
        name: json["name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "pic": pic,
        "_id": id,
        "name": name,
        "email": email,
      };
}
