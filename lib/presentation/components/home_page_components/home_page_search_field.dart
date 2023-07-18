import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk_a_tive/bussiness_logic/home_chat_list/home_chat_list_bloc.dart';

import '../../../core/debouncer.dart';

class HomePageSearchFieldWidget extends StatelessWidget {
  const HomePageSearchFieldWidget({
    super.key,
    required Debouncer debouncer,
  }) : _debouncer = debouncer;

  final Debouncer _debouncer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
      child: TextField(
        onChanged: (value) {
          _debouncer.run(
            () {
              BlocProvider.of<HomeChatListBloc>(context)
                  .add(GetSearchChatList(chatQuery: value));
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
      ),
    );
  }
}