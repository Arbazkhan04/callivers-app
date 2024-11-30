import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Widgets/button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 480),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 18),
                Image.asset(
                  'assets/images/Group 512214.png',
                  width: 262,
                  height: 270,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 42),
                Text(
                  'Connect easily with your family and friends over countries',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F1828),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 54),
                Text(
                  'Terms & Privacy Policy',
                  style: TextStyle(
                    color: const Color(0xFF0F1828),
                  ),
                ),
                const SizedBox(height: 23),
                WelcomeButton(
                  text: 'Continue with email',
                  backgroundColor: const Color(0xFF095DEC),
                  onPressed: () {},
                ),
                const SizedBox(height: 9),
                WelcomeButton(
                  text: 'Continue with phone',
                  backgroundColor: const Color(0xFF020520),
                  onPressed: () {},
                ),
                const SizedBox(height: 9),
                WelcomeButton(
                  text: 'Login',
                  backgroundColor: Colors.transparent,
                  textColor: const Color(0xFF095DEC),
                  onPressed: () {},
                ),
                const SizedBox(height: 13),
              ],
            ),
          ),
        ),
      ),
    );
  }
}