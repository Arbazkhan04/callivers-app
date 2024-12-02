import 'package:calliverse/Constants/color.dart';
import 'package:calliverse/Constants/paths.dart';
import 'package:calliverse/utils/app_common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Components/CallMainScreen/call_header.dart';
import '../../Components/CallMainScreen/call_list_items.dart';
import '../../Widgets/button.dart';

class CallMainScreen extends StatelessWidget {
  const CallMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: CustomFloatingActionButton(onTap: () {},icon: cachedImage(addCallIcon,width: 24,color: whiteColor,),),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CallHeader(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children:  [
                  CallListItem(
                    name: "Pranav Ray",
                    imageUrl: "https://cdn.builder.io/api/v1/image/assets/TEMP/d4c9f3de9839e42d1a6bb784392eaff5c5b801856125f2411e2f76ca5de8987a?placeholderIfAbsent=true&apiKey=868dfe7ca9874e83907b13f575a31561",
                    timeAgo: "15 min Ago",
                  ),
                  CallListItem(
                    name: "Lindsey George",
                    imageUrl: "https://cdn.builder.io/api/v1/image/assets/TEMP/32d84a0716fe33e90075bcc5efab37e050925e3be492b3bd95fc9dc7ad639088?placeholderIfAbsent=true&apiKey=868dfe7ca9874e83907b13f575a31561",
                    timeAgo: "15 min Ago",
                  ),
                  CallListItem(
                    name: "Wilson Botosh",
                    imageUrl: "https://cdn.builder.io/api/v1/image/assets/TEMP/69d5440e5c795e70d8111ba6aa9af558d10f303577918e134a6ab0a63e73aff5?placeholderIfAbsent=true&apiKey=868dfe7ca9874e83907b13f575a31561",
                    timeAgo: "15 min Ago",
                  ),
                  CallListItem(
                    name: "Phillip Dorwart",
                    imageUrl: "https://cdn.builder.io/api/v1/image/assets/TEMP/c6021eeab5b781dc642ee13b24bb666c877bc76b30e9f88890896073a3db7e1b?placeholderIfAbsent=true&apiKey=868dfe7ca9874e83907b13f575a31561",
                    timeAgo: "15 min Ago",
                  ),
                  CallListItem(
                    name: "Zaire Vaccaro",
                    imageUrl: "https://cdn.builder.io/api/v1/image/assets/TEMP/01170894e01f72fe15b9f6fb71346a94d1bd830cc5a98ac020d0798f966a18b7?placeholderIfAbsent=true&apiKey=868dfe7ca9874e83907b13f575a31561",
                    timeAgo: "15 min Ago",
                  ),
                  CallListItem(
                    name: "Mira Schleifer",
                    imageUrl: "https://cdn.builder.io/api/v1/image/assets/TEMP/2a5af68470d121e8d75cb03cdc26ad94ad5dc3aca1d728980b44c57177cc9bfc?placeholderIfAbsent=true&apiKey=868dfe7ca9874e83907b13f575a31561",
                    timeAgo: "15 min Ago",
                  ),
                  CallListItem(
                    name: "Jocelyn Carder",
                    imageUrl: "https://cdn.builder.io/api/v1/image/assets/TEMP/0d40893feafb8698ee2003dec7f29e36f9b13f5d0736aeee5f66e081e65f5d26?placeholderIfAbsent=true&apiKey=868dfe7ca9874e83907b13f575a31561",
                    timeAgo: "15 min Ago",
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}