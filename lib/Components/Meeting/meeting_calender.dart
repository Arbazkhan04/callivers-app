import 'package:calliverse/Constants/color.dart';
import 'package:calliverse/Constants/color.dart';
import 'package:calliverse/Constants/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({Key? key}) : super(key: key);

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: TableCalendar(

        firstDay: DateTime.now(),
        lastDay: DateTime.now().add(Duration(days: 365)),
        focusedDay: _focusedDay,

        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },

        calendarStyle: CalendarStyle(

          defaultTextStyle: txtStyle14AndBlack,
          selectedDecoration: BoxDecoration(
            color: mainColor,
            shape: BoxShape.circle,
          ),
          todayDecoration: BoxDecoration(
            color: mainColor,
            shape: BoxShape.circle,
          ),
        ),
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          // formatButtonTextStyle: txtStyle18AndBold,
          titleCentered: true,
          titleTextStyle: txtStyle16AndMainBold,

        ),
      ),
    );
  }
}