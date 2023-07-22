import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../bussiness_logic/home_chat_list/home_chat_list_bloc.dart';
import '../../../bussiness_logic/individual_chat/individual_chat_bloc.dart';
import '../../../data_layer/model/home_chat_list_model.dart';
import '../../chat_page.dart';
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
    IndividualChatBloc individualchatBloc =
        BlocProvider.of<IndividualChatBloc>(context);

    return state.homeChatList.data!.isEmpty
        ? const Center(
            child: Text("No chat yet"),
          )
        : ListView.builder(
            itemCount: state.homeChatList.data!.length,
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 16),
            itemBuilder: (context, index) {
              HomeChatListModel homeChatUsers = state.homeChatList.data![index];
              User? chattedUser = homeChatUsers.users!.firstWhere(
                (element) => element.id != currentUserId,
                orElse: () {
                  return User();
                },
              );
              return ConversationList(
                name: chattedUser.name!,
                userId: chattedUser.id!,
                messageText: homeChatUsers.latestMessage?.content,
                imageUrl: chattedUser.pic!,
                time: formatTimestamp(homeChatUsers.latestMessage!.createdAt!),
                onTap: () {
                  individualchatBloc.add(
                    OnCreatIndividualChat(
                      userId: chattedUser.id!,
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
                        );
                      },
                    ),
                  );
                },
              );
            },
          );
  }

  String formatTimestamp(DateTime dateTime) {
    DateTime now = DateTime.now();

    if (dateTime == DateTime.now()) {
      return "Now";
    }

    if (dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day) {
      return "today";
    }

    DateTime yesterday = now.subtract(const Duration(days: 1));
    if (dateTime.year == yesterday.year &&
        dateTime.month == yesterday.month &&
        dateTime.day == yesterday.day) {
      return "Yesterday";
    }

    String formattedDate = DateFormat('dd MMM').format(dateTime);

    return formattedDate;
  }
}
