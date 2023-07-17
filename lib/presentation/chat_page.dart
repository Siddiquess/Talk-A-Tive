import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:talk_a_tive/core/app_colors.dart';
import 'package:talk_a_tive/presentation/components/chat_page_components/chat_bg_image_widget.dart';
import 'components/chat_page_components/chat_appbar_widget.dart';
import 'components/chat_page_components/chat_content_widget.dart';

class ChatPage extends StatelessWidget {
   ChatPage({
    super.key,
    required this.imageUrl,
    required this.userName,
  });
  final String imageUrl;
  final String userName;

  final TextEditingController _chatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.primary,
      ),
    );
    log(imageUrl);
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
      body: Stack(
        children: [
          const ChatBGImageWidget(),
          const ChatContentWidget(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                height: 55,
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
                      child: TextField(
                        controller:_chatController ,
                        decoration: const InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    FloatingActionButton(
                      onPressed: () {},
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
      ),
    );
  }
}






