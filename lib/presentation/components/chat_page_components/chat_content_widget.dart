import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk_a_tive/bussiness_logic/individual_chat/individual_chat_bloc.dart';
import 'package:talk_a_tive/data_layer/data_provider/response/status.dart';
import '../../../core/sizes.dart';

class ChatContentWidget extends StatelessWidget {
  const ChatContentWidget({
    super.key,
    required this.userId,
  });

  final String userId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IndividualChatBloc, IndividualChatState>(
      builder: (context, state) {
        log(state.messages.length.toString());
        return SingleChildScrollView(
          child: Column(
            children: [
              state.getAllindChatModel.status == Status.success
                  ? ListView.builder(
                      itemCount: state.messages.length,
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
                            alignment: (state.getAllindChatModel.data?[index]
                                        .sender?.id ==
                                    userId
                                ? Alignment.topLeft
                                : Alignment.topRight),
                            child: Padding(
                              padding: state.getAllindChatModel.data?[index]
                                          .sender?.id ==
                                      userId
                                  ? const EdgeInsets.only(right: 30)
                                  : const EdgeInsets.only(left: 30),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: (state.getAllindChatModel.data?[index]
                                              .sender?.id ==
                                          userId
                                      ? Colors.grey.shade200
                                      : const Color.fromARGB(
                                          198, 85, 171, 200)),
                                ),
                                padding: const EdgeInsets.all(12),
                                child: Text(
                                  state.messages[index],
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : AppSizes.height20,
              AppSizes.height50
            ],
          ),
        );
      },
    );
  }
}
