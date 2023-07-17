import 'dart:developer';

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
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Talkative",
                    style: TextStyle(
                      fontSize: 27,
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.pink[50],
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.pink,
                          size: 20,
                        ),
                        SizedBox(width: 2),
                        Text(
                          "Add New",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        body: BlocBuilder<HomeChatListBloc, HomeChatListState>(
          builder: (context1, state) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: TextField(
                      onChanged: (value) {
                        log("search Working-----------------");
                        _debouncer.run(
                          () {
                            BlocProvider.of<HomeChatListBloc>(context)
                                .add(GetSearchChatList(chatQuery: value));
                          },
                        );
                      },
                      decoration: InputDecoration(
                        hintText: "Search...",
                        hintStyle: TextStyle(color: Colors.grey.shade600),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey.shade600,
                          size: 25,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        contentPadding: const EdgeInsets.all(10),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                BorderSide(color: Colors.grey.shade300)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                BorderSide(color: Colors.grey.shade300)),
                      ),
                    ),
                  ),
                  state.homeChatList.status == Status.loading
                      ? const Center(child: CircularProgressIndicator())
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
                                        builder: (context) => ChatPage(
                                          imageUrl: userChatList[index].pic!,
                                          userName: userChatList[index].name!,
                                          userId: userChatList[index].sId!,
                                        ),
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
                              : AppSizes.height10
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
