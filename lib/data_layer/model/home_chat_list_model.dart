import 'dart:convert';

List<HomeChatListModel> homeChatListModelFromJson(
        List<dynamic> str) =>
    List<HomeChatListModel>.from(str.map((x) => HomeChatListModel.fromJson(x)));

String homeChatListModelToJson(List<HomeChatListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HomeChatListModel {
  String? pic;
  bool? isAdmin;
  String? sId;
  String? name;
  String? email;
  String? password;
  int? iV;

  HomeChatListModel(
      {this.pic,
      this.isAdmin,
      this.sId,
      this.name,
      this.email,
      this.password,
      this.iV});

  HomeChatListModel.fromJson(Map<String, dynamic> json) {
    pic = json['pic'];
    isAdmin = json['isAdmin'];
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data ={};
    data['pic'] = pic;
    data['isAdmin'] = isAdmin;
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['__v'] = iV;
    return data;
  }
}
