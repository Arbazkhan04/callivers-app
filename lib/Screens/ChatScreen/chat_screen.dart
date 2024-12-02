import 'package:flutter/material.dart';

import '../../Components/ChatComponents/chat_header.dart';
import '../../Components/ChatComponents/chat_input.dart';
import '../../Components/ChatComponents/chat_message.dart';
import '../../Components/Message/message_list.dart';

class ChatScreen extends StatefulWidget {
  final MessageData item;
  ChatScreen({
    Key? key,
    required this.item,
  }) : super(key: key);
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}
class _ChatScreenState extends State<ChatScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7FC),
      body: SafeArea(
        child: Column(
          children: [
            ChatHeader(item: widget.item,),
            Expanded(
              child: ChatMessages(),
            ),
            ChatInput(),
          ],
        ),
      ),
    );
  }
}