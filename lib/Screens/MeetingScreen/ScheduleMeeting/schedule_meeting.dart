import 'package:calliverse/Constants/sizedbox.dart';
import 'package:calliverse/Constants/textStyle.dart';
import 'package:flutter/material.dart';

import '../../../Components/Meeting/meeting_calender.dart';
import '../../../Components/ScheduleMeetingCompo/meeting_form.dart';
import '../../../Components/ScheduleMeetingCompo/time_selector.dart';
import '../../../Widgets/appbar.dart';


class ScheduleMeetingScreen extends StatelessWidget {
  const ScheduleMeetingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(
        title: "Schedule Meetings",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children:  [
              CalendarWidget(),
              sizeHeight15,
              SizedBox(
                  width: double.maxFinite,
                  height: 60,
                  child: TimePickerExample()),
              sizeHeight15,
              MeetingForm(),
            ],
          ),
        ),
      ),
    );
  }
}