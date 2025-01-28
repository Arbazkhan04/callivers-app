import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';

import '../Widgets/my_print.dart';
import '../modals/all_user_chats_model.dart';
import '../modals/all_users_model_data.dart';
import '../utils/app_constants.dart';
import 'network_utils.dart';

// Future<LoginResponse> logInApi(request) async {
//   Response response = await buildHttpResponse('login', request: request, method: HttpMethod.POST);
//   if (!response.statusCode.isSuccessful()) {
//     if (response.body.isJson()) {
//       var json = jsonDecode(response.body);
//
//       if (json.containsKey('code') && json['code'].toString().contains('invalid_username')) {
//         throw 'invalid_username';
//       }
//     }
//   }
//
//   return await handleResponse(response).then((value) async {
//     LoginResponse loginResponse = LoginResponse.fromJson(value);
//     UserModel? userResponse = loginResponse.data;
//
//     saveUserData(userResponse);
//     await userStore.setLogin(true);
//     return loginResponse;
//   });
// }

// Future<void> saveUserData(UserModel? userModel) async {
//   if (userModel!.apiToken.validate().isNotEmpty) await userStore.setToken(userModel.apiToken.validate());
//   setValue(IS_SOCIAL, false);
//
//   await userStore.setToken(userModel.apiToken.validate());
//   await userStore.setUserID(userModel.id.validate());
//   await userStore.setUserEmail(userModel.email.validate());
//   await userStore.setFirstName(userModel.firstName.validate());
//   await userStore.setLastName(userModel.lastName.validate());
//   await userStore.setUsername(userModel.username.validate());
//   await userStore.setUserImage(userModel.profileImage.validate());
//   await userStore.setDisplayName(userModel.displayName.validate());
//   await userStore.setPhoneNo(userModel.phoneNumber.validate());
//   await userStore.setGender(userModel.gender.validate());
//   await userStore.setSubscribe(userModel.isSubscribe.validate());
// }



Future examplePostApi({required Map<String, dynamic> req}) async {
  return await (buildHttpResponse('user/friend/request/send/cancel', request: req, method: HttpMethod.POST).then((value){
    // myPrint("cancelSendFriendRequestPostApi ${value.statusCode} ----> ${value.body} ----> ${jsonDecode(value.body)}");
    return value.body;
  }));
}

Future exampleGetApi({page,name}) async {
  // return AllFriendRequestModalClass.fromJson(await handleResponse(await (buildHttpResponse(name != null && name.toString().isNotEmpty? 'friends/requests?username=$name' : 'friends/requests?page=$page', method: HttpMethod.GET))));
}
Future registerApi({required Map<String, dynamic> req}) async {
  return await buildHttpResponse('userManagementRoutes/createUser', request: req, method: HttpMethod.POST,isChooseSimpleHeader: true).then((value){
    myPrint("createAccountPostApi ${value.statusCode} ----> ${value.body} ----> ${jsonDecode(value.body)}");
    return value.body;
  });
}
Future loginApi({required Map<String, dynamic> req}) async {
  return await buildHttpResponse('userManagementRoutes/login', request: req, method: HttpMethod.POST,isChooseSimpleHeader: true).then((value){
    myPrint("loginApi ${value.statusCode} ----> ${value.body} ----> ${jsonDecode(value.body)}");
    return value.body;
  });
}


Future otpVerifiedApi({required Map<String, dynamic> req}) async {
  return await buildHttpResponse('userManagementRoutes/verifyEmailCode', request: req, method: HttpMethod.POST,isChooseSimpleHeader: true).then((value){
    myPrint("otpVerifiedApi ${value.statusCode} ----> ${value.body} ----> ${jsonDecode(value.body)}");
    return value.body;
  });
}

Future resendOtpApi({required Map<String, dynamic> req}) async {
  return await buildHttpResponse('userManagementRoutes/resendVerificationCode', request: req, method: HttpMethod.POST,isChooseSimpleHeader: true).then((value){
    myPrint("resendOtpApi ${value.statusCode} ----> ${value.body} ----> ${jsonDecode(value.body)}");
    return value.body;
  });
}

Future profileSetupApi({required Map<String, String> req,userId,
  File? image
}) async {
  return await buildHttpResponse('userManagementRoutes/update-profile/$userId', fields: req,
      file: image,
      method: HttpMethod.PATCH,isChooseSimpleHeader: true).then((value){
    myPrint("profileSetupApi ${value.statusCode} ----> ${value.body} ----> ${jsonDecode(value.body)}");
    return value.body;
  });
}


// Future createAccountPostApi({required Map<String, dynamic> req}) async {
//   return await handleResponse(buildHttpResponse('userManagementRoutes/createUser', request: req, method: HttpMethod.POST,isChooseSimpleHeader: true).then((value){
//     myPrint("createAccountPostApi ${value.statusCode} ----> ${value.body} ----> ${jsonDecode(value.body)}");
//     return value.body;
//   }));
// }

// Future examplePaginationGetApi({userId,page,name}) async {
//   return UserAllFriendsModalClass.fromJson(await handleResponse(await (buildHttpResponse(name != null && name.toString().isNotEmpty?'friends?user_id=$userId&name=$name' :'friends?user_id=$userId&page=$page&name=$name', method: HttpMethod.GET))));
// }

Future userAllChatGetApi({page,userId}) async {
  return AllUserChats.fromJson(await handleResponse(await (buildHttpResponse('chatManagmentRoutes/fetchAllChats/${userId}?page=$page&limit=12', method: HttpMethod.GET))));
}

Future allUsersGetApi({page}) async {
  return AllUsersAllUsersList.fromJson(await handleResponse(await (buildHttpResponse('userManagementRoutes/getAllUsers?page=${page}&limit=12', method: HttpMethod.GET))));
}

//// Create New Contact

Future createNewChatApi({required Map<String, dynamic> req}) async {
  return await buildHttpResponse('chatManagmentRoutes/createChat', request: req, method: HttpMethod.POST,isChooseSimpleHeader: true).then((value){
    myPrint("createNewChatApi ${value.statusCode} ----> ${value.body} ----> ${jsonDecode(value.body)}");
    return value.body;
  });
}
