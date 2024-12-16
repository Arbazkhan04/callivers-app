// To parse this JSON data, do
//
//     final otpReturnModelData = otpReturnModelDataFromJson(jsonString);

import 'dart:convert';

OtpReturnModelData otpReturnModelDataFromJson(String str) => OtpReturnModelData.fromJson(json.decode(str));

String otpReturnModelDataToJson(OtpReturnModelData data) => json.encode(data.toJson());

class OtpReturnModelData {
  String? message;
  String? userId;
  String? email;
  bool? isEmailVerified;
  String? token;
  bool? data;

  OtpReturnModelData({
    this.message,
    this.userId,
    this.email,
    this.isEmailVerified,
    this.token,
    this.data,
  });

  factory OtpReturnModelData.fromJson(Map<String, dynamic> json) => OtpReturnModelData(
    message: json["message"],
    userId: json["userId"],
    email: json["email"],
    isEmailVerified: json["isEmailVerified"],
    token: json["token"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "userId": userId,
    "email": email,
    "isEmailVerified": isEmailVerified,
    "token": token,
    "data": data,
  };
}
