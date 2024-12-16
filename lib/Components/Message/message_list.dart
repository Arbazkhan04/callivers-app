import 'package:calliverse/Components/widget_extensions.dart';
import 'package:calliverse/Screens/ChatScreen/chat_screen.dart';
import 'package:flutter/material.dart';

import 'message_tile.dart';

// class MessageList extends StatelessWidget {
//   const MessageList({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.separated(
//       padding: const EdgeInsets.all(20),
//       itemCount: messageData.length,
//       separatorBuilder: (context, index) => const Divider(
//         height: 24,
//         thickness: 1,
//         color: Color(0xFFEFF0F1),
//       ),
//       itemBuilder: (context, index) => MessageTile(
//         message: messageData[index],
//         onTap: (){
//           ChatScreen(item: messageData[index],).launch(context);
//         },
//
//       ),
//     );
//   }
// }

final List<MessageData> messageData = [
  MessageData(
    name: 'Pranav Ray',
    message: 'okay sure!!',
    time: '12:25 PM',
    avatarUrl: 'https://cdn.builder.io/api/v1/image/assets/TEMP/d4c9f3de9839e42d1a6bb784392eaff5c5b801856125f2411e2f76ca5de8987a?placeholderIfAbsent=true&apiKey=868dfe7ca9874e83907b13f575a31561',
    hasRead: true,
  ),
  MessageData(
    name: 'Umer Ferrari',
    message: 'Yeah!',
    time: '01:25 PM',
    avatarUrl: 'https://cdn.builder.io/api/v1/image/assets/TEMP/d4c9f3de9839e42d1a6bb784392eaff5c5b801856125f2411e2f76ca5de8987a?placeholderIfAbsent=true&apiKey=868dfe7ca9874e83907b13f575a31561',
    hasRead: true,
  ),
  MessageData(
    name: 'Pranav Ray',
    message: 'Why?',
    time: '02:25 PM',
    avatarUrl: 'https://cdn.builder.io/api/v1/image/assets/TEMP/d4c9f3de9839e42d1a6bb784392eaff5c5b801856125f2411e2f76ca5de8987a?placeholderIfAbsent=true&apiKey=868dfe7ca9874e83907b13f575a31561',
    hasRead: true,
  ),
  // Add all other message data here
];

class MessageData {
  final String name;
  final String message;
  final String time;
  final String avatarUrl;
  final bool hasRead;

  MessageData({
    required this.name,
    required this.message,
    required this.time,
    required this.avatarUrl,
    required this.hasRead,
  });
}