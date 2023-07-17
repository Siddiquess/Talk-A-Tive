import 'package:shared_preferences/shared_preferences.dart';

import 'global_keys.dart';

class AppUrls {
  static const String baseUrl = "http://192.168.0.215:5000";
  static const String userLogin = "$baseUrl/api/user/login";
  static const String userSignup = "$baseUrl/api/user/";
  static const String homeChatList = "$baseUrl/api/user/";
  static const String searchChatList = "$baseUrl/api/user?search=";
  static const String createIndiChatRoom = "$baseUrl/api/chat/";
  static const String getAllMessages = "$baseUrl/api/message/";

}

class AccessToken {
  static Future<String?> getAccessToken() async {
    final sharedPref = await SharedPreferences.getInstance();
    final accessToken = sharedPref.getString(GlobalKeys.accessToken);
    return accessToken;
  }
}
