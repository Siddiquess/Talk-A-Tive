part of 'user_login_bloc.dart';

@immutable
abstract class UserLoginEvent {}

class UserLogin extends UserLoginEvent {
  final String email;
  final String passoword;
  UserLogin({
    required this.email,
    required this.passoword,
  });

  Map<String, dynamic> userLoginBody() {
    final loginBody = UserLoginModel(
      email: email,
      password: passoword,
    );

    return loginBody.toJson();
  }
}
