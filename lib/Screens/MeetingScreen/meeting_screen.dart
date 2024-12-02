import 'package:calliverse/Constants/color.dart';
import 'package:calliverse/Constants/sizedbox.dart';
import 'package:calliverse/Widgets/button.dart';
import 'package:flutter/material.dart';

import '../../Components/Meeting/join_meeting.dart';
import '../../Components/Meeting/meeting_calender.dart';
import '../../Constants/textStyle.dart';

class MeetingsScreen extends StatelessWidget {
  const MeetingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Meetings',
                  style: txtStyle18AndBold,
                ),
              ),
              SizedBox(height: 7),
              JoinMeetingWidget(),
              SizedBox(height: 21),
              Padding(
                padding: kDefaultPaddingHorizontal,
                child: MyButton(
                    text: "Start an instant meeting",
                    onPressed: (){

                    }),
              ),
              sizeHeight10,
              Padding(
                padding: kDefaultPaddingHorizontal,
                child: MyButton(
                    text: "Schedule for later",
                    textColor: mainColor,
                    backgroundColor: Color(0xffe7effe),
                    onPressed: (){

                    }),
              ),
              // MeetingButtonsWidget(),
              sizeHeight30,
              CalendarWidget(),
            ],
          ),
        ),
      ),
    );
  }
}