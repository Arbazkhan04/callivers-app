import 'package:flutter/material.dart';

class CountrySelector extends StatelessWidget {
  const CountrySelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 11),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7FC),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/us_flag.png',
            width: 24,
            height: 24,
          ),
          const SizedBox(width: 8),
          const Text(
            '+1',
            style: TextStyle(
              color: Color(0xFFADB5BD),
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Mulish',
            ),
          ),
        ],
      ),
    );
  }
}