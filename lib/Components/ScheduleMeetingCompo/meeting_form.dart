import 'package:calliverse/Components/common.dart';
import 'package:calliverse/Constants/color.dart';
import 'package:calliverse/Constants/sizedbox.dart';
import 'package:calliverse/Constants/textStyle.dart';
import 'package:calliverse/Widgets/button.dart';
import 'package:flutter/material.dart';

class MeetingForm extends StatefulWidget {
  @override
  State<MeetingForm> createState() => _MeetingFormState();
}

class _MeetingFormState extends State<MeetingForm> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            style: txtStyle14AndBlack,
            decoration: InputDecoration(
              hintText: 'Title',
              hintStyle: txtStyle14AndOther,

              filled: true,
              fillColor: Color(0xFFF7F7FC),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          sizeHeight10,
          TextFormField(
            maxLines: 4,
            style: txtStyle14AndBlack,
            decoration: InputDecoration(
              hintText: 'Description',
              // hintText: 'Description',
              hintStyle: txtStyle14AndOther,
              filled: true,
              fillColor: Color(0xFFF7F7FC),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          sizeHeight10,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value ?? false;
                  });
                },
                activeColor: mainColor,
                side: BorderSide(color: otherColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  // side: BorderSide(color: ,)
                ),
              ),
              Text(
                "Add Reminder",
                style: txtStyle14AndOther,
              ),
            ],
          ),
          sizeHeight10,
          TextFormField(
            maxLines: 4,
            style: txtStyle14AndBlack,

            decoration: InputDecoration(
              hintText: 'Personal Notes',
              filled: true,
              hintStyle: txtStyle14AndOther,
              fillColor: Color(0xFFF7F7FC),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          SizedBox(height: 25),
          MyButton(text: "Schedule", onPressed: (){
            pop();
          }),
        ],
      ),
    );
  }

}