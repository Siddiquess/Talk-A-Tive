import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bussiness_logic/home_chat_list/home_chat_list_bloc.dart';
import '../../../bussiness_logic/individual_chat/individual_chat_bloc.dart';
import '../../chat_page.dart';
import '../user_list_widget.dart';

class SearchUserListWidget extends StatelessWidget {
  const SearchUserListWidget({
    super.key,
    required this.currentUserId,
    required this.state,
    required this.searchUserController,
  });

  final String? currentUserId;
  final HomeChatListState state;
  final TextEditingController searchUserController;

  @override
  Widget build(BuildContext context) {
    IndividualChatBloc individualchatBloc =
        BlocProvider.of<IndividualChatBloc>(context);
    return ListView.builder(
      itemCount: state.searchUserList.data!.length,
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 16),
      itemBuilder: (context, index) {
        final searchedUser = state.searchUserList.data![index];

        return ConversationList(
          name: searchedUser.name!,
          userId: searchedUser.id!,
          imageUrl: searchedUser.pic!,
          onTap: () {
            individualchatBloc.add(
              OnCreatIndividualChat(
                userId: searchedUser.id!,
              ),
            );

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ChatPage(
                    imageUrl: searchedUser.pic!,
                    userName: searchedUser.name!,
                    userId: searchedUser.id!,
                  );
                },
              ),
            );
            searchUserController.clear();
          },
        );
      },
    );
  }
}
