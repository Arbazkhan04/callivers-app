import 'package:calliverse/Constants/color.dart';
import 'package:calliverse/Constants/textStyle.dart';
import 'package:calliverse/Widgets/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String time;
  final bool isMe;
  final bool isRead;
  final bool hasImage;
  final String imageUrl;
  final String quotedMessage;
  final bool hasVoiceMessage;
  final String voiceDuration;

  const MessageBubble({
    Key? key,
    required this.message,
    required this.time,
    required this.isMe,
    this.isRead = false,
    this.hasImage = false,
    this.imageUrl = '',
    this.quotedMessage = '',
    this.hasVoiceMessage = false,
    this.voiceDuration = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          left: isMe ? 48 : 16,
          right: isMe ? 16 : 48,
          bottom: 12,
        ),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isMe ? mainColor : Colors.white,
          borderRadius: BorderRadius.circular(16).copyWith(
            bottomRight: isMe ? Radius.circular(0) : Radius.circular(16),
            bottomLeft: isMe ? Radius.circular(16) : Radius.circular(0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (hasImage) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: imageUrl.startsWith("assets") == true? Image.asset(imageUrl) : Image.network(imageUrl),
              ),
              SizedBox(height: 4),
            ],
            if (quotedMessage.isNotEmpty) ...[
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isMe ? mainColor : Color(0xFFEDEDED),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  quotedMessage,
                  style:
                  txtStyle14AndBold.copyWith(
                    color: isMe ? Colors.white : textColor,
                  ),
                  // TextStyle(
                  //
                  //   fontSize: 14,
                  // ),
                ),
              ),
              SizedBox(height: 4),
            ],
            if (hasVoiceMessage) ...[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.play_arrow, color: Colors.white, size: 16),
                  SizedBox(width: 4),
                  Text(
                    voiceDuration,
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ],
              ),
            ],
            if (message.isNotEmpty)
              Text(
                message,
                style: TextStyle(
                  color: isMe ? Colors.white : Color(0xFF0F1828),
                  fontSize: 14,
                  fontFamily: 'Mulish',
                ),
              ),
            SizedBox(height: 4),
            Text(
              // isMe ? '${DateFormat("").format(DateTime.parse(time))} · Read' : time,
              isMe ? '${convertToUserLocalTime(time)} · Read' : convertToUserLocalTime(time),
              style: TextStyle(
                color: isMe ? Colors.white70 : Color(0xFFADB5BD),
                fontSize: 10,
                fontFamily: 'Lato',
              ),
            ),
          ],
        ),
      ),
    );
  }
}