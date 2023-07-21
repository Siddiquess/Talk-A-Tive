import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk_a_tive/bussiness_logic/home_chat_list/home_chat_list_bloc.dart';
import 'package:talk_a_tive/data_layer/data_provider/response/api_response.dart';
import 'package:talk_a_tive/data_layer/data_provider/response/status.dart';

import '../../../core/debouncer.dart';

class HomePageSearchFieldWidget extends StatelessWidget {
  const HomePageSearchFieldWidget({
    super.key,
    required Debouncer debouncer,
    required this.searchUserController,
  }) : _debouncer = debouncer;

  final Debouncer _debouncer;
  final TextEditingController searchUserController;

  @override
  Widget build(BuildContext context) {
    HomeChatListBloc homeChatListBloc =
        BlocProvider.of<HomeChatListBloc>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
      child: BlocBuilder<HomeChatListBloc, HomeChatListState>(
        builder: (context, state) {
          return TextField(
            controller: searchUserController,
            onChanged: (value) {
              _debouncer.run(
                () {
                  homeChatListBloc.add(GetSearchChatList(chatQuery: value));
                  if (value.isEmpty) {
                    state.searchUserList.status = Status.initial;
                    state.homeChatList = ApiResponse.initial();
                    homeChatListBloc.add(GetHomeChatListEvent());
                  }
                },
              );
            },
            decoration: InputDecoration(
              hintText: "Search...",
              hintStyle: TextStyle(color: Colors.grey.shade600),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey.shade600,
                size: 25,
              ),
              filled: true,
              fillColor: Colors.grey.shade300,
              contentPadding: const EdgeInsets.all(0),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.grey.shade300)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.grey.shade300)),
            ),
          );
        },
      ),
    );
  }
}
