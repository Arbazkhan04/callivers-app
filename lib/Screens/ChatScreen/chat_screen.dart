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

import 'dart:async';
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
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController controller = TextEditingController();
  List<Map<String, dynamic>> messages = [];
  late StreamSubscription<Map<String, dynamic>> socketSubscription;
  int currentPage = 1;
  final int limit = 10;
  bool isLoading = false;
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    joinChatRoom();
    // Schedule fetchMessages to run after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchMessages();
    });

    // Listen to the socket stream
    socketSubscription = streamSocket.getResponse.listen((data) {
      handleIncomingMessage(data);
    });
  }

  // Join the chat room
  void joinChatRoom() {
    streamSocket.emitJoinChat(widget.chatId, 'one-to-one');
  }

  // Handle incoming messages
  void handleIncomingMessage(Map<String, dynamic> data) {
    if (data['chatId'] == widget.chatId) {
      setState(() {
        messages.add({
          'message': data['content'] ?? '',
          'time': DateTime.now().toString(),
          'isMe': data['senderId'] == widget.senderId,
          'hasImage': data['messageType'] == 'media',
          'imageUrl': data['content'] ?? '',
          'quotedMessage': data['quotedMessage'] ?? '',
          'isRead': data['isRead'] ?? false,
          'hasVoiceMessage': data['hasVoiceMessage'] ?? false,
          'voiceDuration': data['voiceDuration'] ?? '',
          'messageId': data['messageId'] ?? '',
        });
      });
    }
  }

  // Fetch messages with pagination
  Future<void> fetchMessages() async {
    if (isLoading || !hasMore) return;
    setState(() {
      isLoading = true;
    });

    try {
      Map<String, dynamic> response = await streamSocket.getAllChatMessages(
        chatId: widget.chatId,
        page: currentPage,
        limit: limit,
      );

      print('Fetched messages response: $response'); // Debug statement

      // if (response['success'] && response['data'] != null) {
      //   List<dynamic> fetchedMessages = response['data']['messages'];
      //   int totalMessages = response['data']['totalMessages'];
      //   int totalPages = response['data']['totalPages'];
      //   print("objectDDA -> ${fetchedMessages}");
      //   setState(() {
      //     messages = fetchedMessages.map((msg) {
      //       if (msg is Map<String, dynamic>) {
      //         return {
      //           'message': msg['content'] ?? '',
      //           'time': msg['createdAt'] ?? DateTime.now().toString(),
      //           'isMe': msg['senderId'] == widget.senderId,
      //           'hasImage': msg['messageType'] == 'media',
      //           'imageUrl': msg['content'] ?? '',
      //           'quotedMessage': msg['quotedMessage'] ?? '',
      //           'isRead': msg['isRead'] ?? false,
      //           'hasVoiceMessage': msg['hasVoiceMessage'] ?? false,
      //           'voiceDuration': msg['voiceDuration'] ?? '',
      //           'messageId': msg['messageId'] ?? '',
      //         };
      //       } else {
      //         return {
      //           'message': 'Invalid message format',
      //           'time': DateTime.now().toString(),
      //           'isMe': false,
      //           'hasImage': false,
      //           'imageUrl': '',
      //           'quotedMessage': '',
      //           'isRead': false,
      //           'hasVoiceMessage': false,
      //           'voiceDuration': '',
      //           'messageId': '',
      //         };
      //       }
      //     }).toList()
      //       ..addAll(messages); // Prepend fetched messages
      //
      //     currentPage++;
      //     hasMore = currentPage <= totalPages;
      //   });
      // } else {
      //   print('Failed to fetch messages: ${response['error']}');
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text('Failed to fetch messages: ${response['error']}')),
      //   );
      // }
    } catch (e) {
      print('Error fetching messages: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching messages: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Send a message
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

    controller.clear();
  }

  @override
  void dispose() {
    socketSubscription.cancel();
    controller.dispose();
    super.dispose();
  }

  // Load more messages when pulling to refresh
  Future<void> _onRefresh() async {
    await fetchMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7FC),
      body: SafeArea(
        child: Column(
          children: [
            ChatHeader(item: widget.item),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _onRefresh,
                child: ListView.builder(
                  reverse: true, // To display latest messages at the bottom
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  itemCount: messages.length + (hasMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == messages.length) {
                      // Loader item
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final msg = messages[messages.length - 1 - index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: MessageBubble(
                        message: msg['message'],
                        time: msg['time'],
                        isMe: msg['isMe'],
                        hasImage: msg['hasImage'],
                        imageUrl: msg['imageUrl'],
                        quotedMessage: msg['quotedMessage'],
                        isRead: msg['isRead'],
                        hasVoiceMessage: msg['hasVoiceMessage'],
                        voiceDuration: msg['voiceDuration'],
                      ),
                    );
                  },
                ),
              ),
            ),
            buildChatInput(),
          ],
        ),
      ),
    );
  }

  // Build the chat input widget
  Widget buildChatInput() {
    return Container(
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
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.emoji_emotions_outlined),
                    onPressed: () {},
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
                          fontSize: 14,
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
          SizedBox(width: 8),
          SizedBox(
            width: 48,
            height: 48,
            child: CustomIconButton(
              onPressed: sendMessage,
              icon: CircleAvatar(
                backgroundColor: mainColor,
                radius: 24,
                child: Icon(Icons.send, color: whiteColor, size: 20),
              ),
              backgroundColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
