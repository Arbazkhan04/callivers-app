import 'package:calliverse/Constants/textStyle.dart';
import 'package:flutter/material.dart';

import 'message_list.dart';

class MessageTile extends StatefulWidget {
  final MessageData message;
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
          CircleAvatar(
            radius: 29.5,
            backgroundImage: NetworkImage(widget.message.avatarUrl),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.message.name,
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
                      widget.message.message,
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
                      widget.message.time,
                      style:
                      txtStyle12AndOther.copyWith(
                        letterSpacing: -0.24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (widget.message.hasRead)
                      const SizedBox(height: 7),
                    if (widget.message.hasRead)
                      const Icon(
                        Icons.done_all,
                        size: 17,
                        color: Color(0xFF8A91A8),
                      ),
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