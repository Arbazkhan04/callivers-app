import 'package:flutter/material.dart';

import '../../Components/ChatComponents/chat_header.dart';
import '../../Components/ChatComponents/chat_input.dart';
import '../../Components/ChatComponents/chat_message.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7FC),
      body: SafeArea(
        child: Container(
          // constraints: BoxConstraints(maxWidth: 480),
          // margin: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              ChatHeader(),
              Expanded(
                child: ChatMessages(),
              ),
              ChatInput(),
            ],
          ),
        ),
      ),
    );
  }
}