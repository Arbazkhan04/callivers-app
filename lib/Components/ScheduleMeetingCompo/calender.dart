import 'package:flutter/material.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFCFCFC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFDEDEDE)),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          _buildCalendarHeader(),
          _buildWeekDays(),
          _buildCalendarDays(),
        ],
      ),
    );
  }

  Widget _buildCalendarHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Text(
              'Feb 2025',
              style: TextStyle(
                color: Color(0xFF095DEC),
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'Roboto',
              ),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios, size: 12, color: Color(0xFF095DEC)),
              onPressed: () {},
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios, size: 12, color: Color(0xFF095DEC)),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios, size: 12, color: Color(0xFF095DEC)),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWeekDays() {
    final weekDays = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: weekDays
          .map((day) => SizedBox(
        width: 32,
        child: Text(
          day,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFFBCCAD9),
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
          ),
        ),
      ))
          .toList(),
    );
  }

  Widget _buildCalendarDays() {
    // Calendar grid implementation here
    return const SizedBox(); // Implement full calendar grid
  }
}