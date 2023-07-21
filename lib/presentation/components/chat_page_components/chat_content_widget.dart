import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk_a_tive/bussiness_logic/individual_chat/individual_chat_bloc.dart';
import 'package:talk_a_tive/core/app_colors.dart';
import 'package:talk_a_tive/core/constant.dart';

class ChatContentWidget extends StatelessWidget {
  const ChatContentWidget(
      {super.key, required this.userId, required this.scrollController});

  final String userId;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    String? currentUserId;

    return BlocBuilder<IndividualChatBloc, IndividualChatState>(
      builder: (context, state) {
        UserID.getUserID().then((userID) => {currentUserId = userID!});
        log("all message length ${state.messages.length}");
        return Expanded(
          child: ListView.builder(
            controller: scrollController,
            itemCount: state.messages.length,
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            physics: const ScrollPhysics(),
            itemBuilder: (context, index) {
              final messageContent = state.messages[index]["content"];
              final messageTime = state.messages[index]["chatTime"];
              bool isCurrentUser = currentUserId == state.messages[index]["id"];

              return Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 2,
                  horizontal: 14,
                ),
                child: Align(
                  alignment:
                      (isCurrentUser ? Alignment.topRight : Alignment.topLeft),
                  child: Padding(
                    padding: isCurrentUser
                        ? const EdgeInsets.only(left: 30)
                        : const EdgeInsets.only(right: 30),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: isCurrentUser
                            ? const Color.fromARGB(198, 85, 171, 200)
                            : Colors.grey.shade200,
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.end,
                        children: [
                          Text(
                            messageContent!,
                            style: const TextStyle(fontSize: 15),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5, top: 6),
                            child: Text(
                              messageTime ?? "",
                              style: TextStyle(
                                fontSize: 10,
                                color: isCurrentUser
                                    ? AppColors.white.withAlpha(100)
                                    : Colors.grey.shade500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
