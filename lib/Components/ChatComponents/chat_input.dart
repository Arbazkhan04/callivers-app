import 'package:flutter/material.dart';

class ChatInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xFFEDEDED)),
      ),
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFF4F4F4),
                borderRadius: BorderRadius.circular(25),
              ),
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.emoji_emotions_outlined),
                    onPressed: () {},
                    // semanticLabel: 'Choose emoji',
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Color(0xFF7D818B),
                          fontFamily: 'Mulish',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.attach_file),
                    onPressed: () {},
                    // semanticLabel: 'Attach file',
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 6),
          FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.mic),
            backgroundColor: Theme.of(context).primaryColor,
            mini: true,
          ),
        ],
      ),
    );
  }
}