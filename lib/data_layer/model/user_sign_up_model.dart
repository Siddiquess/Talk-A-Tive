import 'dart:convert';

UserSignupModel userSignupModelFromJson(Map<String,dynamic> str) => UserSignupModel.fromJson(str);

String userSignupModelToJson(UserSignupModel data) => json.encode(data.toJson());

class UserSignupModel {
    String? id;
    String? name;
    String? email;
    String? password;
    bool? isAdmin;
    String? pic;
    String? token;

    UserSignupModel({
        this.id,
        this.name,
        this.email,
        this.password,
        this.isAdmin,
        this.pic,
        this.token,
    });

    factory UserSignupModel.fromJson(Map<String, dynamic> json) => UserSignupModel(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        isAdmin: json["isAdmin"],
        pic: json["pic"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "pic": pic,
    };
}
