import 'package:flutter/material.dart';

import '../../Constants/color.dart';
import '../../Widgets/button.dart';
import '../../Widgets/copyToClipboard.dart';
import '../../main.dart';

class InviteField extends StatelessWidget {
  final String label;
  final String value;

  const InviteField({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Stack(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 11),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F7FC),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFFADB5BD),
                ),
              ),
            ),
            Positioned(
              right: 0,
              // top: 12,
              child:  CustomIconButton(icon: Icon(Icons.copy,color: mainColor,size: 20,), onPressed: (){
                copyToClipboard(text: value, context: navigatorKey.currentState!.context);
              }),
            ),
          ],
        ),
      ],
    );
  }
}
