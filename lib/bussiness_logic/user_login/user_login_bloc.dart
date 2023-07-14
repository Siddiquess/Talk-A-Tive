// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:talk_a_tive/core/constant.dart';
import 'package:talk_a_tive/data_layer/data_provider/response/api_response.dart';
import 'package:talk_a_tive/data_layer/model/user_login_model.dart';
import '../../data_layer/repository/user_login_repository.dart';
part 'user_login_event.dart';
part 'user_login_state.dart';

class UserLoginBloc extends Bloc<UserLoginEvent, UserLoginState> {
  final userLoginRepo = UserLoginRepository();
  UserLoginBloc() : super(const UserLoginState()) {
    on<UserLogin>(
      (event, emit) async {
        emit(
          UserLoginState(
            userLoginData: ApiResponse.loading(),
          ),
        );

        final response = await userLoginRepo.getUserLogin(
          url: AppUrls.userLogin,
          body: event.userLoginBody(),
        );

        emit(
          response.fold(
            (failure) => UserLoginState(
              userLoginData: ApiResponse.error(
                failure.toString(),
              ),
            ),
            (success) => UserLoginState(
              userLoginData: ApiResponse.completed(success),
            ),
          ),
        );
      },
    );
  }
}
