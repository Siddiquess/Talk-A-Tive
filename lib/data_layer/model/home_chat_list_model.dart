import 'dart:convert';

List<HomeChatListModel> homeChatListModelFromJson(
        List<dynamic> str) =>
    List<HomeChatListModel>.from(str.map((x) => HomeChatListModel.fromJson(x)));

String homeChatListModelToJson(List<HomeChatListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class HomeChatListModel {
    bool? isGroupChat;
    List<User>? users;
    String? id;
    String? chatName;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    LatestMessage? latestMessage;

    HomeChatListModel({
        this.isGroupChat,
        this.users,
        this.id,
        this.chatName,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.latestMessage,
    });

    factory HomeChatListModel.fromJson(Map<String, dynamic> json) => HomeChatListModel(
        isGroupChat: json["isGroupChat"],
        users: json["users"] == null ? [] : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
        id: json["_id"],
        chatName: json["chatName"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        latestMessage: json["latestMessage"] == null ? null : LatestMessage.fromJson(json["latestMessage"]),
    );

    Map<String, dynamic> toJson() => {
        "isGroupChat": isGroupChat,
        "users": users == null ? [] : List<dynamic>.from(users!.map((x) => x.toJson())),
        "_id": id,
        "chatName": chatName,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "latestMessage": latestMessage?.toJson(),
    };
}

class LatestMessage {
    List<dynamic>? readBy;
    DateTime? recievedTime;
    String? id;
    Sender? sender;
    String? content;
    String? chat;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    LatestMessage({
        this.readBy,
        this.recievedTime,
        this.id,
        this.sender,
        this.content,
        this.chat,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory LatestMessage.fromJson(Map<String, dynamic> json) => LatestMessage(
        readBy: json["readBy"] == null ? [] : List<dynamic>.from(json["readBy"]!.map((x) => x)),
        recievedTime: json["recievedTime"] == null ? null : DateTime.parse(json["recievedTime"]),
        id: json["_id"],
        sender: json["sender"] == null ? null : Sender.fromJson(json["sender"]),
        content: json["content"],
        chat: json["chat"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "readBy": readBy == null ? [] : List<dynamic>.from(readBy!.map((x) => x)),
        "recievedTime": recievedTime?.toIso8601String(),
        "_id": id,
        "sender": sender?.toJson(),
        "content": content,
        "chat": chat,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
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

class User {
    String? pic;
    bool? isAdmin;
    String? id;
    String? name;
    String? email;
    int? v;

    User({
        this.pic,
        this.isAdmin,
        this.id,
        this.name,
        this.email,
        this.v,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        pic: json["pic"],
        isAdmin: json["isAdmin"],
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "pic": pic,
        "isAdmin": isAdmin,
        "_id": id,
        "name": name,
        "email": email,
        "__v": v,
    };
}

