import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:calliverse/Provider/authen_provider.dart';
import 'package:calliverse/Widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Constants/color.dart';
import '../Constants/paths.dart';
import '../Constants/sizedbox.dart';
import '../main.dart';


const borderRadiusValue = 30.0;

dialogBox({context,content,contentPadding,ScrollPhysics? listViewScrollPhysics,BoxConstraints? dialogBoxConstraint}){
  return  showDialog(
      context: navigatorKey.currentState!.context,
      barrierDismissible: false,

      builder: (_){
        return WillPopScope(child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Dialog(
            backgroundColor: whiteColor,
            elevation: 0,
            insetPadding: EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.center,
            // actionsPadding: EdgeInsets.zero,
            // titlePadding: EdgeInsets.zero,
            // iconPadding: EdgeInsets.zero,
            // buttonPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadiusValue),
            ),
            child: Stack(
              children: [
                ListView(
                  shrinkWrap: true,
                  physics: listViewScrollPhysics ?? AlwaysScrollableScrollPhysics(),
                  padding: contentPadding ?? EdgeInsets.symmetric(horizontal: 5,vertical: 20),
                  children: [
                    content,
                  ],
                ),
              ],
            ),
          ),
        ), onWillPop: ()async{
          return false;
        });
      });
}



///Logout Dialog
logoutDialogBox({required BuildContext context,}) {
  final provider = Provider.of<AuthenProvider>(context,listen: false);
  dialogBox(
    context: context,
    content: Column(
      children: [
        Image.asset(logoutDialogIcon,height: 50,),
        sizeHeight30,
        Align(
          alignment: Alignment.topCenter,
          child: Text(
            'Logout',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              // height: 0,
            ),
          ),
        ),
        sizeHeight10,
        Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            // width: 243.30,
            // height: 14,
            child: Text(
              'Are you sure you want to logout?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                // height: 0,
              ),
            ),
          ),
        ),
        sizeHeight40,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: MyButton(text: "Yes",onPressed: (){
            // Navigator.pop(context);
            provider.logoutFun();
            // Navigator.push(context, MaterialPageRoute(builder: (context) => SignupFullName()));
          },),
        ),
        sizeHeight30,
        TextButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text(
              'No',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            )),
        // sizeHeight30,
      ],
    ),
  );
}