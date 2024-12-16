import 'package:calliverse/Provider/bottom_bar_provider.dart';
import 'package:calliverse/Provider/chat_provider.dart';
import 'package:calliverse/socket_io_test.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Constants/color.dart';
import 'Provider/authen_provider.dart';
import 'Provider/image_picker_provider.dart';
import 'Provider/profile_provider.dart';
import 'Screens/AuthScreen/welcome_screen.dart';
import 'Screens/SplashScreen/splash_screen.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
late IO.Socket socket;

void emitEventWithCallback(String eventName, dynamic data, Function callback) {
  // Emit an event with a callback
  socket.emitWithAck(eventName, data, ack: (response) {
    callback(response);
  });
}


SharedPreferences pref = SharedPreferences.getInstance() as SharedPreferences;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  socket = IO.io('http://192.168.0.104:3003', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': true,
  });
  socket.connect();
  socket.onConnect((_) {
    print('Connected to socket');
    // emitEventWithCallback(
    //   'getAllChatMessages', {
    //   "chatId": "675d7466bef3490642f6c863",
    //   "page": 1,
    //   "limit": 10,
    // },
    //       (response) {
    //     if (response != null && response['success']) {
    //       List<dynamic> data = response['data'];
    //       // Process the fetched messages
    //       // setState(() {
    //       //   messages = data.map((msg) => Message.fromJson(msg)).toList();
    //       // });
    //       print("dataC -> ${data.length}");
    //       print('Messages fetched successfully.');
    //     } else {
    //       print('Failed to fetch messages: ${response?['error']}');
    //     }
    //   },
    // );
  });

  socket.onConnectError((error) {
    print('Connection Error: $error');
  });

  socket.onError((error) {
    print('Error: $error');
  });

  pref = await SharedPreferences.getInstance();

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<BottomBarProvider>(
          create: (_) => BottomBarProvider(),
        ),
        ChangeNotifierProvider<ProfileProvider>(
          create: (_) => ProfileProvider(),
        ),
        ChangeNotifierProvider<AuthenProvider>(
          create: (_) => AuthenProvider(),
        ),
        ChangeNotifierProvider<ImagePickerProvider>(
          create: (_) => ImagePickerProvider(),
        ),
        ChangeNotifierProvider<ChatProvider>(
          create: (_) => ChatProvider(),
        ),
      ],
      child: const MyApp()));
}
final navigatorKey = GlobalKey<NavigatorState>();
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calliverse',
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.mulish().fontFamily,
        // primarySwatch: mainColor,
        primaryColor: mainColor,
        primaryColorLight: mainColor,
        primaryColorDark: mainColor,
        textTheme: TextTheme(
          displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.bold, color: textColor),
          displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.w600, color: textColor),
          displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.w500, color: textColor),
          headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w500, color: textColor),
          headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w400, color: textColor),
          headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w300, color: textColor),
          titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: mainColor),
          titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: mainColor),
          titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: mainColor),
          bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: otherColor),
          bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: otherColor),
          bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: otherColor),
          labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: mainColor),
          labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: mainColor),
          labelSmall: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: mainColor),
        ),
      ),
      home: SplashScreen(),
      // ChatScreen(senderId: "675b24d999f7d757d11d667d",receiverId: "675b308299f7d757d11d6684",),
    );
  }
}


