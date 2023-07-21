import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk_a_tive/bussiness_logic/individual_chat/individual_chat_bloc.dart';
import 'package:talk_a_tive/data_layer/data_provider/response/status.dart';
import 'package:talk_a_tive/presentation/components/chat_page_components/chat_bg_image_widget.dart';
import 'package:talk_a_tive/presentation/components/snackbar_widget.dart';
import '../bussiness_logic/home_chat_list/home_chat_list_bloc.dart';
import 'components/chat_page_components/chat_appbar_widget.dart';
import 'components/chat_page_components/chat_content_widget.dart';
import 'components/chat_page_components/chat_send_widget.dart';

class ChatPage extends StatelessWidget {
  ChatPage(
      {super.key,
      required this.imageUrl,
      required this.userName,
      required this.userId,
      this.chatRoomId});
  final String imageUrl;
  final String userName;
  final String userId;
  final String? chatRoomId;

  final TextEditingController _chatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    final homeChatBloc = BlocProvider.of<HomeChatListBloc>(context);
    final individualChatBloc = BlocProvider.of<IndividualChatBloc>(context);
    individualChatBloc.add(OnConnectSocketIO());
    return WillPopScope(
      onWillPop: () async {
        individualChatBloc.state.messages.clear();
        homeChatBloc.add(GetHomeChatListEvent());
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
              Column(
                children: [
                  ChatContentWidget(
                    userId: userId,
                    scrollController: scrollController,
                  ),
                  ChatSendingWidget(
                    chatController: _chatController,
                    scrollController: scrollController,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
