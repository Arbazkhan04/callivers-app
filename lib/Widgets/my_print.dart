import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

myPrint(data){
  if(kDebugMode){
    return print(data);
  }
}