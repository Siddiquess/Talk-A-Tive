import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bussiness_logic/home_chat_list/home_chat_list_bloc.dart';
import '../../../bussiness_logic/individual_chat/individual_chat_bloc.dart';
import '../../../data_layer/model/home_chat_list_model.dart';
import '../../chat_page.dart';
import '../chat_user_list.dart';
import '../user_list_widget.dart';

class HomeChattedUserListWidget extends StatelessWidget {
  const HomeChattedUserListWidget({
    super.key,
    required this.currentUserId,
    required this.state,
  });

  final String? currentUserId;
  final HomeChatListState state;

  @override
  Widget build(BuildContext context) {
    return state.homeChatList.data!.isEmpty?
    const Center(child: Text("No chat yet"),):
    ListView.builder(
      itemCount: state.homeChatList.data!.length,
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 16),
      itemBuilder: (context, index) {
        final chatUsers = UserChatDetailList.chatUsers;
        User? chattedUser = state.homeChatList.data![index].users!.firstWhere(
          (element) => element.id != currentUserId,
          orElse: () {
            return User();
          },
        );
        return ConversationList(
          name: chattedUser.name!,
          messageText: state.homeChatList.data![index].latestMessage?.content,
          imageUrl: chattedUser.pic!,
          time: chatUsers[index].time,
          isMessageRead: true,
          onTap: () {
            BlocProvider.of<IndividualChatBloc>(context).add(
              OnCreatIndividualChat(
                userId: chattedUser.id!,
              ),
            );
            BlocProvider.of<IndividualChatBloc>(context).add(
              OnGetAllIndividualMessages(
                chatRoomId: state.homeChatList.data![index].id!,
              ),
            );

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ChatPage(
                    imageUrl: chattedUser.pic!,
                    userName: chattedUser.name!,
                    userId: chattedUser.id!,
                    chatRoomId: state.homeChatList.data![index].id!,
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
