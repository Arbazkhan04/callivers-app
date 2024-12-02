import 'package:calliverse/Constants/textStyle.dart';
import 'package:flutter/material.dart';

class CallHeader extends StatelessWidget {
  const CallHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Text(
        "Calls",
        style: txtStyle18AndBold,
      ),
    );
  }
}