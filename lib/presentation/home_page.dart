import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk_a_tive/bussiness_logic/user_login/user_login_bloc.dart';
import 'package:talk_a_tive/presentation/chat_page.dart';

import 'components/chat_user_list.dart';
import 'components/user_list_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserLoginBloc, UserLoginState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Scaffold(
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SafeArea(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Talkative",
                            style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              left: 8,
                              right: 8,
                              top: 2,
                              bottom: 2,
                            ),
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.pink[50],
                            ),
                            child: const Row(
                              children: <Widget>[
                                Icon(
                                  Icons.add,
                                  color: Colors.pink,
                                  size: 20,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "Add New",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: TextField(
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
                        contentPadding: const EdgeInsets.all(10),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                BorderSide(color: Colors.grey.shade300)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                BorderSide(color: Colors.grey.shade300)),
                      ),
                    ),
                  ),
                  ListView.builder(
                    itemCount: UserChatDetailList.chatUsers.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 16),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final chatUsers = UserChatDetailList.chatUsers;
                      return ConversationList(
                        name: chatUsers[index].name,
                        messageText: chatUsers[index].messageText,
                        imageUrl: chatUsers[index].imageURL,
                        time: chatUsers[index].time,
                        isMessageRead:
                            (index == 0 || index == 3) ? true : false,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatPage(
                                  imageUrl: chatUsers[index].imageURL,
                                  userName: chatUsers[index].name,
                                ),
                              ));
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
