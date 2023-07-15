import 'package:flutter/material.dart';

import '../../../core/sizes.dart';
import 'chat_messages.dart';

class ChatContentWidget extends StatelessWidget {
  const ChatContentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            itemCount: UserChatMessage.messages.length,
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            physics: const ScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 9,
                  horizontal: 14,
                ),
                child: Align(
                  alignment:
                      (UserChatMessage.messages[index].messageType ==
                              "receiver"
                          ? Alignment.topLeft
                          : Alignment.topRight),
                  child: Padding(
                    padding:
                        UserChatMessage.messages[index].messageType ==
                                "receiver"
                            ? const EdgeInsets.only(right: 30)
                            : const EdgeInsets.only(left: 30),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: (UserChatMessage
                                    .messages[index].messageType ==
                                "receiver"
                            ? Colors.grey.shade200
                            : const Color.fromARGB(198, 85, 171, 200)),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        UserChatMessage.messages[index].messageContent,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          AppSizes.height50
        ],
      ),
    );
  }
}