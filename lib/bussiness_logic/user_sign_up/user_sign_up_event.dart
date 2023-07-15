part of 'user_sign_up_bloc.dart';

@immutable
abstract class UserSignUpEvent {}

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

class PickUserProfileEvent extends UserSignUpEvent {
  final BuildContext context;
  final bool isCamera;
  PickUserProfileEvent({
    required this.context,
    required this.isCamera,
  });

  final PickUserProfile userProfile = PickUserProfile();
  
 Future<String?> getUserProfile() async{
   return await userProfile.imagePicker(context, isCamera);
  }
}
