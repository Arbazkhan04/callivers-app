import 'package:calliverse/Constants/paths.dart';
import 'package:flutter/material.dart';

import 'date_divider.dart';
import 'message_bubble.dart';

class ChatMessages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 12),
      children: [
        MessageBubble(
          message: 'Look at how chocho sleep in my arms!',
          time: '16.46',
          isMe: false,
          hasImage: true,
          imageUrl: demoChatImage,
        ),
        MessageBubble(
          message: 'Of course, let me know if you\'re on your way',
          time: '16.46',
          isMe: false,
          quotedMessage: 'Can I come over?',
        ),
        MessageBubble(
          message: 'K, I\'m on my way',
          time: '16.50',
          isMe: true,
          isRead: true,
        ),
        DateDivider(date: 'Sat, 17/10'),
        MessageBubble(
          message: '',
          time: '09.13',
          isMe: true,
          isRead: true,
          hasVoiceMessage: true,
          voiceDuration: '0:20',
        ),
        MessageBubble(
          message: 'Good morning, did you sleep well?',
          time: '09.45',
          isMe: false,
        ),
      ],
    );
  }
}