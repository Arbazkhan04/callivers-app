import 'dart:convert';
import 'package:http/http.dart';

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



Future examplePostApi({required Map req}) async {
  return await (buildHttpResponse('user/friend/request/send/cancel', request: req, method: HttpMethod.POST).then((value){
    // myPrint("cancelSendFriendRequestPostApi ${value.statusCode} ----> ${value.body} ----> ${jsonDecode(value.body)}");
    return value.body;
  }));
}

Future exampleGetApi({page,name}) async {
  // return AllFriendRequestModalClass.fromJson(await handleResponse(await (buildHttpResponse(name != null && name.toString().isNotEmpty? 'friends/requests?username=$name' : 'friends/requests?page=$page', method: HttpMethod.GET))));
}

Future confirmFriendRequestPostApi({required Map req}) async {
  return await (buildHttpResponse('friends/confirm', request: req, method: HttpMethod.POST).then((value){
    // myPrint("confirmFriendRequestPostApi ${value.statusCode} ----> ${value.body} ----> ${jsonDecode(value.body)}");
    return value.body;
  }));
}

// Future examplePaginationGetApi({userId,page,name}) async {
//   return UserAllFriendsModalClass.fromJson(await handleResponse(await (buildHttpResponse(name != null && name.toString().isNotEmpty?'friends?user_id=$userId&name=$name' :'friends?user_id=$userId&page=$page&name=$name', method: HttpMethod.GET))));
// }

