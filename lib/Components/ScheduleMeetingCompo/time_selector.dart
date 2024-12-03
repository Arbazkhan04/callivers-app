// import 'package:flutter/material.dart';
//
// class TimeSelectorWidget extends StatelessWidget {
//   const TimeSelectorWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         const Text(
//           'Time',
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w500,
//             color: Color(0xFF213447),
//             fontFamily: 'Roboto',
//           ),
//         ),
//         Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFF0F3F7),
//                 borderRadius: BorderRadius.circular(5),
//               ),
//               child: const Text(
//                 '09:32',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Color(0xFF213447),
//                   fontFamily: 'Roboto',
//                 ),
//               ),
//             ),
//             const SizedBox(width: 8),
//             Container(
//               width: 101,
//               height: 32,
//               decoration: BoxDecoration(
//                 color: const Color(0xFFF0F3F7),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Row(
//                 children: const [
//                   Expanded(
//                     child: _AmPmButton(
//                       text: 'AM',
//                       isSelected: true,
//                     ),
//                   ),
//                   Expanded(
//                     child: _AmPmButton(
//                       text: 'PM',
//                       isSelected: false,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
//
// class _AmPmButton extends StatelessWidget {
//   final String text;
//   final bool isSelected;
//
//   const _AmPmButton({
//     Key? key,
//     required this.text,
//     required this.isSelected,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: isSelected ? Colors.white : Colors.transparent,
//         borderRadius: BorderRadius.circular(8),
//         boxShadow: isSelected
//             ? [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.12),
//             blurRadius: 8,
//             offset: const Offset(0, 3),
//           ),
//         ]
//             : null,
//       ),
//       child: Center(
//         child: Text(
//           text,
//           style: TextStyle(
//             fontSize: 14,
//             color: const Color(0xFF213447),
//             fontFamily: 'Roboto',
//             fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:calliverse/Constants/color.dart';
import 'package:calliverse/Constants/color.dart';
import 'package:calliverse/Constants/color.dart';
import 'package:calliverse/Constants/sizedbox.dart';
import 'package:calliverse/Constants/textStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class TimePickerExample extends StatefulWidget {
  const TimePickerExample({Key? key}) : super(key: key);

  @override
  _TimePickerExampleState createState() => _TimePickerExampleState();
}

class _TimePickerExampleState extends State<TimePickerExample> {
  final TextEditingController _hourController = TextEditingController();
  final TextEditingController _minuteController = TextEditingController();
  bool isAM = true;

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Time",style: txtStyle16AndBold,),
        spacer,
        // Hours TextField
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
          decoration: BoxDecoration(
            color: const Color(0xFFF0F3F7),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: [
        SizedBox(
          width:20,
          child: TextField(
            controller: _hourController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 2,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(2),
              _HourInputFormatter(),
            ],
            decoration: InputDecoration(
              counterText: '', // Hide character counter
              hintText: 'HH',
              hintStyle: txtStyle14AndBold,
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              isDense: true,
            ),
          ),
        ),
        Text(' : ',style: txtStyle14AndBlack,), // Separator
        // Minutes TextField
        Container(
          width:25,
          // color: mainColor,
          child: TextField(
            controller: _minuteController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 2,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(2),
              _MinuteInputFormatter(),
            ],
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              isDense: true,
              counterText: '', // Hide character counter
              hintText: 'MM',
              border: InputBorder.none,
              hintStyle: txtStyle14AndBold,

            ),
          ),
        ),

            ],
          ),
        ),
        const SizedBox(width: 10),
        // AM/PM Toggle
        ToggleButtons(
          isSelected: [isAM, !isAM],
          onPressed: (index) {
            setState(() {
              isAM = index == 0;
            });
          },
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Text('AM'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Text('PM'),
            ),
          ],
          borderRadius: BorderRadius.circular(5),
          borderColor: Colors.grey,
          selectedBorderColor: mainColor,
          selectedColor: Colors.white,
          fillColor: mainColor,
          constraints: const BoxConstraints(minWidth: 50, minHeight: 36),
        ),
      ],
    );
  }
}

// Custom Input Formatter for Hours
class _HourInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final intValue = int.tryParse(newValue.text);
    if (intValue == null || intValue < 1 || intValue > 12) {
      return oldValue;
    }
    return newValue;
  }
}

// Custom Input Formatter for Minutes
class _MinuteInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final intValue = int.tryParse(newValue.text);
    if (intValue == null || intValue < 0 || intValue > 59) {
      return oldValue;
    }
    return newValue;
  }
}