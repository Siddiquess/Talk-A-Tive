import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk_a_tive/bussiness_logic/individual_chat/individual_chat_bloc.dart';
import 'package:talk_a_tive/core/app_colors.dart';
import 'package:talk_a_tive/data_layer/data_provider/response/status.dart';
import 'package:talk_a_tive/presentation/components/chat_page_components/chat_bg_image_widget.dart';
import 'package:talk_a_tive/presentation/components/snackbar_widget.dart';
import 'components/chat_page_components/chat_appbar_widget.dart';
import 'components/chat_page_components/chat_content_widget.dart';

class ChatPage extends StatelessWidget {
  ChatPage({
    super.key,
    required this.imageUrl,
    required this.userName,
    required this.userId,
  });
  final String imageUrl;
  final String userName;
  final String userId;

  final TextEditingController _chatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isApiCallTriggered = false;
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<IndividualChatBloc>(context).state.messages.clear();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: SafeArea(
            child: ChatAppbarWidget(
              imageUrl: imageUrl,
              userName: userName,
            ),
          ),
        ),
        body: BlocListener<IndividualChatBloc, IndividualChatState>(
            listener: (context, state) {
              if (state.indChatModel.status == Status.success &&
                  isApiCallTriggered == false) {
                isApiCallTriggered = true;
                BlocProvider.of<IndividualChatBloc>(context).add(
                  OnGetAllIndividualMessages(
                    chatRoomId: state.indChatModel.data!.id!,
                  ),
                );
              }

              if (state.indChatModel.status == Status.error) {
                SnackBarWidget.flushbar(
                  context: context,
                  message: state.indChatModel.message!,
                );
              }
            },
            child: Stack(
              children: [
                const ChatBGImageWidget(),
                ChatContentWidget(userId: userId),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(
                              left: 10,
                              top: 7,
                            ),
                            constraints: const BoxConstraints(
                              minHeight: 46,
                            ),
                            height: 46,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                const SizedBox(width: 15),
                                Expanded(
                                  child: Scrollbar(
                                    child: SizedBox(
                                      height: 120,
                                      width: 240,
                                      child: TextField(
                                        expands: true,
                                        controller: _chatController,
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        decoration: const InputDecoration(
                                          contentPadding:
                                              EdgeInsets.only(top: 5),
                                          hintText: "Write message...",
                                          hintStyle:
                                              TextStyle(color: Colors.black54),
                                          border: InputBorder.none,
                                        ),
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
                          builder: (context, state) {
                            return Container(
                              padding: const EdgeInsets.only(
                                left: 2,
                                right: 5,
                                bottom: 10,
                                top: 10,
                              ),
                              height: 65,
                              child: FloatingActionButton(
                                onPressed: state.indChatModel.status ==
                                        Status.success
                                    ? () {
                                        if (_chatController.text
                                            .trim()
                                            .isNotEmpty) {
                                          BlocProvider.of<IndividualChatBloc>(
                                                  context)
                                              .add(
                                            OnSendChatMessageEvent(
                                              message:
                                                  _chatController.text.trim(),
                                              chatRoomId:
                                                  state.indChatModel.data!.id!,
                                            ),
                                          );
                                          BlocProvider.of<IndividualChatBloc>(
                                                  context)
                                              .add(
                                            OnGetAllIndividualMessages(
                                              chatRoomId:
                                                  state.indChatModel.data!.id!,
                                            ),
                                          );
                                        }

                                        _chatController.clear();
                                      }
                                    : null,
                                backgroundColor: AppColors.primarylite,
                                elevation: 0,
                                child: const Icon(
                                  Icons.send,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
