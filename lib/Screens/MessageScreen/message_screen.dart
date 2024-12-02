import 'package:calliverse/Constants/color.dart';
import 'package:calliverse/utils/app_common.dart';
import 'package:calliverse/utils/app_images.dart';
import 'package:flutter/material.dart';

import '../../Components/Message/message_header.dart';
import '../../Components/Message/message_list.dart';
import '../../Constants/paths.dart';
import '../../Widgets/button.dart';
import '../BottomBar/bottom_bar.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: const [
            MessageHeader(),
            Expanded(
              child: MessageList(),
            ),
          ],
        ),
      ),
      floatingActionButton: CustomFloatingActionButton(
        onTap: (){},
        icon: cachedImage(createChatIcon,width: 25),

      ),
    );
  }
}