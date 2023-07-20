import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:talk_a_tive/bussiness_logic/individual_chat/individual_chat_bloc.dart';
import 'package:talk_a_tive/core/app_colors.dart';
import 'package:talk_a_tive/core/constant.dart';
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
    String? currentUserId;
    return BlocBuilder<IndividualChatBloc, IndividualChatState>(
      builder: (context, state) {
        UserID.getUserID().then((value) => {currentUserId = value!});
        return SingleChildScrollView(
          child: Column(
            children: [
              state.getAllindChatModel.status == Status.initial
                  ? AppSizes.height10
                  : state.getAllindChatModel.status == Status.loading
                      ? AppSizes.height10
                      : state.getAllindChatModel.status == Status.success
                          ? ListView.builder(
                              itemCount: state.getAllindChatModel.data!
                                  .map((e) => e.content)
                                  .length,
                              shrinkWrap: true,
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              physics: const ScrollPhysics(),
                              itemBuilder: (context, index) {
                                final message =
                                    state.getAllindChatModel.data![index];
                                final messageTime = message.createdAt;
                                bool isCurrentUser = currentUserId ==
                                    state.getAllindChatModel.data?[index].sender
                                        ?.id;
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 2,
                                    horizontal: 14,
                                  ),
                                  child: Align(
                                    alignment: (isCurrentUser
                                        ? Alignment.topRight
                                        : Alignment.topLeft),
                                    child: Padding(
                                      padding: isCurrentUser
                                          ? const EdgeInsets.only(left: 30)
                                          : const EdgeInsets.only(right: 30),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: isCurrentUser
                                              ? const Color.fromARGB(
                                                  198, 85, 171, 200)
                                              : Colors.grey.shade200,
                                        ),
                                        padding: const EdgeInsets.all(10),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Flexible(
                                              flex: 5,
                                              child: Text(
                                                message.content!,
                                                style: const TextStyle(
                                                    fontSize: 15),
                                              ),
                                            ),
                                            Flexible(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5, top: 6),
                                                child: Text(
                                                  DateFormat('h:mm a')
                                                      .format(messageTime!),
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: isCurrentUser
                                                        ? AppColors.white
                                                            .withAlpha(100)
                                                        : Colors.grey.shade500,
                                                  ),
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
                            )
                          : AppSizes.height10,
              AppSizes.height50
            ],
          ),
        );
      },
    );
  }
}
