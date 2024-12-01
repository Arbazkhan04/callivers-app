import 'package:calliverse/Constants/paths.dart';
import 'package:flutter/material.dart';

class ChatHeader extends StatelessWidget {
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
                  'John Doe',
                  style: TextStyle(
                    fontFamily: 'Mulish',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0F1828),
                  ),
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