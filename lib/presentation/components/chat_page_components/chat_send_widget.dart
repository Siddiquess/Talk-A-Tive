import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bussiness_logic/individual_chat/individual_chat_bloc.dart';
import '../../../core/app_colors.dart';
import '../../../data_layer/data_provider/response/status.dart';

class ChatSendingWidget extends StatelessWidget {
  const ChatSendingWidget({
    super.key,
    required TextEditingController chatController,
    required this.scrollController,
  }) : _chatController = chatController;

  final TextEditingController _chatController;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 10, top: 7),
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 15),
                    Expanded(
                      child: Scrollbar(
                        child: TextField(
                          expands: true,
                          controller: _chatController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(top: 3),
                            hintText: "Write message...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                  ],
                ),
              ),
            ),
            BlocBuilder<IndividualChatBloc, IndividualChatState>(
              builder: (context, indChatstate) {
                return Container(
                  padding: const EdgeInsets.only(
                    left: 5,
                    right: 10,
                    bottom: 10,
                    top: 10,
                  ),
                  height: 65,
                  child: GestureDetector(
                    onTap: indChatstate.indChatModel.status == Status.success
                        ? () {
                            String chatMessage = _chatController.text.trim();
                            if (chatMessage.isNotEmpty) {
                              BlocProvider.of<IndividualChatBloc>(context).add(
                                OnSendChatMessageEvent(
                                  message: _chatController.text.trim(),
                                  chatRoomId:
                                      indChatstate.indChatModel.data!.id!,
                                ),
                              );
                            }

                            scrollController.animateTo(
                              scrollController.position.minScrollExtent,
                              curve: Curves.easeOut,
                              duration: const Duration(milliseconds: 300),
                            );

                            _chatController.clear();
                          }
                        : null,
                    child: Container(
                      width: 45,
                      decoration: BoxDecoration(
                        color: AppColors.primarylite,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
