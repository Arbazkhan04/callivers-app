import 'package:calliverse/Constants/paths.dart';
import 'package:calliverse/Constants/textStyle.dart';
import 'package:flutter/material.dart';

import '../Message/message_list.dart';

class ChatHeader extends StatefulWidget {
  final MessageData item;
  ChatHeader({
    Key? key,
    required this.item,
  }) : super(key: key);
  @override
  State<ChatHeader> createState() => _ChatHeaderState();
}

class _ChatHeaderState extends State<ChatHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xFFEDEDED)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: Semantics(
                  label: 'Back',
                  child: Icon(Icons.arrow_back),
                ),
                onPressed: () => Navigator.pop(context),
              ),
              CircleAvatar(
                radius: 22.5,
                backgroundImage: AssetImage(demoNewMessagePersonImage),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  widget.item.name,
                  style: txtStyle18AndBold,
                ),
              ),
              IconButton(
                icon: Semantics(
    label: 'More options',
    child: Icon(Icons.more_vert)
    ),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}