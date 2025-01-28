// To parse this JSON data, do
//
//     final allUserChats = allUserChatsFromJson(jsonString);

import 'dart:convert';

AllUserChats allUserChatsFromJson(String str) => AllUserChats.fromJson(json.decode(str));

String allUserChatsToJson(AllUserChats data) => json.encode(data.toJson());

class AllUserChats {
  bool? success;
  String? message;
  AllChat? data;

  AllUserChats({
    this.success,
    this.message,
    this.data,
  });

  factory AllUserChats.fromJson(Map<String, dynamic> json) => AllUserChats(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : AllChat.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class AllChat {
  List<Chat>? chats;
  int? totalChats;
  int? currentPage;
  int? totalPages;

  AllChat({
    this.chats,
    this.totalChats,
    this.currentPage,
    this.totalPages,
  });

  factory AllChat.fromJson(Map<String, dynamic> json) => AllChat(
    chats: json["chats"] == null ? [] : List<Chat>.from(json["chats"]!.map((x) => Chat.fromJson(x))),
    totalChats: json["totalChats"],
    currentPage: json["currentPage"],
    totalPages: json["totalPages"],
  );

  Map<String, dynamic> toJson() => {
    "chats": chats == null ? [] : List<dynamic>.from(chats!.map((x) => x.toJson())),
    "totalChats": totalChats,
    "currentPage": currentPage,
    "totalPages": totalPages,
  };
}

class Chat {
  String? id;
  List<Participant>? participants;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? v;
  LastMessage? lastMessage;

  Chat({
    this.id,
    this.participants,
    this.updatedAt,
    this.createdAt,
    this.v,
    this.lastMessage,
  });

  // factory Chat.fromJson(Map<String, dynamic> json) => Chat(
  //   id: json["_id"],
  //   participants: json["participants"] == null ? [] : List<Participant>.from(json["participants"]!.map((x) => Participant.fromJson(x))),
  //   updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  //   createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
  //   v: json["__v"],
  //   lastMessage: json["lastMessage"] == null ? null : LastMessage.fromJson(json["lastMessage"]),
  // );
  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
    id: json["_id"] ?? "default_id", // Provide a fallback for null values
    participants: json["participants"] == null
        ? []
        : List<Participant>.from(json["participants"]!.map((x) => Participant.fromJson(x))),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    v: json["__v"],
    lastMessage: json["lastMessage"] == null ? null : LastMessage.fromJson(json["lastMessage"]),
  );


  Map<String, dynamic> toJson() => {
    "_id": id,
    "participants": participants == null ? [] : List<dynamic>.from(participants!.map((x) => x.toJson())),
    "updatedAt": updatedAt?.toIso8601String(),
    "createdAt": createdAt?.toIso8601String(),
    "__v": v,
    "lastMessage": lastMessage?.toJson(),
  };
}

class LastMessage {
  String? id;
  String? chatId;
  String? senderId;
  String? receiverId;
  String? messageType;
  String? content;
  DateTime? timestamp;
  bool? delivered;
  List<dynamic>? files;
  List<dynamic>? readBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  LastMessage({
    this.id,
    this.chatId,
    this.senderId,
    this.receiverId,
    this.messageType,
    this.content,
    this.timestamp,
    this.delivered,
    this.files,
    this.readBy,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
    id: json["_id"],
    chatId: json["chatId"],
    senderId: json["senderId"],
    receiverId: json["receiverId"],
    messageType: json["messageType"],
    content: json["content"],
    timestamp: json["timestamp"] == null ? null : DateTime.parse(json["timestamp"]),
    delivered: json["delivered"],
    files: json["files"] == null ? [] : List<dynamic>.from(json["files"]!.map((x) => x)),
    readBy: json["readBy"] == null ? [] : List<dynamic>.from(json["readBy"]!.map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "chatId": chatId,
    "senderId": senderId,
    "receiverId": receiverId,
    "messageType": messageType,
    "content": content,
    "timestamp": timestamp?.toIso8601String(),
    "delivered": delivered,
    "files": files == null ? [] : List<dynamic>.from(files!.map((x) => x)),
    "readBy": readBy == null ? [] : List<dynamic>.from(readBy!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Participant {
  // ProfileImage? profileImage;
  String? profileImage;
  String? id;
  String? email;
  String? lastName;
  String? firstName;

  Participant({
    this.profileImage,
    this.id,
    this.email,
    this.lastName,
    this.firstName,
  });

  factory Participant.fromJson(Map<String, dynamic> json) => Participant(
    profileImage: json["profileImage"],
    id: json["_id"],
    email: json["email"],
    lastName: json["lastName"],
    firstName: json["firstName"],
  );

  Map<String, dynamic> toJson() => {
    // "profileImage": profileImage?.toJson(),
    "profileImage": profileImage,
    "_id": id,
    "email": email,
    "lastName": lastName,
    "firstName": firstName,
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
