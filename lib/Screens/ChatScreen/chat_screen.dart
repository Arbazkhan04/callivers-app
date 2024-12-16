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
import 'package:flutter/material.dart';
import 'package:calliverse/Constants/color.dart';
import 'package:calliverse/Widgets/button.dart';
// import '../../services/streamsocket.dart';
import '../../Components/ChatComponents/chat_header.dart';
import '../../Components/ChatComponents/message_bubble.dart';
import '../../Components/ChatComponents/date_divider.dart';
import '../../main.dart';
import '../../modals/all_user_chats_model.dart';

// lib/services/streamsocket.dart

import 'package:socket_io_client/socket_io_client.dart' as IO;

class StreamSocket {
  final socketResponse = StreamController<Map<String, dynamic>>.broadcast();
  // late IO.Socket socket;

  // Expose the stream
  Stream<Map<String, dynamic>> get getResponse => socketResponse.stream;

  // Private constructor for Singleton pattern
  StreamSocket._privateConstructor();

  // Singleton instance
  static final StreamSocket _instance = StreamSocket._privateConstructor();

  // Factory constructor
  factory StreamSocket() {
    return _instance;
  }

  // Initialize and connect the socket
  void connectAndListen({
    required String userId,
    required Function onConnected,
    required Function(String) onDisconnected,
    required Function(String) onError,
  }) {

    // Handle connection
    socket.onConnect((_) {
      print('Connected to Socket.IO server');
      // Notify server that user is online
      emitUserOnline(userId);
      onConnected();
    });

    // Handle disconnection
    socket.onDisconnect((_) {
      print('Disconnected from Socket.IO server');
      onDisconnected('Disconnected');
    });

    // Handle errors
    socket.onError((error) {
      print('Socket.IO error: $error');
      onError(error.toString());
    });

    // Listen for 'receiveMessage' event from server
    socket.on('receiveMessage', (data) {
      print('New message received: $data');
      if (data is Map<String, dynamic>) {
        socketResponse.sink.add(Map<String, dynamic>.from(data));
        // Emit acknowledgment
        emitMessageReceived(data['chatId'], data['messageId']);
      } else {
        print('Received invalid message format');
      }
    });
  }

  // Emit 'userOnline' event
  void emitUserOnline(String userId) {
    socket.emit('userOnline', {'userId': userId});
  }

  // Emit 'joinChat' event
  void emitJoinChat(String chatId, String chatType) {
    socket.emit('joinChat', {
      'chatId': chatId,
      'chatType': chatType,
    });
  }

  // Emit 'sendMessage' event
  void emitSendMessage(Map<String, dynamic> messageData) {
    socket.emit('sendMessage', messageData);
  }

  // Emit 'messageReceived' acknowledgment
  void emitMessageReceived(String chatId, String messageId) {
    socket.emit('messageReceived', {
      'chatId': chatId,
      'messageId': messageId,
    });
  }

  // Correctly implemented 'getAllChatMessages' with Future return type
  Future<Map<String, dynamic>> getAllChatMessages({
    required String chatId,
    required int page,
    required int limit,
  }) {
    Completer<Map<String, dynamic>> completer = Completer<Map<String, dynamic>>();

    socket.emit('getAllChatMessages', [{
      'chatId': chatId,
      'page': page,
      'limit': limit,
    }, (response) {
      print('Received getAllChatMessages response: $response'); // Debug statement

      if (!completer.isCompleted) {
        if (response is Map) {
          completer.complete(Map<String, dynamic>.from(response));
        } else {
          completer.completeError('Invalid response format');
        }
      }
    }]);

    // Implement a timeout to prevent indefinite waiting
    Timer(Duration(seconds: 10), () {
      if (!completer.isCompleted) {
        completer.completeError('Request timed out');
      }
    });

    return completer.future;
  }

  // Dispose resources
  void dispose() {
    socket.disconnect();
    socket.close();
    socketResponse.close();
  }
}

// Instantiate as a singleton
final StreamSocket streamSocket = StreamSocket();



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
  late CalliverseSocketManager socketManager;
  List<Map<String, dynamic>> messages = []; // List to store messages
  // final String chatId = "abc123";
  // final String userId = "12345"; // Current user ID
  final int limit = 10;
  int currentPage = 1;
  bool isLoading = false;
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    socketManager = CalliverseSocketManager(userId: widget.senderId);
    socketManager.initializeSocket();

    // Join the chat room
    socketManager.joinChat(widget.chatId, "one-to-one");

    // Listen for new messages
    socketManager._socket.on('receiveMessage', (data) {
      onNewMessageReceived(data);
    });

    // Fetch initial messages
    fetchMessages();
  }

  /// Fetch paginated messages
  void fetchMessages() async {
    if (isLoading || !hasMore) return;

    setState(() {
      isLoading = true;
    });

    socketManager.getAllChatMessages(
      chatId: widget.chatId,
      page: currentPage,
      limit: limit,
      onSuccess: (data) {
        setState(() {
          List<dynamic> fetchedMessages = data['messages'];
          messages.addAll(fetchedMessages.map((msg) => _formatMessage(msg)).toList());
          currentPage++;
          hasMore = currentPage <= data['totalPages'];
          isLoading = false;
        });
      },
      onError: (error) {
        setState(() {
          isLoading = false;
        });
        debugPrint('Error fetching messages: $error');
      },
    );
  }

  /// Format message data
  Map<String, dynamic> _formatMessage(dynamic msg) {
    return {
      'message': msg['content'] ?? '',
      'senderId': msg['senderId'] ?? '',
      'isMe': msg['senderId'] == widget.senderId,
      'time': msg['createdAt'] ?? DateTime.now().toString(),
      'messageType': msg['messageType'] ?? 'text',
    };
  }

  /// Handle new message received
  void onNewMessageReceived(dynamic data) {
    setState(() {
      messages.insert(0, _formatMessage(data));
    });
  }

  @override
  void dispose() {
    socketManager.disconnectSocket();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  final controller = TextEditingController();
  void sendMessage() {
    if (controller.text.trim().isEmpty) return;

    String messageContent = controller.text.trim();

    Map<String, dynamic> messageData = {
      'chatId': widget.chatId,
      'senderId': widget.senderId,
      'receiverId': widget.receiverId,
      'messageType': 'text',
      'content': messageContent,
      'files': [],
    };

    streamSocket.emitSendMessage(messageData);

    setState(() {
      messages.add({
        'message': messageContent,
        'time': DateTime.now().toString(),
        'isMe': true,
        'hasImage': false,
        'imageUrl': '',
        'quotedMessage': '',
        'isRead': true,
        'hasVoiceMessage': false,
        'voiceDuration': '',
        'messageId': '', // Update with actual message ID if available
      });
    });
    _scrollToBottom;
    // setState(() {});

    controller.clear();
  }
  bool _showScrollButton = false;
  final ScrollController _scrollController = ScrollController();


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

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
  bool _emojiShowing = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Chat'),
      // ),
      body: Column(
        children: [
          sizeStatusBar(context: context),
          ChatHeader(item: widget.item),
          Expanded(
            child:
              isLoading?
              indicatorMainColor
                  :
            ListView.builder(
              reverse: true, // Show the newest messages at the bottom
              controller:  _scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return
                  MessageBubble(
                    message: message["message"],
                    time: '16.46',
                    isMe: index == 0 || index == 3? true : false,
                    // quotedMessage: 'Can I come over?',
                  )
                  ;
                //   Align(
                //   alignment: message['isMe']
                //       ? Alignment.centerRight
                //       : Alignment.centerLeft,
                //   child: Container(
                //     padding: EdgeInsets.all(10),
                //     margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                //     decoration: BoxDecoration(
                //       color: message['isMe']
                //           ? Colors.blue[100]
                //           : Colors.grey[300],
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           message['message'],
                //           style: TextStyle(fontSize: 16),
                //         ),
                //         SizedBox(height: 5),
                //         Text(
                //           message['time'],
                //           style: TextStyle(fontSize: 12, color: Colors.grey),
                //         ),
                //       ],
                //     ),
                //   ),
                // );
              },
            ),
          ),

          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: TextField(
          //           controller: TextEditingController(),
          //           decoration: InputDecoration(
          //             hintText: 'Type a message...',
          //             border: OutlineInputBorder(),
          //           ),
          //           onSubmitted: (value) {
          //             if (value.isNotEmpty) {
          //               socketManager.sendMessage(
          //                 chatId: widget.chatId,
          //                 senderId: widget.senderId,
          //                 receiverId: widget.receiverId, // Replace with the actual receiver ID
          //                 messageType: "text",
          //                 content: value,
          //               );
          //             }
          //           },
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // EmojiPicker(
          //   onEmojiSelected: (Category? category, Emoji emoji) {
          //     // Do something when emoji is tapped (optional)
          //   },
          //   onBackspacePressed: () {
          //     // Do something when the user taps the backspace button (optional)
          //     // Set it to null to hide the Backspace-Button
          //   },
          //   textEditingController: controller, // pass here the same [TextEditingController] that is connected to your input field, usually a [TextFormField]
          //   config: Config(
          //     height: 256,
          //     // : const Color(0xFFF2F2F2),
          //     checkPlatformCompatibility: true,
          //     emojiViewConfig: EmojiViewConfig(
          //       // Issue: https://github.com/flutter/flutter/issues/28894
          //       emojiSizeMax: 28 *
          //           (foundation.defaultTargetPlatform == TargetPlatform.iOS
          //               ?  1.20
          //               :  1.0),
          //     ),
          //     // viewOrderConfig: const ViewOrderConfig(
          //     //   top: EmojiPickerItem.categoryBar,
          //     //   middle: EmojiPickerItem.emojiView,
          //     //   bottom: EmojiPickerItem.searchBar,
          //     // ),
          //     skinToneConfig: const SkinToneConfig(),
          //     // skinToneConfig: const SkinToneConfig(),
          //     categoryViewConfig: const CategoryViewConfig(),
          //     bottomActionBarConfig: const BottomActionBarConfig(),
          //     searchViewConfig: const SearchViewConfig(),
          //   ),
          // ),
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
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.emoji_emotions_outlined, color: _emojiShowing? mainColor : textColor,),
                            onPressed: () {
                              setState(() {
                                _emojiShowing = !_emojiShowing;
                              });
                            },
                            // semanticLabel: 'Choose emoji',
                          ),
                          Expanded(
                            child: TextField(
                              controller: controller,
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
                            icon: Icon(Icons.attach_file),
                            onPressed: () {},
                            // semanticLabel: 'Attach file',
                          ),
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(width: 6),
                  SizedBox(
                    width: 65,
                    height: 65,
                    child: CustomIconButton(
                      onPressed: sendMessage,

                      icon: CircleAvatar(
                          backgroundColor: mainColor,
                          radius: 30,
                          child: Icon(Icons.send,color: whiteColor,)),
                      backgroundColor: Theme.of(context).primaryColor,
                      // mini: true,
                    ),
                  ),


                ],
              ),
            ),
          Offstage(
            offstage: !_emojiShowing,
            child: EmojiPicker(
              textEditingController: controller,
              scrollController: _scrollController,
              config: Config(
                height: 256,
                checkPlatformCompatibility: true,
                // viewOrderConfig: const ViewOrderConfig(),
                emojiViewConfig: EmojiViewConfig(
                  // Issue: https://github.com/flutter/flutter/issues/28894
                  emojiSizeMax: 28 *
                      (foundation.defaultTargetPlatform ==
                          TargetPlatform.iOS
                          ? 1.2
                          : 1.0),
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
//   State<ChatScreen> createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController controller = TextEditingController();
//   List<Map<String, dynamic>> messages = [];
//   late StreamSubscription<Map<String, dynamic>> socketSubscription;
//   int currentPage = 1;
//   final int limit = 10;
//   bool isLoading = false;
//   bool hasMore = true;
//
//   @override
//   void initState() {
//     super.initState();
//     joinChatRoom();
//     // Schedule fetchMessages to run after the first frame
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       fetchMessages();
//       socket.on('getMessageEvent',(data){
//         print("datasss $data");
//         // messageList.add(MessageModel.fromjson(data));
//       });
//     });
//
//     // Listen to the socket stream
//     socketSubscription = streamSocket.getResponse.listen((data) {
//       handleIncomingMessage(data);
//     });
//   }
//
//   // Join the chat room
//   void joinChatRoom() {
//     streamSocket.emitJoinChat(widget.chatId, 'one-to-one');
//   }
//
//   // Handle incoming messages
//   void handleIncomingMessage(Map<String, dynamic> data) {
//     if (data['chatId'] == widget.chatId) {
//       setState(() {
//         messages.add({
//           'message': data['content'] ?? '',
//           'time': DateTime.now().toString(),
//           'isMe': data['senderId'] == widget.senderId,
//           'hasImage': data['messageType'] == 'media',
//           'imageUrl': data['content'] ?? '',
//           'quotedMessage': data['quotedMessage'] ?? '',
//           'isRead': data['isRead'] ?? false,
//           'hasVoiceMessage': data['hasVoiceMessage'] ?? false,
//           'voiceDuration': data['voiceDuration'] ?? '',
//           'messageId': data['messageId'] ?? '',
//         });
//       });
//     }
//   }
//
//   // // Fetch messages with pagination
//   // Future<void> fetchMessages() async {
//   //   if (isLoading || !hasMore) return;
//   //   setState(() {
//   //     isLoading = true;
//   //   });
//   //
//   //   try {
//   //     Map<String, dynamic> response = await streamSocket.getAllChatMessages(
//   //       chatId: widget.chatId,
//   //       page: currentPage,
//   //       limit: limit,
//   //     );
//   //
//   //     print('Fetched messages response: $response'); // Debug statement
//   //
//   //     // if (response['success'] && response['data'] != null) {
//   //     //   List<dynamic> fetchedMessages = response['data']['messages'];
//   //     //   int totalMessages = response['data']['totalMessages'];
//   //     //   int totalPages = response['data']['totalPages'];
//   //     //   print("objectDDA -> ${fetchedMessages}");
//   //     //   setState(() {
//   //     //     messages = fetchedMessages.map((msg) {
//   //     //       if (msg is Map<String, dynamic>) {
//   //     //         return {
//   //     //           'message': msg['content'] ?? '',
//   //     //           'time': msg['createdAt'] ?? DateTime.now().toString(),
//   //     //           'isMe': msg['senderId'] == widget.senderId,
//   //     //           'hasImage': msg['messageType'] == 'media',
//   //     //           'imageUrl': msg['content'] ?? '',
//   //     //           'quotedMessage': msg['quotedMessage'] ?? '',
//   //     //           'isRead': msg['isRead'] ?? false,
//   //     //           'hasVoiceMessage': msg['hasVoiceMessage'] ?? false,
//   //     //           'voiceDuration': msg['voiceDuration'] ?? '',
//   //     //           'messageId': msg['messageId'] ?? '',
//   //     //         };
//   //     //       } else {
//   //     //         return {
//   //     //           'message': 'Invalid message format',
//   //     //           'time': DateTime.now().toString(),
//   //     //           'isMe': false,
//   //     //           'hasImage': false,
//   //     //           'imageUrl': '',
//   //     //           'quotedMessage': '',
//   //     //           'isRead': false,
//   //     //           'hasVoiceMessage': false,
//   //     //           'voiceDuration': '',
//   //     //           'messageId': '',
//   //     //         };
//   //     //       }
//   //     //     }).toList()
//   //     //       ..addAll(messages); // Prepend fetched messages
//   //     //
//   //     //     currentPage++;
//   //     //     hasMore = currentPage <= totalPages;
//   //     //   });
//   //     // } else {
//   //     //   print('Failed to fetch messages: ${response['error']}');
//   //     //   ScaffoldMessenger.of(context).showSnackBar(
//   //     //     SnackBar(content: Text('Failed to fetch messages: ${response['error']}')),
//   //     //   );
//   //     // }
//   //   } catch (e) {
//   //     print('Error fetching messages: $e');
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(content: Text('Error fetching messages: $e')),
//   //     );
//   //   } finally {
//   //     setState(() {
//   //       isLoading = false;
//   //     });
//   //   }
//   // }
//   Future<void> fetchMessages() async {
//     if (isLoading || !hasMore) return;
//
//     setState(() {
//       isLoading = true;
//     });
//
//     try {
//       Map<String, dynamic> response = await streamSocket.getAllChatMessages(
//         chatId: widget.chatId,
//         page: currentPage,
//         limit: limit,
//       );
//
//       print('Raw API Response: $response');
//
//       if (response['success'] == true && response['data'] is Map<String, dynamic>) {
//         var data = response['data'] as Map<String, dynamic>;
//         List<dynamic> fetchedMessages = data['messages'] ?? [];
//         int totalPages = data['totalPages'] ?? 0;
//
//         // Validate and format messages
//         List<Map<String, dynamic>> sanitizedMessages = fetchedMessages
//             .where((msg) => msg is Map<String, dynamic>)
//             .map((msg) => _formatMessage(msg))
//             .toList();
//
//         setState(() {
//           messages = [...sanitizedMessages, ...messages];
//           currentPage++;
//           hasMore = currentPage <= totalPages;
//         });
//       } else {
//         String errorMessage = response['error'] ?? 'Unknown error';
//         print('Failed to fetch messages: $errorMessage');
//         _showErrorSnackbar('Failed to fetch messages: $errorMessage');
//       }
//     } catch (e) {
//       print('Error fetching messages: $e');
//       _showErrorSnackbar('Error fetching messages: $e');
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   Map<String, dynamic> _formatMessage(dynamic msg) {
//     if (msg is Map<String, dynamic>) {
//       return {
//         'message': msg['content'] ?? '',
//         'time': msg['createdAt'] ?? DateTime.now().toIso8601String(),
//         'isMe': msg['senderId'] == widget.senderId,
//         'hasImage': msg['messageType'] == 'media',
//         'imageUrl': msg['content'] ?? '',
//         'quotedMessage': msg['quotedMessage'] ?? '',
//         'isRead': msg['isRead'] ?? false,
//         'hasVoiceMessage': msg['hasVoiceMessage'] ?? false,
//         'voiceDuration': msg['voiceDuration']?.toString() ?? '',
//         'messageId': msg['messageId']?.toString() ?? '',
//       };
//     }
//
//     return {
//       'message': 'Invalid message format',
//       'time': DateTime.now().toIso8601String(),
//       'isMe': false,
//       'hasImage': false,
//       'imageUrl': '',
//       'quotedMessage': '',
//       'isRead': false,
//       'hasVoiceMessage': false,
//       'voiceDuration': '',
//       'messageId': '',
//     };
//   }
//
//   void _showErrorSnackbar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message)),
//     );
//   }
//
//
//   // Send a message
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
//     streamSocket.emitSendMessage(messageData);
//
//     setState(() {
//       messages.add({
//         'message': messageContent,
//         'time': DateTime.now().toString(),
//         'isMe': true,
//         'hasImage': false,
//         'imageUrl': '',
//         'quotedMessage': '',
//         'isRead': true,
//         'hasVoiceMessage': false,
//         'voiceDuration': '',
//         'messageId': '', // Update with actual message ID if available
//       });
//     });
//
//     controller.clear();
//   }
//
//   @override
//   void dispose() {
//     socketSubscription.cancel();
//     controller.dispose();
//     super.dispose();
//   }
//
//   // Load more messages when pulling to refresh
//   Future<void> _onRefresh() async {
//     await fetchMessages();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFF7F7FC),
//       body: SafeArea(
//         child: Column(
//           children: [
//             ChatHeader(item: widget.item),
//             Expanded(
//               child: RefreshIndicator(
//                 onRefresh: _onRefresh,
//                 child: ListView.builder(
//                   reverse: true, // To display latest messages at the bottom
//                   padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//                   itemCount: messages.length + (hasMore ? 1 : 0),
//                   itemBuilder: (context, index) {
//                     if (index == messages.length) {
//                       // Loader item
//                       return Center(
//                         child: CircularProgressIndicator(),
//                       );
//                     }
//
//                     final msg = messages[messages.length - 1 - index];
//                     return Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 4.0),
//                       child: MessageBubble(
//                         message: msg['message'],
//                         time: msg['time'],
//                         isMe: msg['isMe'],
//                         hasImage: msg['hasImage'],
//                         imageUrl: msg['imageUrl'],
//                         quotedMessage: msg['quotedMessage'],
//                         isRead: msg['isRead'],
//                         hasVoiceMessage: msg['hasVoiceMessage'],
//                         voiceDuration: msg['voiceDuration'],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//             buildChatInput(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Build the chat input widget
//   Widget buildChatInput() {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border.all(color: Color(0xFFEDEDED)),
//       ),
//       padding: EdgeInsets.symmetric(vertical: 14, horizontal: 6),
//       child: Row(
//         children: [
//           Expanded(
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Color(0xFFF4F4F4),
//                 borderRadius: BorderRadius.circular(25),
//               ),
//               padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
//               child: Row(
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.emoji_emotions_outlined),
//                     onPressed: () {},
//                     // semanticLabel: 'Choose emoji',
//                   ),
//                   Expanded(
//                     child: TextField(
//                       controller: controller,
//                       decoration: InputDecoration(
//                         hintText: 'Type your message...',
//                         border: InputBorder.none,
//                         hintStyle: TextStyle(
//                           color: Color(0xFF7D818B),
//                           fontFamily: 'Mulish',
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.attach_file),
//                     onPressed: () {},
//                     // semanticLabel: 'Attach file',
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(width: 8),
//           SizedBox(
//             width: 48,
//             height: 48,
//             child: CustomIconButton(
//               onPressed: sendMessage,
//               icon: CircleAvatar(
//                 backgroundColor: mainColor,
//                 radius: 24,
//                 child: Icon(Icons.send, color: whiteColor, size: 20),
//               ),
//               backgroundColor: Colors.transparent,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class CalliverseSocketManager {
  late IO.Socket _socket;
  final String userId;

  CalliverseSocketManager({required this.userId});

  /// Initialize the socket connection
  void initializeSocket() {
    // Connect to the Socket.IO server
    _socket = IO.io(
      'https://http://192.168.0.104:3003', // Replace with the actual URL
      IO.OptionBuilder()
          .setTransports(['websocket']) // Use WebSocket transport
          .enableAutoConnect()
          .build(),
    );

    // Listen for connection
    _socket.onConnect((_) {
      debugPrint('Socket connected');
      userOnline();
    });

    // Listen for disconnection
    _socket.onDisconnect((_) {
      debugPrint('Socket disconnected');
    });

    // Register the receiveMessage event listener
    _socket.on('receiveMessage', (data) {
      debugPrint('New message received: $data');
      onMessageReceived(data);
    });
  }

  /// Notify the server that a user is online
  void userOnline() {
    _socket.emit('userOnline', {'userId': userId});
    debugPrint('User online event emitted for userId: $userId');
  }

  /// Join a specific chat room
  void joinChat(String chatId, String chatType) {
    _socket.emit('joinChat', {
      'chatId': chatId,
      'chatType': chatType,
    });
    debugPrint('Join chat event emitted for chatId: $chatId, chatType: $chatType');
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
    _socket.emit('sendMessage', {
      'chatId': chatId,
      'senderId': senderId,
      'receiverId': receiverId,
      'messageType': messageType,
      'content': content,
      'files': files,
    });
    debugPrint('Send message event emitted: $content');
  }

  /// Handle the receipt of a message and emit acknowledgment
  void onMessageReceived(dynamic data) {
    debugPrint('Message received: $data');
    if (data != null && data['chatId'] != null && data['messageId'] != null) {
      _socket.emit('messageReceived', {
        'chatId': data['chatId'],
        'messageId': data['messageId'],
      });
      debugPrint('Message acknowledgment sent for messageId: ${data['messageId']}');
    } else {
      debugPrint('Invalid message data received');
    }
  }

  /// Retrieve all chat messages with pagination
  // void getAllChatMessages({
  //   required String chatId,
  //   required int page,
  //   required int limit,
  //   required Function(dynamic) onSuccess,
  //   required Function(String) onError,
  // }) {
  //   // socket.emit('getAllChatMessages', {
  //   //   'chatId': chatId,
  //   //   'page': page,
  //   //   'limit': limit,
  //   // });
  //   socket.emit(
  //     'getAllChatMessages',[
  //     {
  //       'chatId': chatId,
  //       'page': page,
  //       'limit': limit,
  //     },
  //         (response) {
  //       // Handle the response from the server
  //       if (response['success'] == true) {
  //         debugPrint('Messages fetched: ${response['data']}');
  //         onSuccess(response['data']);
  //       } else {
  //         debugPrint('Error fetching messages: ${response['error']}');
  //         onError(response['error'] ?? 'Unknown error');
  //       }
  //     },]
  //   );
  //
  //   // Listen for the server's response
  //   _socket.on('getAllChatMessages', (response) {
  //       debugPrint("sda ${response['data']}");
  //     if (response['success'] == true) {
  //       onSuccess(response['data']);
  //     } else {
  //       onError(response['error'] ?? 'Unknown error');
  //     }
  //   });
  //
  //   debugPrint('Get all chat messages event emitted for chatId: $chatId');
  // }
  void getAllChatMessages({
    required String chatId,
    required int page,
    required int limit,
    required Function(dynamic) onSuccess,
    required Function(String) onError,
  }) {
    final payload = {
      'chatId': chatId,
      'page': page,
      'limit': limit,
    };

    debugPrint('Emitting getAllChatMessages with payload: $payload');

    // Emit the event with a response listener
    socket.emitWithAck('getAllChatMessages', payload, ack: (response) {
      if (response == null) {
        onError('No response from server.');
        return;
      }

      debugPrint('Acknowledgment received from server: $response');

      if (response['success'] == true) {
        onSuccess(response['data']);
      } else {
        onError(response['error'] ?? 'Unknown error');
      }
    });
  }

  /// Disconnect the socket connection
  void disconnectSocket() {
    _socket.disconnect();
    debugPrint('Socket disconnected manually');
  }
}
