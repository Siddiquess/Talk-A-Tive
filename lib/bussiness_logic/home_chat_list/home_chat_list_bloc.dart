import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:talk_a_tive/core/constant.dart';
import 'package:talk_a_tive/data_layer/data_provider/response/api_response.dart';
import 'package:talk_a_tive/data_layer/repository/home_chat_list_repository.dart';

import '../../data_layer/model/home_chat_list_model.dart';

part 'home_chat_list_event.dart';
part 'home_chat_list_state.dart';

class HomeChatListBloc extends Bloc<HomeChatListEvent, HomeChatListState> {
  final homechatRepo = HomeChatListRepository();
  HomeChatListBloc()
      : super(HomeChatListState(homeChatList: ApiResponse.initial())) {
    on<GetHomeChatListEvent>(
      (event, emit) async {
        if (state.homeChatList.data != null) {
          if (state.homeChatList.data!.isNotEmpty) {
            emit(
              HomeChatListState(
                homeChatList: state.homeChatList,
              ),
            );
          }
        }

        emit(
          HomeChatListState(
            homeChatList: ApiResponse.loading(),
          ),
        );

        final response =
            await homechatRepo.getHomeChatList(url: AppUrls.homeChatList);

        response.fold(
          (failure) => {
            emit(
              HomeChatListState(
                homeChatList: ApiResponse.error(
                  failure.toString(),
                ),
              ),
            ),
          },
          (success) => {
            emit(
              HomeChatListState(
                homeChatList: ApiResponse.completed(success),
              ),
            ),
          },
        );
      },
    );

    on<GetSearchChatList>(
      (event, emit) async {
        emit(
          HomeChatListState(
            homeChatList: ApiResponse.loading(),
          ),
        );

        final response = await homechatRepo.getHomeChatList(
            url: AppUrls.searchChatList + event.chatQuery);

        response.fold(
          (failure) => {
            emit(
              HomeChatListState(
                homeChatList: ApiResponse.error(failure.toString()),
              ),
            ),
          },
          (success) => {
            emit(
              HomeChatListState(
                homeChatList: ApiResponse.completed(success),
              ),
            ),
          },
        );
      },
    );
  }
}
