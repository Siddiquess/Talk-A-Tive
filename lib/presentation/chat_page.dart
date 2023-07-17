import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk_a_tive/bussiness_logic/individual_chat/individual_chat_bloc.dart';
import 'package:talk_a_tive/core/app_colors.dart';
import 'package:talk_a_tive/data_layer/data_provider/response/status.dart';
import 'package:talk_a_tive/presentation/components/chat_page_components/chat_bg_image_widget.dart';
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
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.primary,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: ChatAppbarWidget(
            imageUrl: imageUrl,
            userName: userName,
          ),
        ),
      ),
      body: BlocConsumer<IndividualChatBloc, IndividualChatState>(
        listener: (context, state) {
          if (state.indChatModel.status == Status.success) {
            BlocProvider.of<IndividualChatBloc>(context).add(
              OnGetAllIndividualMessages(
                chatRoomId: state.indChatModel.data!.id!,
              ),
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              const ChatBGImageWidget(),
               ChatContentWidget(userId: userId),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding:
                        const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: AppColors.primarylite,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
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
                                  contentPadding: EdgeInsets.only(top: 5),
                                  hintText: "Write message...",
                                  hintStyle: TextStyle(color: Colors.black54),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        FloatingActionButton(
                          onPressed: () {
                            if (_chatController.text.trim().isNotEmpty) {
                              BlocProvider.of<IndividualChatBloc>(context).add(
                                OnSendChatMessageEvent(
                                  message: _chatController.text.trim(),
                                ),
                              );
                            }

                            _chatController.clear();
                          },
                          backgroundColor: AppColors.primarylite,
                          elevation: 0,
                          child: const Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
