import 'package:calliverse/Components/widget_extensions.dart';
import 'package:calliverse/Constants/color.dart';
import 'package:calliverse/Provider/authen_provider.dart';
import 'package:calliverse/Provider/chat_provider.dart';
import 'package:calliverse/Widgets/toast.dart';
import 'package:calliverse/example_test.dart';
import 'package:calliverse/utils/app_common.dart';
import 'package:calliverse/utils/app_images.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Components/Message/message_header.dart';
import '../../Components/Message/message_list.dart';
import '../../Components/Message/message_tile.dart';
import '../../Constants/paths.dart';
import '../../Widgets/button.dart';
import '../../flutter_webrtc_test.dart';
import '../../main.dart';
import '../../socket_io_test.dart';
import '../BottomBar/bottom_bar.dart';
import '../ChatScreen/chat_screen.dart';
import '../home/home.dart';
import 'NewMessageAdd.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((e){
      final provider = Provider.of<ChatProvider>(context,listen: false);
      provider.userAllChatFun();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Consumer2<ChatProvider,AuthenProvider>(
      builder: (context,chatProvider,authProvider,_) {
        // Use post-frame callback for modal logic
        // WidgetsBinding.instance.addPostFrameCallback((_) {
        //   if (chatProvider.isUserChatLoading) {
        //     // Show the waiting modal only after the frame is built
        //     showMyWaitingModal(context: context);
        //   }
        // });
        return Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: Column(
                  children:  [
                    MessageHeader(),
                    TextButton(onPressed: () async {
                      // chatProvider.userAllChatFun();
                      // print("object${chatProvider.allChat.length}");
                      await FirebaseMessaging.instance.getToken().then((e){
                        return print("obasd: ${e}");
                      });
                      // print("object: ${}");
                      // HomeScreen().launch(context);
                      // HomeScreen().launch(context);
                    }, child: Text("s")),
                    Text("${authProvider.userInfoData?.userId}"),
                    Expanded(
                      child:
                      chatProvider.isUserChatLoading?
                          indicatorMainColor
                      :
                      chatProvider.allChat.isEmpty?
                         messageWithImage(messageText: "No chats")
                          :
                      ListView.separated(
                        padding: const EdgeInsets.all(20),
                        itemCount: chatProvider.allChat.length,
                        separatorBuilder: (context, index) => const Divider(
                          height: 24,
                          thickness: 1,
                          color: Color(0xFFEFF0F1),
                        ),
                        itemBuilder: (context, index) {
                          final item = chatProvider.allChat[index];
                          // print("objects -> ${item.participants!.first.profileImage}");
                          return MessageTile(
                            message: item,
                            onTap: (){

                              socket.emit('joinChat', {
                                "chatId": item.id,
                                "chatType": "one-to-one",
                              });
                              // ChatScreenTest(senderId: item.id!,receiverId: authProvider.responseData?.data!.userId ??"",).launch(context);
                              // ChatScreen(item: messageData[index],).launch(context);
                              print("objectDD -> ${item.participants!.first.toJson()}");
                              print("myID -> ${authProvider.userInfoData!.userId}");
                              print("objectD3D -> ${item.participants!.last.toJson()}");
                              ChatScreen(
                                item: item.participants!.where((e) => e.id != authProvider.userInfoData!.userId).first,
                                // senderId: authProvider.userInfoData!.userId!,
                                senderId: item.participants!.where((e) => e.id == authProvider.userInfoData!.userId).first.id ?? "",
                                receiverId: item.participants!.where((e) => e.id != authProvider.userInfoData!.userId).first.id ?? "",
                                chatId: item.id!,
                              ).launch(context);
                            },

                          );}
                      ),
                    ),
                  ],
                ),
              ),
              floatingActionButton: CustomFloatingActionButton(
                onTap: (){NewMessageScreen().launch(context);},
                icon: cachedImage(createChatIcon,width: 25),

              ),
            ),
            // chatProvider.isUserChatLoading == true?
            //     showMyWaitingModal(context: context) : SizedBox(),
          ],
        );
      }
    );
  }
}