import 'package:flutter/material.dart';

class DateDivider extends StatelessWidget {
  final String date;

  const DateDivider({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(child: Divider()),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              date,
              style: TextStyle(
                color: Color(0xFFADB5BD),
                fontSize: 12,
                fontFamily: 'Mulish',
              ),
            ),
          ),
          Expanded(child: Divider()),
        ],
      ),
    );
  }
}