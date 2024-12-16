import 'package:calliverse/Constants/paths.dart';
import 'package:calliverse/Constants/textStyle.dart';
import 'package:calliverse/modals/all_user_chats_model.dart';
import 'package:calliverse/utils/app_common.dart';
import 'package:flutter/material.dart';

import '../../modals/all_users_model_data.dart';
import 'message_list.dart';

class MessageTile extends StatefulWidget {
  // final MessageData message;
  final Chat? message;
  final Function() onTap;

  MessageTile({
    Key? key,
    required this.message, required this.onTap,
  }) : super(key: key);

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Row(
        children: [
          // Text("data"),
          // CircleAvatar(
          //   radius: 29.5,
          //   // backgroundImage: NetworkImage(widget.message.avatarUrl),
          //   backgroundImage: NetworkImage(widget.message != null && widget.message!.profileImage != null && widget.message!.profileImage!.imageUrl != null? widget.message!.profileImage!.imageUrl! : ""),
          // ),
          // Image.network(widget.message!.participants!.first.profileImage?.imageUrl ?? "",width: 40,),
          cachedImage(
              widget.message != null && widget.message!.participants != null && widget.message!.participants?.first.profileImage!= null && widget.message!.participants?.first.profileImage?.imageUrl != null?
              widget.message!.participants!.first.profileImage?.imageUrl!
                  :
              ic_placeholder,
              width: 55,height: 55,radius: 300,fit: BoxFit.cover),
          const SizedBox(width: 20),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // widget.message.name,
                      widget.message?.participants?.first.firstName ?? "",
                      style:
                      txtStyle16AndBold.copyWith(

                        letterSpacing: -0.3,
                      ),
                      // const TextStyle(
                      //   fontSize: 15,
                      //   fontWeight: FontWeight.w700,
                      //   color: Colors.black,
                      // ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "",
                      // widget.message.message,
                      style:
                      txtStyle14AndOther.copyWith(
                        letterSpacing: -0.28,
                        fontWeight: FontWeight.w700,
                      ),
                      // const TextStyle(
                      //   fontSize: 14,
                      //   fontWeight: FontWeight.w500,
                      //   color: Color(0xFF8A91A8),
                      // ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "",
                      // widget.message.time,
                      style:
                      txtStyle12AndOther.copyWith(
                        letterSpacing: -0.24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // if (widget.message.hasRead)
                    //   const SizedBox(height: 7),
                    // if (widget.message.hasRead)
                    //   const Icon(
                    //     Icons.done_all,
                    //     size: 17,
                    //     color: Color(0xFF8A91A8),
                    //   ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}