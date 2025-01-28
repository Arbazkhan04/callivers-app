// import 'package:calliverse/Constants/color.dart';
// import 'package:calliverse/Widgets/button.dart';
// import 'package:flutter/material.dart';
//
// import '../../Components/ChatComponents/chat_header.dart';
// import '../../Components/ChatComponents/chat_input.dart';
// import '../../Components/ChatComponents/chat_message.dart';
// import '../../Components/ChatComponents/date_divider.dart';
// import '../../Components/ChatComponents/message_bubble.dart';
// import '../../Components/Message/message_list.dart';
// import '../../Constants/paths.dart';
// import '../../main.dart';
// import '../../modals/all_user_chats_model.dart';
//
// class ChatScreen extends StatefulWidget {
//   final Participant item;
//   final String senderId;
//   final String chatId;
//   final String receiverId;
//   ChatScreen({
//     Key? key,
//     required this.item,
//     required this.senderId,
//     required this.receiverId,
//     required this.chatId,
//   }) : super(key: key);
//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }
// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController controller = TextEditingController();
//   List<Map<String, dynamic>> messages = [];
//   void fetchMessages() {
//     socket.emitWithAck('getAllChatMessages', {
//       "chatId": widget.chatId,
//       "page": 1,
//       "limit": 10,
//     }, ack: (response) {
//       if (response != null && response['success']) {
//         Map<String, dynamic> data = response['data'];
//         // Process the fetched messages
//         // setState(() {
//         //   messages = data.map((msg) => Message.fromJson(msg)).toList();
//         // });
//         print("dataC -> ${data.length}");
//         print('Messages fetched successfully.');
//       } else {
//         print('Failed to fetch messages: ${response?['error']}');
//       }
//     },binary: false);
//   }
//
//   void sendMessage() {
//     if (controller.text.isNotEmpty) {
//       socket.emit('sendMessage', {
//         'chatId': widget.chatId,
//         'senderId': widget.senderId,
//         'receiverId': widget.receiverId,
//         'messageType': "text",
//         'content': controller.text,
//         'files': [],
//       });
//       controller.clear();
//     }
//   }
//
//   @override
//   void dispose() {
//     // socket.disconnect();
//     // socket.dispose();
//     // _controller.dispose();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFF7F7FC),
//       body: SafeArea(
//         child: Column(
//           children: [
//             ChatHeader(item: widget.item,),
//             Expanded(
//               // child: ChatMessages(),
//               child: ListView(
//                 padding: EdgeInsets.symmetric(vertical: 12),
//                 children: [
//                   MessageBubble(
//                     message: 'Look at how chocho sleep in my arms!',
//                     time: '16.46',
//                     isMe: false,
//                     hasImage: true,
//                     imageUrl: demoChatImage,
//                   ),
//                   MessageBubble(
//                     message: 'Of course, let me know if you\'re on your way',
//                     time: '16.46',
//                     isMe: false,
//                     quotedMessage: 'Can I come over?',
//                   ),
//                   MessageBubble(
//                     message: 'K, I\'m on my way',
//                     time: '16.50',
//                     isMe: true,
//                     isRead: true,
//                   ),
//                   DateDivider(date: 'Sat, 17/10'),
//                   MessageBubble(
//                     message: '',
//                     time: '09.13',
//                     isMe: true,
//                     isRead: true,
//                     hasVoiceMessage: true,
//                     voiceDuration: '0:20',
//                   ),
//                   MessageBubble(
//                     message: 'Good morning, did you sleep well?',
//                     time: '09.45',
//                     isMe: false,
//                   ),
//                 ],
//               ),
//             ),
//             // ChatInput(),
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(color: Color(0xFFEDEDED)),
//               ),
//               padding: EdgeInsets.symmetric(vertical: 14, horizontal: 6),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Color(0xFFF4F4F4),
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                       padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
//                       child: Row(
//                         children: [
//                           IconButton(
//                             icon: Icon(Icons.emoji_emotions_outlined),
//                             onPressed: () {},
//                             // semanticLabel: 'Choose emoji',
//                           ),
//                           Expanded(
//                             child: TextField(
//                               controller: controller,
//                               decoration: InputDecoration(
//                                 hintText: 'Type your message...',
//                                 border: InputBorder.none,
//                                 hintStyle: TextStyle(
//                                   color: Color(0xFF7D818B),
//                                   fontFamily: 'Mulish',
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           IconButton(
//                             icon: Icon(Icons.attach_file),
//                             onPressed: () {},
//                             // semanticLabel: 'Attach file',
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   // SizedBox(width: 6),
//                   SizedBox(
//                     width: 65,
//                     height: 65,
//                     child: CustomIconButton(
//                       onPressed: sendMessage,
//
//                       icon: CircleAvatar(
//                           backgroundColor: mainColor,
//                           radius: 30,
//                           child: Icon(Icons.send,color: whiteColor,)),
//                       backgroundColor: Theme.of(context).primaryColor,
//                       // mini: true,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// lib/screens/chat_screen.dart

// lib/screens/chat_screen.dart

import 'package:flutter/foundation.dart' as foundation;
import 'dart:async';
import 'package:calliverse/Constants/sizedbox.dart';
import 'package:calliverse/Widgets/toast.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:calliverse/Constants/color.dart';
import 'package:calliverse/Widgets/button.dart';
import 'package:socket_io_client/socket_io_client.dart';
// import '../../services/streamsocket.dart';
import '../../Components/ChatComponents/chat_header.dart';
import '../../Components/ChatComponents/message_bubble.dart';
import '../../Components/ChatComponents/date_divider.dart';
import '../../main.dart';
import '../../modals/all_user_chats_model.dart';


// class CalliverseSocketManager {
//   late IO.Socket socket;
//   final String userId;
//
//   // StreamController to broadcast incoming messages
//   final StreamController<Map<String, dynamic>> _messageStreamController = StreamController<Map<String, dynamic>>.broadcast();
//
//   CalliverseSocketManager({required this.userId});
//
//   /// Initialize the socket connection
//   void initializeSocket() {
//     socket = IO.io(
//       'http://192.168.0.100:3003', // Correct URL
//       IO.OptionBuilder()
//           .setTransports(['websocket'])
//           .enableAutoConnect()
//           .build(),
//     );
//
//     // Handle connection
//     socket.onConnect((_) {
//       debugPrint('Socket connected');
//       userOnline();
//     });
//
//     // Handle disconnection
//     socket.onDisconnect((_) {
//       debugPrint('Socket disconnected');
//     });
//
//     // Listen for 'receiveMessage' event
//     socket.on('receiveMessage', (data) {
//       debugPrint('New message received: $data');
//       onMessageReceived(data);
//     });
//
//     // Handle errors
//     socket.onError((error) {
//       debugPrint('Socket error: $error');
//     });
//   }
//
//   /// Expose the message stream
//   Stream<Map<String, dynamic>> get messageStream => _messageStreamController.stream;
//
//   /// Notify the server that a user is online
//   void userOnline() {
//     socket.emit('userOnline', {'userId': userId});
//     debugPrint('User online event emitted for userId: $userId');
//   }
//
//   /// Join a specific chat room
//   void joinChat(String chatId, String chatType) {
//     socket.emit('joinChat', {
//       'chatId': chatId,
//       'chatType': chatType,
//     });
//     debugPrint('Join chat event emitted for chatId: $chatId, chatType: $chatType');
//   }
//
//   /// Send a message to another user
//   void sendMessage({
//     required String chatId,
//     required String senderId,
//     required String receiverId,
//     required String messageType,
//     required String content,
//     List<dynamic> files = const [],
//   }) {
//     socket.emit('sendMessage', {
//       'chatId': chatId,
//       'senderId': senderId,
//       'receiverId': receiverId,
//       'messageType': messageType,
//       'content': content,
//       'files': files,
//     });
//     debugPrint('Send message event emitted: $content');
//   }
//
//   /// Handle the receipt of a message and emit acknowledgment
//   void onMessageReceived(dynamic data) {
//     debugPrint('Message received: $data');
//     if (data != null && data['chatId'] != null && data['messageId'] != null) {
//       socket.emit('messageReceived', {
//         'chatId': data['chatId'],
//         'messageId': data['messageId'],
//       });
//       debugPrint('Message acknowledgment sent for messageId: ${data['messageId']}');
//
//       // Add the message to the stream
//       _messageStreamController.add(Map<String, dynamic>.from(data));
//     } else {
//       debugPrint('Invalid message data received');
//     }
//   }
//
//   /// Retrieve all chat messages with pagination
//   Future<Map<String, dynamic>> getAllChatMessages({
//     required String chatId,
//     required int page,
//     required int limit,
//   }) {
//     Completer<Map<String, dynamic>> completer = Completer<Map<String, dynamic>>();
//
//     socket.emitWithAck('getAllChatMessages', {
//       'chatId': chatId,
//       'page': page,
//       'limit': limit,
//     }, ack: (response) {
//       debugPrint('Received getAllChatMessages response: $response'); // Enhanced debug statement
//
//       if (response != null) {
//         if (response['success'] == true && response['data'] != null) {
//           if (response['data']['messages'] is List) {
//             completer.complete(Map<String, dynamic>.from(response['data']));
//           } else {
//             completer.completeError('Invalid messages format.');
//           }
//         } else {
//           completer.completeError(response['error'] ?? 'Unknown error');
//         }
//       } else {
//         completer.completeError('No response from server.');
//       }
//     });
//
//     // Implement a timeout to prevent indefinite waiting
//     Timer(Duration(seconds: 10), () {
//       if (!completer.isCompleted) {
//         completer.completeError('Request timed out');
//       }
//     });
//
//     return completer.future;
//   }
//
//   /// Disconnect the socket connection
//   void disconnectSocket() {
//     socket.disconnect();
//     _messageStreamController.close();
//     debugPrint('Socket disconnected manually');
//   }
// }

// class ChatScreen extends StatefulWidget {
//   final Participant item;
//   final String senderId;
//   final String chatId;
//   final String receiverId;
//
//   ChatScreen({
//     Key? key,
//     required this.item,
//     required this.senderId,
//     required this.receiverId,
//     required this.chatId,
//   }) : super(key: key);
//
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   late CalliverseSocketManager socketManager;
//   List<Map<String, dynamic>> messages = []; // List to store messages
//   final int limit = 10;
//   int currentPage = 1;
//   bool isLoading = false;
//   bool hasMore = true;
//
//   final TextEditingController controller = TextEditingController();
//   final ScrollController _scrollController = ScrollController();
//   bool _showScrollButton = false;
//   bool _emojiShowing = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(_scrollListener);
//
//     // Initialize the socket manager
//     socketManager = CalliverseSocketManager(userId: widget.senderId);
//     socketManager.initializeSocket();
//
//     // Join the chat room
//     socketManager.joinChat(widget.chatId, "one-to-one");
//
//     // Listen for new messages via the message stream
//     socketManager.messageStream.listen((data) {
//       onNewMessageReceived(data);
//     });
//
//     // Fetch initial messages
//     fetchMessages();
//   }
//
//   /// Fetch paginated messages
//   void fetchMessages() async {
//     if (isLoading || !hasMore) return;
//
//     setState(() {
//       isLoading = true;
//     });
//
//     try {
//       final data = await socketManager.getAllChatMessages(
//         chatId: widget.chatId,
//         page: currentPage,
//         limit: limit,
//       );
//
//       setState(() {
//         List<dynamic> fetchedMessages = data['messages'] ?? []; // Provide default empty list
//         messages.addAll(fetchedMessages.map((msg) => _formatMessage(msg)).toList());
//         currentPage++;
//         hasMore = currentPage <= (data['totalPages'] ?? 0); // Handle null totalPages
//         isLoading = false;
//       });
//
//       // Scroll to bottom after initial load
//       if (currentPage == 2) {
//         _scrollToBottom();
//       }
//     } catch (error) {
//       setState(() {
//         isLoading = false;
//       });
//       debugPrint('Error fetching messages: $error');
//     }
//   }
//
//   /// Format message data
//   Map<String, dynamic> _formatMessage(dynamic msg) {
//     return {
//       'message': msg['content'] ?? '',
//       'senderId': msg['senderId'] ?? '',
//       'isMe': msg['senderId'] == widget.senderId,
//       'time': msg['createdAt'] ?? DateTime.now().toIso8601String(),
//       'messageType': msg['messageType'] ?? 'text',
//     };
//   }
//
//   /// Handle new message received
//   void onNewMessageReceived(dynamic data) {
//     setState(() {
//       messages.insert(0, _formatMessage(data));
//     });
//     _scrollToBottom();
//   }
//
//   @override
//   void dispose() {
//     socketManager.disconnectSocket();
//     _scrollController.removeListener(_scrollListener);
//     _scrollController.dispose();
//     controller.dispose();
//     super.dispose();
//   }
//
//   /// Send a message
//   void sendMessage() {
//     if (controller.text.trim().isEmpty) return;
//
//     String messageContent = controller.text.trim();
//
//     Map<String, dynamic> messageData = {
//       'chatId': widget.chatId,
//       'senderId': widget.senderId,
//       'receiverId': widget.receiverId,
//       'messageType': 'text',
//       'content': messageContent,
//       'files': [],
//     };
//
//     // Send the message via socket manager
//     socketManager.sendMessage(
//       chatId: widget.chatId,
//       senderId: widget.senderId,
//       receiverId: widget.receiverId,
//       messageType: 'text',
//       content: messageContent,
//       files: [],
//     );
//
//     // Add the message to the list
//     setState(() {
//       messages.add({
//         'message': messageContent,
//         'senderId': widget.senderId,
//         'isMe': true,
//         'time': DateTime.now().toIso8601String(),
//         'messageType': 'text',
//       });
//     });
//
//     _scrollToBottom();
//
//     controller.clear();
//   }
//
//   /// Scroll listener to show/hide scroll button
//   void _scrollListener() {
//     if (_scrollController.offset > 1000) {
//       if (!_showScrollButton) {
//         setState(() {
//           _showScrollButton = true;
//         });
//       }
//     } else {
//       if (_showScrollButton) {
//         setState(() {
//           _showScrollButton = false;
//         });
//       }
//     }
//   }
//
//   /// Scroll to bottom of the chat
//   void _scrollToBottom() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (_scrollController.hasClients) {
//         _scrollController.animateTo(
//           _scrollController.position.minScrollExtent,
//           duration: Duration(milliseconds: 300),
//           curve: Curves.easeOut,
//         );
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // Optional: Add AppBar or other UI components
//       body: Column(
//         children: [
//           sizeStatusBar(context: context),
//           ChatHeader(item: widget.item),
//           Expanded(
//             child: isLoading && messages.isEmpty
//                 ? Center(child: CircularProgressIndicator()) // Replace with your indicator
//                 : ListView.builder(
//               reverse: true, // Show the newest messages at the bottom
//               controller: _scrollController,
//               itemCount: messages.length,
//               itemBuilder: (context, index) {
//                 final message = messages[index];
//                 return MessageBubble(
//                   message: message["message"],
//                   time: message["time"], // Use actual time
//                   isMe: message["isMe"],
//                   // Add other properties as needed
//                 );
//               },
//             ),
//           ),
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               border: Border.all(color: Color(0xFFEDEDED)),
//             ),
//             padding: EdgeInsets.symmetric(vertical: 14, horizontal: 6),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Color(0xFFF4F4F4),
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
//                     child: Row(
//                       children: [
//                         IconButton(
//                           icon: Icon(Icons.emoji_emotions_outlined, color: _emojiShowing ? Colors.blue : Colors.grey,),
//                           onPressed: () {
//                             setState(() {
//                               _emojiShowing = !_emojiShowing;
//                             });
//                           },
//                           // semanticLabel: 'Choose emoji',
//                         ),
//                         Expanded(
//                           child: TextField(
//                             controller: controller,
//                             decoration: InputDecoration(
//                               hintText: 'Type your message...',
//                               border: InputBorder.none,
//                               hintStyle: TextStyle(
//                                 color: Color(0xFF7D818B),
//                                 fontFamily: 'Mulish',
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.attach_file, color: Colors.grey,),
//                           onPressed: () {},
//                           // semanticLabel: 'Attach file',
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 65,
//                   height: 65,
//                   child: CustomIconButton(
//                     onPressed: sendMessage,
//                     icon: CircleAvatar(
//                       backgroundColor: Colors.blue,
//                       radius: 30,
//                       child: Icon(Icons.send, color: Colors.white,),
//                     ),
//                     backgroundColor: Colors.blue,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Offstage(
//             offstage: !_emojiShowing,
//             child: EmojiPicker(
//               textEditingController: controller,
//               scrollController: _scrollController,
//               config: Config(
//                 height: 256,
//                 checkPlatformCompatibility: true,
//                 emojiViewConfig: EmojiViewConfig(
//                   emojiSizeMax: 28 * (defaultTargetPlatform == TargetPlatform.iOS ? 1.2 : 1.0),
//                 ),
//                 skinToneConfig: const SkinToneConfig(),
//                 categoryViewConfig: const CategoryViewConfig(),
//                 bottomActionBarConfig: const BottomActionBarConfig(),
//                 searchViewConfig: const SearchViewConfig(),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// chat_screen.dart
// socket_manager.dart
// import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:async';
import 'package:flutter/material.dart';

class CalliverseSocketManager {
  // Private constructor
  CalliverseSocketManager._privateConstructor();

  // Singleton instance
  static final CalliverseSocketManager _instance = CalliverseSocketManager._privateConstructor();

  // Factory constructor
  factory CalliverseSocketManager() {
    return _instance;
  }


  String? _userId;
  final StreamController<Map<String, dynamic>> _messageStreamController = StreamController<Map<String, dynamic>>.broadcast();

  /// Initialize the socket connection with the given userId
  Future<void> initializeSocket({required String userId}) async {
    if (_userId == userId && socket.connected) {
      debugPrint('Socket already connected with same userId: $userId');
      return;
    }

    // If socket was previously connected, disconnect and recreate
    if (socket != null && socket.connected) {
      socket.disconnect();
      debugPrint('Disconnecting existing socket instance');
    }

    _userId = userId;



    // Handle connection
    socket.onConnect((_) {
      debugPrint('Socket connected');
      _emitUserOnline();
    });

    // Handle disconnection
    socket.onDisconnect((_) {
      debugPrint('Socket disconnected');
    });

    // Listen for 'receiveMessage' event
    socket.on('receiveMessage', (data) {
      debugPrint('New message received: $data');

      // Check if data is a list and if the first element is the actual message map
      if (data is List && data.isNotEmpty && data[0] is Map<String, dynamic>) {
        _handleIncomingMessage(data[0]);
      } else {
        debugPrint('Received invalid message format in receiveMessage event');
      }
    });

    // socket.on('receiveMessage', (data) {
    //   debugPrint('New message received: $data');
    //   _handleIncomingMessage(data);
    // });

    // Handle errors
    socket.onError((error) {
      debugPrint('Socket error: $error');
    });

    // Connect the socket
    socket.connect();
  }

  /// Expose the message stream
  Stream<Map<String, dynamic>> get messageStream => _messageStreamController.stream;

  /// Emit 'userOnline' event
  void _emitUserOnline() {
    if (_userId == null) {
      debugPrint('User ID is not set');
      return;
    }
    socket.emit('userOnline', {'userId': _userId});
    debugPrint('Emitted userOnline for userId: $_userId');
  }

  /// Join a specific chat room
  void joinChat(String chatId, String chatType) {
    socket.emit('joinChat', {
      'chatId': chatId,
      'chatType': chatType,
    });
    debugPrint('Joined chat room: $chatId of type: $chatType');
  }

  /// Send a message to another user
  void sendMessage({
    required String chatId,
    required String senderId,
    required String receiverId,
    required String messageType,
    required String content,
    List<dynamic> files = const [],
  }) {
    socket.emit('sendMessage', {
      'chatId': chatId,
      'senderId': senderId,
      'receiverId': receiverId,
      'messageType': messageType,
      'content': content,
      'files': files,
    });
    debugPrint('Sent message: $content');
  }

  /// Handle incoming messages
  // void _handleIncomingMessage(dynamic data) {
  //   debugPrint('Handling incoming message: $data');
  //   if (data is Map<String, dynamic>) {
  //     // Emit acknowledgment if necessary
  //     if (data.containsKey('chatId') && data.containsKey('messageId')) {
  //       socket.emit('messageReceived', {
  //         'chatId': data['chatId'],
  //         'messageId': data['messageId'],
  //       });
  //       debugPrint('Acknowledged messageId: ${data['messageId']} in chatId: ${data['chatId']}');
  //     }
  //     // Add the message to the stream
  //     _messageStreamController.add(Map<String, dynamic>.from(data));
  //     debugPrint('Message added to stream');
  //   } else {
  //     debugPrint('Received invalid message format');
  //   }
  // }
  void _handleIncomingMessage(dynamic data) {
    debugPrint('Handling incoming message: $data');
    if (data is Map<String, dynamic>) {
      // Your existing logic remains the same
      if (data.containsKey('chatId') && data.containsKey('messageId')) {
        socket.emit('messageReceived', {
          'chatId': data['chatId'],
          'messageId': data['messageId'],
        });
        debugPrint('Acknowledged messageId: ${data['messageId']} in chatId: ${data['chatId']}');
      }
      _messageStreamController.add(Map<String, dynamic>.from(data));
      debugPrint('Message added to stream');
    } else {
      debugPrint('Received invalid message format');
    }
  }

  /// Retrieve all chat messages with pagination
  Future<Map<String, dynamic>> getAllChatMessages({
    required String chatId,
    required int page,
    required int limit,
  }) {
    Completer<Map<String, dynamic>> completer = Completer<Map<String, dynamic>>();

    socket.emitWithAck('getAllChatMessages', {
      'chatId': chatId,
      'page': page,
      'limit': limit,
    }, ack: (response) {
      debugPrint('Received getAllChatMessages response: $response');

      if (response != null) {
        if (response['success'] == true && response['data'] != null) {
          if (response['data']['messages'] is List) {
            completer.complete(Map<String, dynamic>.from(response['data']));
          } else {
            completer.completeError('Invalid messages format.');
          }
        } else {
          completer.completeError(response['error'] ?? 'Unknown error');
        }
      } else {
        completer.completeError('No response from server.');
      }
    });

    // Implement a timeout to prevent indefinite waiting
    Timer(Duration(seconds: 10), () {
      if (!completer.isCompleted) {
        completer.completeError('Request timed out');
      }
    });

    return completer.future;
  }

  /// Disconnect the socket connection
  void disconnectSocket() {
    if (socket.connected) {
      socket.disconnect();
      debugPrint('Socket disconnected manually');
    }
    _messageStreamController.close();
  }
}


class ChatScreen extends StatefulWidget {
  final Participant item;
  final String senderId;
  final String chatId;
  final String receiverId;

  ChatScreen({
    Key? key,
    required this.item,
    required this.senderId,
    required this.receiverId,
    required this.chatId,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final CalliverseSocketManager socketManager = CalliverseSocketManager();
  List<Map<String, dynamic>> _messages = []; // List to store messages
  final int _limit = 10;
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _showScrollButton = false;
  bool _emojiShowing = false;

  bool _isSocketConnected = false;
  StreamSubscription<Map<String, dynamic>>? _messageSubscription;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _initializeSocketAndChat();
  }

  Future<void> _initializeSocketAndChat() async {
    try {
      // Ensure the socket is fully initialized and connected before proceeding
      await socketManager.initializeSocket(userId: widget.senderId);

      // Join the chat room after socket connection is established
      socketManager.joinChat(widget.chatId, "one-to-one");

      // Listen for new messages via the message stream
      _messageSubscription = socketManager.messageStream.listen((data) {
        _onNewMessageReceived(data);
      });

      setState(() {
        _isSocketConnected = true;
      });

      // Fetch initial messages
      _fetchMessages();
    } catch (error) {
      debugPrint('Error initializing socket: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to connect to chat server. Please try again later.')),
      );
    }
  }

  /// Fetch paginated messages
  void _fetchMessages() async {
    if (_isLoading || !_hasMore) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final data = await socketManager.getAllChatMessages(
        chatId: widget.chatId,
        page: _currentPage,
        limit: _limit,
      );

      setState(() {
        List<dynamic> fetchedMessages = data['messages'] ?? [];
        // Since you are reversing the list in UI, you should insert older messages at the end.
        // In this example, assume 'fetchedMessages' comes in chronological order (oldest first).
        // We append them at the end because we use `reverse: true`.
        _messages.addAll(fetchedMessages.map((msg) => _formatMessage(msg)).toList());
        _currentPage++;
        _hasMore = _currentPage <= (data['totalPages'] ?? 0);
        _isLoading = false;
      });

      // Scroll to bottom after initial load
      if (_currentPage == 2) {
        _scrollToBottom();
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      debugPrint('Error fetching messages: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch messages. Please try again later.')),
      );
    }
  }

  /// Format message data
  Map<String, dynamic> _formatMessage(dynamic msg) {
    return {
      'message': msg['content'] ?? '',
      'senderId': msg['senderId'] ?? '',
      'isMe': msg['senderId'] == widget.senderId,
      'time': msg['createdAt'] ?? DateTime.now().toIso8601String(),
      'messageType': msg['messageType'] ?? 'text',
    };
  }

  /// Handle new message received
  void _onNewMessageReceived(dynamic data) {
    debugPrint('New message received in ChatScreen: $data');
    if (!mounted) return;
    setState(() {
      // Insert at the top because we are using `reverse: true` in the ListView
      _messages.insert(0, _formatMessage(data));
    });
    _scrollToBottom();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _controller.dispose();
    _messageSubscription?.cancel();
    super.dispose();
  }

  /// Send a message
  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    String messageContent = _controller.text.trim();

    // Send the message via socket manager
    socketManager.sendMessage(
      chatId: widget.chatId,
      senderId: widget.senderId,
      receiverId: widget.receiverId,
      messageType: 'text',
      content: messageContent,
      files: [],
    );

    // Add the message to the list and update UI immediately
    setState(() {
      _messages.insert(0, {
        'message': messageContent,
        'senderId': widget.senderId,
        'isMe': true,
        'time': DateTime.now().toIso8601String(),
        'messageType': 'text',
      });
    });

    _scrollToBottom();
    _controller.clear();
  }

  /// Scroll listener to show/hide scroll button
  void _scrollListener() {
    if (_scrollController.offset > 1000) {
      if (!_showScrollButton) {
        setState(() {
          _showScrollButton = true;
        });
      }
    } else {
      if (_showScrollButton) {
        setState(() {
          _showScrollButton = false;
        });
      }
    }
  }

  /// Scroll to bottom of the chat
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.minScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isSocketConnected) {
      // Show a loading indicator while the socket is connecting
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          sizeStatusBar(context: context),
          ChatHeader(item: widget.item),
          Expanded(
            child: _isLoading && _messages.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
              reverse: true, // Show newest messages at the bottom visually
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return MessageBubble(
                  message: message["message"],
                  time: message["time"],
                  isMe: message["isMe"],
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Color(0xFFEDEDED)),
            ),
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 6),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF4F4F4),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.emoji_emotions_outlined, color: _emojiShowing ? Colors.blue : Colors.grey,),
                          onPressed: () {
                            setState(() {
                              _emojiShowing = !_emojiShowing;
                            });
                          },
                        ),
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              hintText: 'Type your message...',
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                color: Color(0xFF7D818B),
                                fontFamily: 'Mulish',
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.attach_file, color: Colors.grey,),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                sizeWidth5,
                SizedBox(
                  width: 50,
                  height: 50,
                  child: InkWell(
                    onTap: _sendMessage,
                    child: CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 30,
                      child: Icon(Icons.send, color: Colors.white,),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Offstage(
            offstage: !_emojiShowing,
            child: EmojiPicker(
              textEditingController: _controller,
              scrollController: _scrollController,
              config: Config(
                height: 256,
                checkPlatformCompatibility: true,
                emojiViewConfig: EmojiViewConfig(
                  emojiSizeMax: 28 * (defaultTargetPlatform == TargetPlatform.iOS ? 1.2 : 1.0),
                ),
                skinToneConfig: const SkinToneConfig(),
                categoryViewConfig: const CategoryViewConfig(),
                bottomActionBarConfig: const BottomActionBarConfig(),
                searchViewConfig: const SearchViewConfig(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// For debugPrint

// class CalliverseSocketManager {
//   // Private constructor
//   CalliverseSocketManager._privateConstructor();
//
//   // Singleton instance
//   static final CalliverseSocketManager _instance = CalliverseSocketManager._privateConstructor();
//
//   // Factory constructor
//   factory CalliverseSocketManager() {
//     return _instance;
//   }
//
//
//   String? _userId;
//
//   // StreamController to broadcast incoming messages
//   final StreamController<Map<String, dynamic>> _messageStreamController = StreamController<Map<String, dynamic>>.broadcast();
//
//   /// Initialize the socket connection with the given userId
//   Future<void> initializeSocket({required String userId}) async {
//     if (socket.connected) {
//       debugPrint('Socket already connected');
//       return;
//     }
//
//     _userId = userId;
//
//
//     // Handle connection
//     socket.onConnect((_) {
//       debugPrint('Socket connected');
//       _emitUserOnline();
//     });
//
//     // Handle disconnection
//     socket.onDisconnect((_) {
//       debugPrint('Socket disconnected');
//     });
//
//     // Listen for 'receiveMessage' event
//     socket.on('receiveMessage', (data) {
//       debugPrint('New message received: $data');
//       _handleIncomingMessage(data);
//     });
//
//     // Handle errors
//     socket.onError((error) {
//       debugPrint('Socket error: $error');
//     });
//
//     // Connect the socket
//     socket.connect();
//   }
//
//   /// Expose the message stream
//   Stream<Map<String, dynamic>> get messageStream => _messageStreamController.stream;
//
//   /// Emit 'userOnline' event
//   void _emitUserOnline() {
//     if (_userId == null) {
//       debugPrint('User ID is not set');
//       return;
//     }
//     socket.emit('userOnline', {'userId': _userId});
//     debugPrint('Emitted userOnline for userId: $_userId');
//   }
//
//   /// Join a specific chat room
//   void joinChat(String chatId, String chatType) {
//     socket.emit('joinChat', {
//       'chatId': chatId,
//       'chatType': chatType,
//     });
//     debugPrint('Joined chat room: $chatId of type: $chatType');
//   }
//
//   /// Send a message to another user
//   void sendMessage({
//     required String chatId,
//     required String senderId,
//     required String receiverId,
//     required String messageType,
//     required String content,
//     List<dynamic> files = const [],
//   }) {
//     socket.emit('sendMessage', {
//       'chatId': chatId,
//       'senderId': senderId,
//       'receiverId': receiverId,
//       'messageType': messageType,
//       'content': content,
//       'files': files,
//     });
//     debugPrint('Sent message: $content');
//   }
//
//   /// Handle incoming messages
//   void _handleIncomingMessage(dynamic data) {
//     debugPrint('Handling incoming message: $data');
//     if (data is Map<String, dynamic>) {
//       // Emit acknowledgment if necessary
//       if (data.containsKey('chatId') && data.containsKey('messageId')) {
//         socket.emit('messageReceived', {
//           'chatId': data['chatId'],
//           'messageId': data['messageId'],
//         });
//         debugPrint('Acknowledged messageId: ${data['messageId']} in chatId: ${data['chatId']}');
//       }
//       // Add the message to the stream
//       _messageStreamController.add(Map<String, dynamic>.from(data));
//       debugPrint('Message added to stream');
//     } else {
//       debugPrint('Received invalid message format');
//     }
//   }
//
//   /// Retrieve all chat messages with pagination
//   Future<Map<String, dynamic>> getAllChatMessages({
//     required String chatId,
//     required int page,
//     required int limit,
//   }) {
//     Completer<Map<String, dynamic>> completer = Completer<Map<String, dynamic>>();
//
//     socket.emitWithAck('getAllChatMessages', {
//       'chatId': chatId,
//       'page': page,
//       'limit': limit,
//     }, ack: (response) {
//       debugPrint('Received getAllChatMessages response: $response');
//
//       if (response != null) {
//         if (response['success'] == true && response['data'] != null) {
//           if (response['data']['messages'] is List) {
//             completer.complete(Map<String, dynamic>.from(response['data']));
//           } else {
//             completer.completeError('Invalid messages format.');
//           }
//         } else {
//           completer.completeError(response['error'] ?? 'Unknown error');
//         }
//       } else {
//         completer.completeError('No response from server.');
//       }
//     });
//
//     // Implement a timeout to prevent indefinite waiting
//     Timer(Duration(seconds: 10), () {
//       if (!completer.isCompleted) {
//         completer.completeError('Request timed out');
//       }
//     });
//
//     return completer.future;
//   }
//
//   /// Disconnect the socket connection
//   void disconnectSocket() {
//     if (socket.connected) {
//       socket.disconnect();
//       debugPrint('Socket disconnected manually');
//     }
//     _messageStreamController.close();
//   }
// }
//
//
//
//
// class ChatScreen extends StatefulWidget {
//   final Participant item;
//   final String senderId;
//   final String chatId;
//   final String receiverId;
//
//   ChatScreen({
//     Key? key,
//     required this.item,
//     required this.senderId,
//     required this.receiverId,
//     required this.chatId,
//   }) : super(key: key);
//
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   final CalliverseSocketManager socketManager = CalliverseSocketManager();
//   List<Map<String, dynamic>> _messages = []; // List to store messages
//   final int _limit = 10;
//   int _currentPage = 1;
//   bool _isLoading = false;
//   bool _hasMore = true;
//
//   final TextEditingController _controller = TextEditingController();
//   final ScrollController _scrollController = ScrollController();
//   bool _showScrollButton = false;
//   bool _emojiShowing = false;
//
//   bool _isSocketConnected = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(_scrollListener);
//     _initializeSocket();
//   }
//
//   Future<void> _initializeSocket() async {
//     try {
//       // await socketManager.initializeSocket(userId: widget.senderId);
//       setState(() {
//         _isSocketConnected = true;
//       });
//
//       // Join the chat room
//       socketManager.joinChat(widget.chatId, "one-to-one");
//
//       // Listen for new messages via the message stream
//       socketManager.messageStream.listen((data) {
//         _onNewMessageReceived(data);
//       });
//
//       // Fetch initial messages
//       _fetchMessages();
//     } catch (error) {
//       debugPrint('Error initializing socket: $error');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to connect to chat server. Please try again later.')),
//       );
//     }
//   }
//
//   /// Fetch paginated messages
//   void _fetchMessages() async {
//     if (_isLoading || !_hasMore) return;
//
//     setState(() {
//       _isLoading = true;
//     });
//
//     try {
//       final data = await socketManager.getAllChatMessages(
//         chatId: widget.chatId,
//         page: _currentPage,
//         limit: _limit,
//       );
//
//       setState(() {
//         List<dynamic> fetchedMessages = data['messages'] ?? [];
//         _messages.addAll(fetchedMessages.map((msg) => _formatMessage(msg)).toList());
//         _currentPage++;
//         _hasMore = _currentPage <= (data['totalPages'] ?? 0);
//         _isLoading = false;
//       });
//
//       // Scroll to bottom after initial load
//       if (_currentPage == 2) {
//         _scrollToBottom();
//       }
//     } catch (error) {
//       setState(() {
//         _isLoading = false;
//       });
//       debugPrint('Error fetching messages: $error');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to fetch messages. Please try again later.')),
//       );
//     }
//   }
//
//   /// Format message data
//   Map<String, dynamic> _formatMessage(dynamic msg) {
//     return {
//       'message': msg['content'] ?? '',
//       'senderId': msg['senderId'] ?? '',
//       'isMe': msg['senderId'] == widget.senderId,
//       'time': msg['createdAt'] ?? DateTime.now().toIso8601String(),
//       'messageType': msg['messageType'] ?? 'text',
//     };
//   }
//
//   /// Handle new message received
//   void _onNewMessageReceived(dynamic data) {
//     debugPrint('New message received in ChatScreen: $data');
//     setState(() {
//       _messages.insert(0, _formatMessage(data));
//     });
//     _scrollToBottom();
//   }
//
//   @override
//   void dispose() {
//     // Do not disconnect the socket here if it's being used elsewhere
//     _scrollController.removeListener(_scrollListener);
//     _scrollController.dispose();
//     _controller.dispose();
//     super.dispose();
//   }
//
//   /// Send a message
//   void _sendMessage() {
//     if (_controller.text.trim().isEmpty) return;
//
//     String messageContent = _controller.text.trim();
//
//     Map<String, dynamic> messageData = {
//       'chatId': widget.chatId,
//       'senderId': widget.senderId,
//       'receiverId': widget.receiverId,
//       'messageType': 'text',
//       'content': messageContent,
//       'files': [],
//     };
//
//     // Send the message via socket manager
//     socketManager.sendMessage(
//       chatId: widget.chatId,
//       senderId: widget.senderId,
//       receiverId: widget.receiverId,
//       messageType: 'text',
//       content: messageContent,
//       files: [],
//     );
//
//     // Add the message to the list
//     setState(() {
//       _messages.add({
//         'message': messageContent,
//         'senderId': widget.senderId,
//         'isMe': true,
//         'time': DateTime.now().toIso8601String(),
//         'messageType': 'text',
//       });
//     });
//
//     _scrollToBottom();
//
//     _controller.clear();
//   }
//
//   /// Scroll listener to show/hide scroll button
//   void _scrollListener() {
//     if (_scrollController.offset > 1000) {
//       if (!_showScrollButton) {
//         setState(() {
//           _showScrollButton = true;
//         });
//       }
//     } else {
//       if (_showScrollButton) {
//         setState(() {
//           _showScrollButton = false;
//         });
//       }
//     }
//   }
//
//   /// Scroll to bottom of the chat
//   void _scrollToBottom() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (_scrollController.hasClients) {
//         _scrollController.animateTo(
//           _scrollController.position.minScrollExtent,
//           duration: Duration(milliseconds: 300),
//           curve: Curves.easeOut,
//         );
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (!_isSocketConnected) {
//       // Show a loading indicator while the socket is connecting
//       return Scaffold(
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }
//
//     return Scaffold(
//       // Optional: Add AppBar or other UI components
//       body: Column(
//         children: [
//           sizeStatusBar(context: context),
//           ChatHeader(item: widget.item),
//           Expanded(
//             child: _isLoading && _messages.isEmpty
//                 ? Center(child: CircularProgressIndicator()) // Replace with your custom indicator if needed
//                 : ListView.builder(
//               reverse: true, // Show the newest messages at the bottom
//               controller: _scrollController,
//               itemCount: _messages.length,
//               itemBuilder: (context, index) {
//                 final message = _messages[index];
//                 return MessageBubble(
//                   message: message["message"],
//                   time: message["time"], // Use actual time
//                   isMe: message["isMe"],
//                   // Add other properties as needed
//                 );
//               },
//             ),
//           ),
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               border: Border.all(color: Color(0xFFEDEDED)),
//             ),
//             padding: EdgeInsets.symmetric(vertical: 14, horizontal: 6),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Color(0xFFF4F4F4),
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
//                     child: Row(
//                       children: [
//                         IconButton(
//                           icon: Icon(Icons.emoji_emotions_outlined, color: _emojiShowing ? Colors.blue : Colors.grey,),
//                           onPressed: () {
//                             setState(() {
//                               _emojiShowing = !_emojiShowing;
//                             });
//                           },
//                           // semanticLabel: 'Choose emoji',
//                         ),
//                         Expanded(
//                           child: TextField(
//                             controller: _controller,
//                             decoration: InputDecoration(
//                               hintText: 'Type your message...',
//                               border: InputBorder.none,
//                               hintStyle: TextStyle(
//                                 color: Color(0xFF7D818B),
//                                 fontFamily: 'Mulish',
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.attach_file, color: Colors.grey,),
//                           onPressed: () {},
//                           // semanticLabel: 'Attach file',
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 65,
//                   height: 65,
//                   child: CustomIconButton(
//                     onPressed: _sendMessage,
//                     icon: CircleAvatar(
//                       backgroundColor: Colors.blue,
//                       radius: 30,
//                       child: Icon(Icons.send, color: Colors.white,),
//                     ),
//                     backgroundColor: Colors.blue,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Offstage(
//             offstage: !_emojiShowing,
//             child: EmojiPicker(
//               textEditingController: _controller,
//               scrollController: _scrollController,
//               config: Config(
//                 height: 256,
//                 checkPlatformCompatibility: true,
//                 emojiViewConfig: EmojiViewConfig(
//                   emojiSizeMax: 28 * (defaultTargetPlatform == TargetPlatform.iOS ? 1.2 : 1.0),
//                 ),
//                 skinToneConfig: const SkinToneConfig(),
//                 categoryViewConfig: const CategoryViewConfig(),
//                 bottomActionBarConfig: const BottomActionBarConfig(),
//                 searchViewConfig: const SearchViewConfig(),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

