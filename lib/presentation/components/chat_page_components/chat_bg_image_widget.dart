import 'package:flutter/material.dart';

class ChatBGImageWidget extends StatelessWidget {
  const ChatBGImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/chat_bg_2.png"),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
          Container(
            color: Colors.black.withAlpha(5),
          ),
        ],
      ),
    );
  }
}