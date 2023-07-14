part of 'user_sign_up_bloc.dart';

@immutable
abstract class UserSignUpEvent {
  getUserDetailBody();
}

class UserSignUp extends UserSignUpEvent {
  final String name;
  final String email;
  final String password;
  final String picture;

  UserSignUp({
    required this.name,
    required this.email,
    required this.password,
    required this.picture,
  });
  @override
  getUserDetailBody() {
    final userData = UserSignupModel(
      name: name,
      email: email,
      password: password,
      pic: picture,
    );

    return userData.toJson();
  }
}
