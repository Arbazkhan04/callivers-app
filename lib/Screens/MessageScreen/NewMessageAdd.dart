import 'package:calliverse/Components/widget_extensions.dart';
import 'package:calliverse/Constants/color.dart';
import 'package:calliverse/Constants/paths.dart';
import 'package:calliverse/Constants/sizedbox.dart';
import 'package:calliverse/Constants/textStyle.dart';
import 'package:calliverse/Screens/MessageScreen/create_new_contact.dart';
import 'package:calliverse/Widgets/appbar.dart';
import 'package:calliverse/utils/app_common.dart';
import 'package:flutter/material.dart';
import '../../../Components/NewContactMessage/new_contact_message.dart';

class NewMessageScreen extends StatelessWidget {
  const NewMessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(title: "New Message"),
      body: SafeArea(
        child: Column(
          children: [
           Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
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
                    const SizedBox(height: 18),
                    ...contacts.map((contact) => Padding(
                      padding: const EdgeInsets.only(bottom: 18),
                      child: ContactListItem(contact: contact),
                    )).toList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}