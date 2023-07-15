part of 'user_sign_up_bloc.dart';

class UserSignUpState {
  ApiResponse<UserSignupModel>? userSignupData;
  String? userProfile;

  UserSignUpState({
    this.userSignupData,
    this.userProfile,
  });
}
