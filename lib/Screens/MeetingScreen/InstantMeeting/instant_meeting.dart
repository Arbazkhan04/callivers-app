import 'package:flutter/material.dart';
// import 'package:meeting/widgets/meeting_header.dart';
// import 'package:meeting/widgets/meeting_details.dart';
// import 'package:meeting/widgets/invite_section.dart';

import '../../../Components/InstantMeeting/invite_section.dart';
import '../../../Components/InstantMeeting/meeting_details.dart';
import '../../../Widgets/appbar.dart';

class MeetingScreen extends StatelessWidget {
  const MeetingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(
        title: "Meeting Title",
      ),
      body: SingleChildScrollView(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 480),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              // MeetingHeader(),
              MeetingDetails(),
              InviteSection(),
            ],
          ),
        ),
      ),
    );
  }
}