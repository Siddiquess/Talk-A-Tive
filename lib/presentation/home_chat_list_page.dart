import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk_a_tive/bussiness_logic/home_chat_list/home_chat_list_bloc.dart';
import 'package:talk_a_tive/bussiness_logic/individual_chat/individual_chat_bloc.dart';
import 'package:talk_a_tive/core/app_colors.dart';
import 'package:talk_a_tive/core/sizes.dart';
import 'package:talk_a_tive/data_layer/data_provider/response/status.dart';
import 'package:talk_a_tive/presentation/chat_page.dart';
import '../core/debouncer.dart';
import 'components/chat_user_list.dart';
import 'components/home_page_components/home_page_appbar_widget.dart';
import 'components/home_page_components/home_page_search_field.dart';
import 'components/user_list_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final _debouncer = Debouncer(milliseconds: 1000);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.primary,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<HomeChatListBloc>(context).add(GetHomeChatListEvent());
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
                  return state.homeChatList.status == Status.loading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : state.homeChatList.status == Status.success
                          ? ListView.builder(
                              itemCount: state.homeChatList.data!.length,
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(top: 16),
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final chatUsers = UserChatDetailList.chatUsers;
                                final userChatList = state.homeChatList.data!;
                                return ConversationList(
                                  name: userChatList[index].name!,
                                  messageText: chatUsers[index].messageText,
                                  imageUrl: userChatList[index].pic!,
                                  time: chatUsers[index].time,
                                  isMessageRead:
                                      (index == 0 || index == 3) ? true : false,
                                  onTap: () {
                                    BlocProvider.of<IndividualChatBloc>(context)
                                        .add(
                                      OnCreatIndividualChat(
                                        userId: userChatList[index].sId!,
                                      ),
                                    );

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return ChatPage(
                                            imageUrl: userChatList[index].pic!,
                                            userName: userChatList[index].name!,
                                            userId: userChatList[index].sId!,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                            )
                          : state.homeChatList.status == Status.error
                              ? Center(
                                  child: Text(state.homeChatList.message!),
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
