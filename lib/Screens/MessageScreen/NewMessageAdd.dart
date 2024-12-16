import 'package:calliverse/Components/widget_extensions.dart';
import 'package:calliverse/Constants/color.dart';
import 'package:calliverse/Constants/paths.dart';
import 'package:calliverse/Constants/sizedbox.dart';
import 'package:calliverse/Constants/textStyle.dart';
import 'package:calliverse/Provider/authen_provider.dart';
import 'package:calliverse/Provider/chat_provider.dart';
import 'package:calliverse/Screens/MessageScreen/create_new_contact.dart';
import 'package:calliverse/Widgets/appbar.dart';
import 'package:calliverse/Widgets/toast.dart';
import 'package:calliverse/utils/app_common.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Components/NewContactMessage/new_contact_message.dart';
import '../../main.dart';

class NewMessageScreen extends StatefulWidget {
  const NewMessageScreen({Key? key}) : super(key: key);

  @override
  State<NewMessageScreen> createState() => _NewMessageScreenState();
}

class _NewMessageScreenState extends State<NewMessageScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      mInit();
    });
  }

  mInit(){
    final provider = Provider.of<ChatProvider>(context,listen: false);
    provider.allNewChatUsersFun();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer2<ChatProvider,AuthenProvider>(
      builder: (context,chatProvider,authProvider,_) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: appBar(title: "New Message"),
          body: SafeArea(
            child: Padding(
              padding: kPaddingHorizontal20,
              child: Column(
                children: [
                  sizeHeight10,
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: mainColor,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: cachedImage(addNewContactIcon,width: 52,
                            height: 52,),
                        ),

                      ),
                      sizeWidth15,
                      Text(
                        'Add New Contact',
                        style: txtStyle14AndBold,
                      ),
                    ],
                  ).onTap((){
                    CreateNewContactScreen().launch(context);
                  }),
                  sizeHeight15,
                  Expanded(
                      child:
                      chatProvider.allNewMessageUsersBool?
                          indicatorMainColor
                      :
                      ListView.separated(
                        shrinkWrap: true,
                      itemCount: chatProvider.allNewMessageUsersList.length,
                      separatorBuilder: (e,i) => divider,
                      itemBuilder: (_,index){
                        final item = chatProvider.allNewMessageUsersList[index];
                    return ContactListItem(contact: item).onTap((){
                      // socket.emit('joinChat', {
                      //   "chatId": item.id,
                      //   "chatType": "one-to-one",
                      // });
                      // // ChatScreenTest(senderId: item.id!,receiverId: authProvider.responseData?.data!.userId ??"",).launch(context);
                      // // ChatScreen(item: messageData[index],).launch(context);
                      // ChatScreen(item: item.participants!.first,senderId: authProvider.userInfoData!.userId!,receiverId: item.participants!.first.id!,).launch(context);
                      chatProvider.createNewChatFun(myUserId: authProvider.userInfoData?.userId,otherUserId: item.id);
                    });
                  })),
                  // ...contacts.map((contact) => Padding(
                  //   padding: const EdgeInsets.only(bottom: 18),
                  //   child: ContactListItem(contact: contact),
                  // )).toList(),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}