import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../Constants/color.dart';
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
