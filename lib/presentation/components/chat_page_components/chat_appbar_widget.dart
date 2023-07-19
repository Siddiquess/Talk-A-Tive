import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk_a_tive/bussiness_logic/individual_chat/individual_chat_bloc.dart';
import 'package:talk_a_tive/core/app_colors.dart';

class ChatAppbarWidget extends StatelessWidget {
  const ChatAppbarWidget({
    super.key,
    required this.imageUrl,
    required this.userName,
  });

  final String imageUrl;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 16),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              BlocProvider.of<IndividualChatBloc>(context)
                  .state
                  .getAllindChatModel
                  .data!
                  .clear();

              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.white,
            ),
          ),
          const SizedBox(width: 2),
          CircleAvatar(
            backgroundColor: Colors.grey.shade200,
            backgroundImage: NetworkImage(imageUrl),
            maxRadius: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  userName,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white),
                ),
                const SizedBox(height: 6),
                Text(
                  "Online",
                  style: TextStyle(
                    color: Colors.grey.shade200,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.settings,
            color: Colors.black54,
          ),
        ],
      ),
    );
  }
}
