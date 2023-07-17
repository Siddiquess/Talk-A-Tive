import 'dart:convert';

IndividualChatModel individualChatModelFromJson(Map<String,dynamic> str) =>
    IndividualChatModel.fromJson(str);

String individualChatModelToJson(IndividualChatModel data) =>
    json.encode(data.toJson());

class IndividualChatModel {
  String? userId;
  bool? isGroupChat;
  List<User>? users;
  String? id;
  String? chatName;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  IndividualChatModel({
    this.userId,
    this.isGroupChat,
    this.users,
    this.id,
    this.chatName,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory IndividualChatModel.fromJson(Map<String, dynamic> json) =>
      IndividualChatModel(
        userId: json["userId"],
        isGroupChat: json["isGroupChat"],
        users: json["users"] == null
            ? []
            : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
        id: json["_id"],
        chatName: json["chatName"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
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
