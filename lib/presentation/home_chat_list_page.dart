import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk_a_tive/bussiness_logic/home_chat_list/home_chat_list_bloc.dart';
import 'package:talk_a_tive/core/constant.dart';
import 'package:talk_a_tive/core/sizes.dart';
import 'package:talk_a_tive/data_layer/data_provider/response/status.dart';
import 'package:talk_a_tive/presentation/components/home_page_components/search_user_list_widget.dart';
import '../core/debouncer.dart';
import 'components/home_page_components/home_chatted_user_widget.dart';
import 'components/home_page_components/home_page_appbar_widget.dart';
import 'components/home_page_components/home_page_search_field.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final _debouncer = Debouncer(milliseconds: 1000);

  @override
  Widget build(BuildContext context) {
    String? currentUserId;
     BlocProvider.of<HomeChatListBloc>(context).add(OnConnectHomeSocketIO());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      UserID.getUserID().then((value) {
        currentUserId = value;
        BlocProvider.of<HomeChatListBloc>(context).add(GetHomeChatListEvent());
      });
    });

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          flexibleSpace: const HomePageAppbarWidget(),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomePageSearchFieldWidget(debouncer: _debouncer),
              BlocBuilder<HomeChatListBloc, HomeChatListState>(
                builder: (context, state) {
                  return state.homeChatList.status == Status.loading ||
                          state.searchUserList.status == Status.loading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : state.homeChatList.status == Status.success &&
                              state.searchUserList.status != Status.success
                          ? HomeChattedUserListWidget(
                              state: state,
                              currentUserId: currentUserId,
                            )
                          : state.homeChatList.status == Status.success &&
                                  state.searchUserList.status == Status.success
                              ? SearchUserListWidget(
                                  currentUserId: currentUserId,
                                  state: state,
                                )
                              : state.homeChatList.status == Status.error
                                  ? Center(
                                      child: Text(state.homeChatList.message ??
                                          "Something went wrong"),
                                    )
                                  : AppSizes.height10;
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
