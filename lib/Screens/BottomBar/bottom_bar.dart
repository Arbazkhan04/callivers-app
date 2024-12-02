
import 'package:calliverse/Constants/paths.dart';
import 'package:calliverse/Screens/MessageScreen/message_screen.dart';
import 'package:calliverse/Screens/ProfileScreen/profile_screen.dart';
import 'package:calliverse/utils/app_common.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Constants/color.dart';
import '../../Constants/textStyle.dart';
import '../../Provider/bottom_bar_provider.dart';
import '../AiChatBot/ai_chatbot_screen.dart';
import '../Calls/calls_screen.dart';
import '../MeetingScreen/meeting_screen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  void initState() {
    // loadData();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final provider = Provider.of<BottomBarProvider>(context,listen: false);
      provider.onItemTap(0);
      print(provider.selectedIndex);
      // initDynamicLinks();
    });

  }

  static const List<Widget> _widgetOptions = <Widget>[
    // Text('Home Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    // Text('Search Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    // Text('Profile Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    MessagesScreen(),
    CallMainScreen(),
    AiChatBotScreen(),
    MeetingsScreen(),
    ProfileScreen(),
    // RecommendedScreen(),
    // ExploreScreen(),
    // NotificationScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomBarProvider>(builder: (context,provider,child){
      return Scaffold(
        body: _widgetOptions.elementAt(provider.selectedIndex),
        bottomNavigationBar: WillPopScope(
          onWillPop: () async {
            if (provider.selectedIndex == 0) {
              return true;
            } else {
              provider.onItemTap(0);
              return false;
            }
          },
          child:
          BottomNavigationBar(
              backgroundColor: whiteColor,

              items:  <BottomNavigationBarItem>[
                ///Home
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child:  cachedImage(messageIcon,width: 30,color: provider.selectedIndex==0? mainColor : otherColor,),
                  ),
                  label: 'Message',
                  backgroundColor: Colors.white,
                ),
                ///Call
                BottomNavigationBarItem(

                  icon: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child:  cachedImage(callIcon,width: 30,color: provider.selectedIndex==1? mainColor : otherColor,),
                  ),
                  label: 'Calls',
                  backgroundColor: Colors.white,
                ),
                ///Ai
                BottomNavigationBarItem(

                  icon: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child:  cachedImage(aiIcon,width: 35,),
                  ),
                  label: 'AI',
                  backgroundColor: Colors.white,
                ),
                ///Meetings
                BottomNavigationBarItem(

                  icon: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child:  cachedImage(meetingIcon,width: 30,color: provider.selectedIndex==3? mainColor : otherColor,),
                  ),
                  label: 'Meetings',
                  backgroundColor: Colors.white,
                ),
                ///Profile
                BottomNavigationBarItem(

                  icon: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child:  cachedImage(demoNewMessagePersonImage,width: 30,),
                  ),
                  label: 'Profile',
                  backgroundColor: Colors.white,
                ),
                ///Recommended
                // BottomNavigationBarItem(
                //     icon: Padding(
                //       padding: const EdgeInsets.symmetric(vertical: 5.0),
                //       child: SizedBox(
                //           height: 25,
                //           // width: 20,
                //           child: Image.asset(recomendIcon,height: 25,color: provider.selectedIndex == 1? mainColor : otherColor,)),
                //     ),
                //     label: 'Recommended',
                //     backgroundColor: Colors.white),
                // ///Explore
                // BottomNavigationBarItem(
                //   icon: Padding(
                //     padding: EdgeInsets.symmetric(vertical: 5.0),
                //     child: SizedBox(
                //         height: 25,
                //         // width: 20,
                //         child: Image.asset(searchIcon,height: 25,color: provider.selectedIndex == 2? mainColor : otherColor,)),
                //   ),
                //   label: "Explore",
                //   backgroundColor: Colors.white,
                // ),
                // ///Notification
                // BottomNavigationBarItem(
                //   icon: Padding(
                //     padding: EdgeInsets.symmetric(vertical: 5.0),
                //     child: SizedBox(
                //         height: 20,
                //         // width: 20,
                //         child: Image.asset(notificationIcon,height: 25,color: provider.selectedIndex == 3? mainColor : otherColor,)),
                //   ),
                //   label: "Notification",
                //   backgroundColor: Colors.white,
                // ),
              ],
              type: BottomNavigationBarType.fixed,
              currentIndex: provider.selectedIndex,
              selectedItemColor: mainColor,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              unselectedItemColor: otherColor,
              selectedLabelStyle: txtStyle14AndMainBold,
              unselectedLabelStyle:txtStyle14AndBlack,
              iconSize: 24.0,
              onTap: (int index){
                provider.onItemTap(index);
              },
              elevation: 0),
        ),
      );
    });
  }
}