// To parse this JSON data, do
//
//     final allUsersAllUsersList = allUsersAllUsersListFromJson(jsonString);

import 'dart:convert';

AllUsersAllUsersList allUsersAllUsersListFromJson(String str) => AllUsersAllUsersList.fromJson(json.decode(str));

String allUsersAllUsersListToJson(AllUsersAllUsersList data) => json.encode(data.toJson());

class AllUsersAllUsersList {
  bool? success;
  String? message;
  AllUsersList? data;

  AllUsersAllUsersList({
    this.success,
    this.message,
    this.data,
  });

  factory AllUsersAllUsersList.fromJson(Map<String, dynamic> json) => AllUsersAllUsersList(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : AllUsersList.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class AllUsersList {
  List<User>? users;
  int? totalUsers;
  int? currentPage;
  int? totalPages;

  AllUsersList({
    this.users,
    this.totalUsers,
    this.currentPage,
    this.totalPages,
  });

  factory AllUsersList.fromJson(Map<String, dynamic> json) => AllUsersList(
    users: json["users"] == null ? [] : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
    totalUsers: json["totalUsers"],
    currentPage: json["currentPage"],
    totalPages: json["totalPages"],
  );

  Map<String, dynamic> toJson() => {
    "users": users == null ? [] : List<dynamic>.from(users!.map((x) => x.toJson())),
    "totalUsers": totalUsers,
    "currentPage": currentPage,
    "totalPages": totalPages,
  };
}

class User {
  String? id;
  String? email;
  bool? isProfileCompleted;
  String? bio;
  String? firstName;
  String? lastName;
  String? websiteLink;
  ProfileImage? profileImage;

  User({
    this.id,
    this.email,
    this.isProfileCompleted,
    this.bio,
    this.firstName,
    this.lastName,
    this.websiteLink,
    this.profileImage,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    email: json["email"],
    isProfileCompleted: json["isProfileCompleted"],
    bio: json["bio"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    websiteLink: json["websiteLink"],
    profileImage: json["profileImage"] is Map<String, dynamic> ? ProfileImage.fromJson(json["profileImage"]) : null,
  );


  Map<String, dynamic> toJson() => {
    "_id": id,
    "email": email,
    "isProfileCompleted": isProfileCompleted,
    "bio": bio,
    "firstName": firstName,
    "lastName": lastName,
    "websiteLink": websiteLink,
    "profileImage": profileImage?.toJson(),
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
