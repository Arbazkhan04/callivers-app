import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Components/AiChatBotCompo/ai_chat_input.dart';
import '../../Components/AiChatBotCompo/suggestion_chats.dart';
import '../../Components/AiChatBotCompo/welcome_section.dart';
import '../../Constants/textStyle.dart';

class AiChatBotScreen extends StatelessWidget {
  const AiChatBotScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Juliabot',
                  style: txtStyle18AndBold,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: const [
                      WelcomeSection(),
                      SuggestionButtons(),
                    ],
                  ),
                ),
              ),
              ChatInput(),
            ],
          ),
        ),
      ),
    );
  }
}