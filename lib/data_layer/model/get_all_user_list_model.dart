import 'dart:convert';

List<GetAllUserListModel> getAllUserListModelFromJson(List<dynamic> str) =>
    List<GetAllUserListModel>.from(
        str.map((x) => GetAllUserListModel.fromJson(x)));

String getAllUserListModelToJson(List<GetAllUserListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllUserListModel {
  String? pic;
  bool? isAdmin;
  String? id;
  String? name;
  String? email;
  String? password;
  int? v;

  GetAllUserListModel({
    this.pic,
    this.isAdmin,
    this.id,
    this.name,
    this.email,
    this.password,
    this.v,
  });

  factory GetAllUserListModel.fromJson(Map<String, dynamic> json) =>
      GetAllUserListModel(
        pic: json["pic"],
        isAdmin: json["isAdmin"],
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "pic": pic,
        "isAdmin": isAdmin,
        "_id": id,
        "name": name,
        "email": email,
        "password": password,
        "__v": v,
      };
}
