import 'dart:convert';

import 'package:calliverse/Components/common.dart';
import 'package:calliverse/Constants/DB_keys.dart';
import 'package:calliverse/Provider/authen_provider.dart';
import 'package:calliverse/Widgets/toast.dart';
import 'package:calliverse/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../modals/all_user_chats_model.dart';
import '../modals/all_users_model_data.dart';
import '../network/rest_api.dart';

class ChatProvider extends ChangeNotifier{

  AllUserChats? allUserChats;
  List<Chat> allChat = [];
  List<User> allChatList = [];
  bool isUserChatLoading = false;
  userAllChatFun()async{
    final provider= Provider.of<AuthenProvider>(navigatorKey.currentState!.context,listen: false);
    isUserChatLoading = true;
    allUserChats = null;
    allChatList.clear();
    allChat.clear();

    notifyListeners();
    allUserChats = await userAllChatGetApi(userId: provider.userInfoData?.userId,page: 1);
    // if(allUserChats != null && allUserChats!.data != null && allUserChats!.data!.chats != null && allUserChats!.data!.chats!.isNotEmpty){
    //   allUsersAllUsersModelData = await allUsersGetApi();
    //   if(allUsersAllUsersModelData != null && allUsersAllUsersModelData!.data != null && allUsersAllUsersModelData!.data!.users != null && allUsersAllUsersModelData!.data!.users!.isNotEmpty){
    //   }
    //   allUserChats?.data?.chats?.forEach((e){
    //     if(allUsersAllUsersModelData!.data!.users!.any((element) => e.participants!.any((ele) => ele.email == element.id))){
    //       allUsersAllUsersModelData!.data!.users!.where((element) => e.participants!.any((ele) => ele.email == element.id)).toList();
    //     }
    //     allChat.add(e);
    //   });
    // }
    if (allUserChats != null &&
        allUserChats!.data != null &&
        allUserChats!.data!.chats != null &&
        allUserChats!.data!.chats!.isNotEmpty) {
      //
      // // Fetch all users from the API
      // // allUsersAllUsersModelData = await allUsersGetApi();
      //
      // if (allUsersAllUsersModelData != null &&
      //     allUsersAllUsersModelData!.data != null &&
      //     allUsersAllUsersModelData!.data!.users != null &&
      //     allUsersAllUsersModelData!.data!.users!.isNotEmpty) {
      //
      //   // List to store matched users
      //   List<User> matchedUsers = [];
      //
      //   // Get the list of users for quick lookup
      //   var allUsers = allUsersAllUsersModelData!.data!.users!;
      //
      //   // Iterate through all chats and participants
      //   allUserChats?.data?.chats?.forEach((chat) {
      //     chat.participants?.forEach((participant) {
      //       // Find the matching user where Participant.id == User.id
      //       var matchingUser = allUsers.firstWhere(
      //             (user) => user.id == participant.id,
      //         // orElse: () => null,
      //       );
      //       if (matchingUser != null) {
      //         // Add the matching user to the matched users list
      //         allChatList.add(matchingUser);
      //         notifyListeners();
      //       }
      //     });
      //   });
      //   isUserChatLoading = false;
      //   notifyListeners();
      //   // Print or use the matched users list
      //   print('Matched Users: ${allChatList.length}');
      // }else{
      //   isUserChatLoading = false;
      //   notifyListeners();
      // }
      // Iterate through all chats and participants
      allUserChats?.data?.chats?.forEach((chat) {
        allChat.add(chat);
      });
      isUserChatLoading = false;
      notifyListeners();
      // Print or use the matched users list
      print('Matched Users: ${allChatList.length}');
    }
    else{
      isUserChatLoading = false;
      notifyListeners();
    }

    notifyListeners();
  }


  /////////////////////////////////////////// New Contact Get Users List /////////////////////////////////

  AllUsersAllUsersList? allUsersNewMessageData;
  List<User> allNewMessageUsersList = [];
  bool allNewMessageUsersBool = false;
  allNewChatUsersFun() async {
    allNewMessageUsersBool = true;
    allUsersNewMessageData = null;
    allNewMessageUsersList.clear();
    notifyListeners();
    allUsersNewMessageData = await allUsersGetApi(page: 1);
    if(
    allUsersNewMessageData != null
        &&
    allUsersNewMessageData?.data != null
        &&
    allUsersNewMessageData?.data?.users != null
        &&
    allUsersNewMessageData!.data!.users!.isNotEmpty
    ){
      allUsersNewMessageData!.data!.users?.forEach((e){
        allNewMessageUsersList.add(e);
      });
      allNewMessageUsersBool = false;
      notifyListeners();
    }else{
      allNewMessageUsersBool = false;
      notifyListeners();
    }
    notifyListeners();
  }

  ///////////////////////////////// Create Contact  /////////////////////////////////

  createNewChatFun({otherUserId,myUserId}) async {
    showMyWaitingModal(context: navigatorKey.currentState!.context);
    await createNewChatApi(req: {
      DBkeys.participants : [
        otherUserId,
        myUserId,
      ]
    }).then((e){
      final jsonData = jsonDecode(e);
      if(jsonData["success"] == true && jsonData["message"] == "Chat created successfully."){
        allNewMessageUsersList.removeWhere((ele) => ele.id == otherUserId);
        AppToast.show("Chat created successfully.");
        pop();
        notifyListeners();
      }else{
        pop();
        AppToast.show(jsonData["message"]);
      }
      });
    notifyListeners();
  }

}