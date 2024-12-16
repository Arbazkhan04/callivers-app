import 'package:calliverse/Constants/paths.dart';
import 'package:calliverse/Constants/textStyle.dart';
import 'package:calliverse/Provider/chat_provider.dart';
import 'package:calliverse/utils/app_common.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../modals/all_user_chats_model.dart';
import '../Message/message_list.dart';

class ChatHeader extends StatefulWidget {
  final Participant item;
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
    return Consumer<ChatProvider>(
      builder: (context,chatProvider,_) {
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
                    onPressed: () {
                      chatProvider.userAllChatFun();
                      Navigator.pop(context);},
                  ),
                  cachedImage(widget.item.profileImage?.imageUrl,width: 45,height: 45,fit: BoxFit.cover,radius: 300),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.item.firstName ?? "",
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
    );
  }
}