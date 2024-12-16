// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  bool? success;
  String? message;
  UserInfoModel? data;

  LoginResponse({
    this.success,
    this.message,
    this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : UserInfoModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class UserInfoModel {
  String? firstName;
  String? lastName;
  ProfileImage? profileImage;
  String? email;
  bool? isProfileCompleted;
  bool? isEmailVerified;
  String? userId;
  String? bio;
  String? websiteLink;
  String? token;

  UserInfoModel({
    this.firstName,
    this.lastName,
    this.profileImage,
    this.email,
    this.isProfileCompleted,
    this.isEmailVerified,
    this.userId,
    this.bio,
    this.websiteLink,
    this.token,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
    firstName: json["firstName"],
    lastName: json["lastName"],
    profileImage: json["profileImage"] == null ? null : ProfileImage.fromJson(json["profileImage"]),
    email: json["email"],
    isProfileCompleted: json["isProfileCompleted"],
    isEmailVerified: json["isEmailVerified"],
    userId: json["userId"],
    bio: json["bio"],
    websiteLink: json["websiteLink"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "profileImage": profileImage?.toJson(),
    "email": email,
    "isProfileCompleted": isProfileCompleted,
    "isEmailVerified": isEmailVerified,
    "userId": userId,
    "bio": bio,
    "websiteLink": websiteLink,
    "token": token,
  };
}

class ProfileImage {
  String? imageUrl;
  String? imageMimeType;
  String? imageName;

  ProfileImage({
    this.imageUrl,
    this.imageMimeType,
    this.imageName,
  });

  factory ProfileImage.fromJson(Map<String, dynamic> json) => ProfileImage(
    imageUrl: json["imageUrl"],
    imageMimeType: json["imageMimeType"],
    imageName: json["imageName"],
  );

  Map<String, dynamic> toJson() => {
    "imageUrl": imageUrl,
    "imageMimeType": imageMimeType,
    "imageName": imageName,
  };
}