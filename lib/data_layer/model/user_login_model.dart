
import 'dart:convert';

UserLoginModel userLoginModelFromJson(Map<String,dynamic> str) =>
    UserLoginModel.fromJson(str);

String userLoginModelToJson(UserLoginModel data) => json.encode(data.toJson());

class UserLoginModel {
  String? id;
  String? name;
  String? password;
  String? email;
  bool? isAdmin;
  String? pic;
  String? token;

  UserLoginModel({
    this.id,
    this.name,
    this.password,
    this.email,
    this.isAdmin,
    this.pic,
    this.token,
  });

  factory UserLoginModel.fromJson(Map<String, dynamic> json) => UserLoginModel(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        isAdmin: json["isAdmin"],
        pic: json["pic"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
