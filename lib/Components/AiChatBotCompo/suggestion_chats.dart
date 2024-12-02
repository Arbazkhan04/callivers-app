import 'package:calliverse/Constants/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SuggestionButtons extends StatelessWidget {
  const SuggestionButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 27),
      child: Column(
        children: [
          _buildSuggestionButton('Explain Quantum physics'),
          const SizedBox(height: 8),
          _buildSuggestionButton('Write a tweet about global warming'),
          const SizedBox(height: 8),
          _buildSuggestionButton('Write a poem about flower and love'),
          const SizedBox(height: 8),
          _buildSuggestionButton('Write a rap song lyrics about'),
        ],
      ),
    );
  }

  Widget _buildSuggestionButton(String text) {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: txtStyle14AndBlack,
      ),
    );
  }
}