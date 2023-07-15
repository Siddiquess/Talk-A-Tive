import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:talk_a_tive/core/constant.dart';
import 'package:talk_a_tive/data_layer/data_provider/local/pick_user_profile.dart';
import 'package:talk_a_tive/data_layer/data_provider/response/api_response.dart';
import 'package:talk_a_tive/data_layer/model/user_sign_up_model.dart';
import 'package:talk_a_tive/data_layer/repository/user_signup_repository.dart';
part 'user_sign_up_event.dart';
part 'user_sign_up_state.dart';

class UserSignUpBloc extends Bloc<UserSignUpEvent, UserSignUpState> {
  final userSignupRepo = UserSignupRepository();
  final pickprofile = PickUserProfile();
  UserSignUpBloc() : super(UserSignUpState()) {
    on<UserSignUp>(
      (event, emit) async {
        emit(
          UserSignUpState(
            userSignupData: ApiResponse.loading(),
          ),
        );

        final response = await userSignupRepo.getUserSignUp(
          url: AppUrls.userSignup,
          data: event.getUserDetailBody(),
        );

        response.fold(
          (failure) => {
            emit(
              UserSignUpState(
                userSignupData: ApiResponse.error(
                  failure.toString(),
                ),
              ),
            ),
          },
          (success) => {
            emit(
              UserSignUpState(
                userSignupData: ApiResponse.completed(success),
              ),
            ),
          },
        );
      },
    );

    on<PickUserProfileEvent>((event, emit) async{
      emit(UserSignUpState(userProfile: await event.getUserProfile()));
    });
  }
}
