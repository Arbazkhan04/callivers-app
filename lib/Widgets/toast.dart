
import 'dart:ui';

import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../Constants/color.dart';
import '../Constants/paths.dart';
import '../Constants/sizedbox.dart';
import '../Constants/textStyle.dart';


/// Shows a toast in android
class AppToast {
  /// Shows a toast with the message in android
  static void show(String shortMessage) {
    Fluttertoast.showToast(
        msg: shortMessage,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        fontSize: 14.0);
  }
}

const indicatorMainColor = Center(child: CircularProgressIndicator(color: mainColor,),);
const indicatorWhiteColor = Center(child: CircularProgressIndicator(color: whiteColor,),);

showMyWaitingModal({required BuildContext context,bool? isTextShowBool,String? loadingText}){

  return  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        // elevation: 0,
        // color: transparentColor,
        elevation: 0,
        backgroundColor: isTextShowBool == true? whiteColor : transparentColor,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: mainColor),
              // SpinKitWaveSpinner(color: mainColor,waveColor: mainColor,),
              isTextShowBool != null && isTextShowBool == true? sizeWidth10 : SizedBox(),
              isTextShowBool != null && isTextShowBool == true? Expanded(
                child: Text(
                  loadingText ??
                  "We are creating your new shiny account",
                  textAlign: TextAlign.center,
                  style: txtStyle14AndMainBold,),
              ) : SizedBox(),
            ],
          ),
        ),
      );
    },
  );
}
backDropWithLoading({required BuildContext context}){
  final scrSize = MediaQuery.of(context).size;
  return  Container(
    height: scrSize.height,
    width: scrSize.width,
    child: Scaffold(
      backgroundColor: transparentColor,
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 10,sigmaX: 10),
        child: Center(
          child: CircularProgressIndicator(
            color: mainColor,
            // waveColor: mainColor,
          ),
        ),
      ),
    ),
  );
}

messageWithImage({String? messageText}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(ic_placeholder,width: 60,),
      sizeHeight20,
      Text(messageText??"",style: txtStyle16AndOther,),

    ],
  );
}

