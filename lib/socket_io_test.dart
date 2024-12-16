// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'package:image_picker/image_picker.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter_sound/flutter_sound.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:socket_io_client/socket_io_client.dart';
//
//
// //
// // class ChatScreen extends StatefulWidget {
// //   @override
// //   _ChatScreenState createState() => _ChatScreenState();
// // }
// //
// // class _ChatScreenState extends State<ChatScreen> {
// //   late IO.Socket socket;
// //   final TextEditingController _messageController = TextEditingController();
// //   List<Map<String, dynamic>> messages = [];
// //   final ImagePicker _picker = ImagePicker();
// //   final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
// //   bool _isRecording = false;
// //
// //   String userId = 'user1'; // Simulated user ID
// //   String receiverId = 'user2';
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _connectSocket();
// //     _initRecorder();
// //   }
// //
// //   void _connectSocket() {
// //     try {
// //       // socket = IO.io('http://localhost:3003', IO.OptionBuilder()
// //       //     .setTransports(['websocket'])
// //       //     .disableAutoConnect()
// //       //     .build());
// //       //
// //       // socket.connect();
// //       //
// //       // socket.onConnect((_) {
// //       //   print('Connected');
// //       //   socket.emit('join', userId);
// //       // });
// //       //
// //       // socket.on('receiveMessage', (data) {
// //       //   setState(() {
// //       //     messages.add({'type': 'text', 'message': data['message'], 'sender': data['senderId']});
// //       //   });
// //       // });
// //       //
// //       // socket.onConnectError((data) => print('Connection Error: $data'));
// //       // socket.onError((data) => print('Socket Error: $data'));
// //       // Dart client
// //        socket = io('http://localhost:3003',
// //           OptionBuilder()
// //               .setTransports(['websocket']) // for Flutter or Dart VM
// //               .disableAutoConnect()  // disable auto-connection
// //               .setExtraHeaders({'foo': 'bar'}) // optional
// //               .build()
// //       );
// //       socket.connect();
// //       // socket
// //     } catch (e, stack) {
// //       print('Socket Connection Error: $e\n$stack');
// //     }
// //   }
// //
// //   Future<void> _initRecorder() async {
// //     try {
// //       await _recorder.openRecorder();
// //     } catch (e, stack) {
// //       print('Recorder Initialization Error: $e\n$stack');
// //     }
// //   }
// //
// //   void _sendTextMessage() {
// //     try {
// //       final message = _messageController.text;
// //       if (message.isNotEmpty) {
// //         socket.emit('sendMessage', {'senderId': userId, 'receiverId': receiverId, 'message': message});
// //         setState(() {
// //           messages.add({'type': 'text', 'message': message, 'sender': userId});
// //         });
// //         _messageController.clear();
// //       }
// //     } catch (e, stack) {
// //       print('Send Text Message Error: $e\n$stack');
// //     }
// //   }
// //
// //   Future<void> _sendImage() async {
// //     try {
// //       final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
// //       if (image != null) {
// //         String filePath = image.path;
// //         FormData formData = FormData.fromMap({'file': await MultipartFile.fromFile(filePath)});
// //         Response response = await Dio().post('http://localhost:3003/upload', data: formData);
// //         String imageUrl = response.data['url'];
// //
// //         socket.emit('sendMessage', {'senderId': userId, 'receiverId': receiverId, 'message': imageUrl});
// //         setState(() {
// //           messages.add({'type': 'image', 'message': imageUrl, 'sender': userId});
// //         });
// //       }
// //     } catch (e, stack) {
// //       print('Send Image Error: $e\n$stack');
// //     }
// //   }
// //
// //   Future<void> _recordVoice() async {
// //     try {
// //       if (!_isRecording) {
// //         final directory = await getApplicationDocumentsDirectory();
// //         String filePath = '${directory.path}/voice.aac';
// //         await _recorder.startRecorder(toFile: filePath);
// //         setState(() => _isRecording = true);
// //       } else {
// //         final filePath = await _recorder.stopRecorder();
// //         setState(() => _isRecording = false);
// //
// //         FormData formData = FormData.fromMap({'file': await MultipartFile.fromFile(filePath!)});
// //         Response response = await Dio().post('http://localhost:3003/upload', data: formData);
// //         String voiceUrl = response.data['url'];
// //
// //         socket.emit('sendMessage', {'senderId': userId, 'receiverId': receiverId, 'message': voiceUrl});
// //         setState(() {
// //           messages.add({'type': 'voice', 'message': voiceUrl, 'sender': userId});
// //         });
// //       }
// //     } catch (e, stack) {
// //       print('Record Voice Error: $e\n$stack');
// //     }
// //   }
// //
// //   Widget _buildMessage(Map<String, dynamic> msg) {
// //     try {
// //       if (msg['type'] == 'text') {
// //         return Text(msg['message']);
// //       } else if (msg['type'] == 'image') {
// //         return Image.network(msg['message'], height: 150, width: 150, errorBuilder: (context, error, stackTrace) {
// //           print('Image Load Error: $error');
// //           return Icon(Icons.broken_image);
// //         });
// //       } else if (msg['type'] == 'voice') {
// //         return IconButton(
// //           icon: Icon(Icons.play_arrow),
// //           onPressed: () {
// //             try {
// //               FlutterSoundPlayer().startPlayer(fromURI: msg['message']);
// //             } catch (e, stack) {
// //               print('Play Voice Error: $e\n$stack');
// //             }
// //           },
// //         );
// //       }
// //       return SizedBox.shrink();
// //     } catch (e, stack) {
// //       print('Build Message Error: $e\n$stack');
// //       return Text('Error displaying message.');
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text('Chat')),
// //       body: Column(
// //         children: [
// //           Expanded(
// //             child: ListView.builder(
// //               itemCount: messages.length,
// //               itemBuilder: (_, i) => _buildMessage(messages[i]),
// //             ),
// //           ),
// //           Row(
// //             children: [
// //               IconButton(icon: Icon(Icons.image), onPressed: _sendImage),
// //               IconButton(icon: Icon(_isRecording ? Icons.stop : Icons.mic), onPressed: _recordVoice),
// //               Expanded(
// //                 child: TextField(
// //                   controller: _messageController,
// //                   decoration: InputDecoration(hintText: 'Message'),
// //                 ),
// //               ),
// //               IconButton(icon: Icon(Icons.send), onPressed: _sendTextMessage),
// //             ],
// //           )
// //         ],
// //       ),
// //     );
// //   }
// // }
//
//

// import 'package:flutter/material.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;
//
// class ChatScreenTest extends StatefulWidget {
//   final String senderId;
//   final String receiverId;
//
//   const ChatScreenTest({Key? key, required this.senderId, required this.receiverId})
//       : super(key: key);
//
//   @override
//   _ChatScreenTestState createState() => _ChatScreenTestState();
// }
//
// class _ChatScreenTestState extends State<ChatScreenTest> {
//   late IO.Socket socket;
//   final TextEditingController _controller = TextEditingController();
//   List<Map<String, dynamic>> messages = [];
//
//   @override
//   void initState() {
//     super.initState();
//     connectSocket();
//   }
//
//   void connectSocket() {
//     socket = IO.io('http://192.168.0.104:3003', <String, dynamic>{
//       'transports': ['websocket'],
//       'autoConnect': false,
//     });
//
//     socket.connect();
//
//     socket.onConnect((_) {
//       print('Connected to the server');
//     });
//
//     // Listen for previous messages
//     socket.on('receiveMessage', (data) {
//       if (data is List) {
//         setState(() {
//           messages = data
//               .map((msg) => {
//           'chatId': msg["0"],
//           'senderId': msg[widget.senderId],
//           'receiverId': msg[widget.receiverId],
//           'messageType': msg["text"],
//           'content': msg[_controller.text],
//           "files" : ""
//             // 'senderId': msg['senderId'] ?? '',
//             // 'receiverId': msg['receiverId'] ?? '',
//             // 'message': msg['message'] ?? '',
//           })
//               .toList();
//         });
//       }
//     });
//     socket.emit("joinChat", {
//       "chatId": "675d7466bef3490642f6c863",
//       "chatType": "one-to-one" // e.g., "one-to-one"
//
//       // 'chatType': chatType,
//     });
//     socket.emit("getAllChatMessages", {
//       "chatId": "675d7466bef3490642f6c863",
//       "page": "1", // e.g., "one-to-one"
//       "limit": "10" // e.g., "one-to-one"
//
//       // 'chatType': chatType,
//     });
//
//     // Listen for private messages
//     socket.on('privateMessage', (data) {
//       if (data is Map) {
//         setState(() {
//           messages.add({
//             'senderId': data['senderId'] ?? '',
//             'receiverId': data['receiverId'] ?? '',
//             'message': data['message'] ?? '',
//           });
//         });
//       }
//     });
//
//     socket.onDisconnect((_) {
//       print('Disconnected from the server');
//     });
//   }
//
//   void sendMessage() {
//     if (_controller.text.isNotEmpty) {
//       socket.emit('sendMessage', {
//         'chatId': "0",
//         'senderId': widget.senderId,
//         'receiverId': widget.receiverId,
//         'messageType': "text",
//         'content': _controller.text,
//         "files" : ""
//       });
//       _controller.clear();
//     }
//   }
//
//   @override
//   void dispose() {
//     socket.disconnect();
//     socket.dispose();
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('${socket.connected} Chat between ${widget.senderId} and ${widget.receiverId}'),
//       ),
//       body: Column(
//         children: [
//           TextButton(onPressed: (){
//             print("object ${messages.length}");
//           }, child: Text("sdS")),
//           Expanded(
//             child: ListView.builder(
//               itemCount: messages.length,
//               itemBuilder: (context, index) {
//                 final msg = messages[index];
//                 return ListTile(
//                   title: Text('${msg['senderId']}: ${msg['content']}'),
//                   subtitle: Text('To: ${msg['receiverId']}'),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _controller,
//                     decoration: const InputDecoration(
//                       labelText: 'Send a message',
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.send),
//                   onPressed: sendMessage,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:async';
import 'main.dart';

class ChatScreenTest extends StatefulWidget {
  final String senderId;
  final String receiverId;

  const ChatScreenTest({Key? key, required this.senderId, required this.receiverId})
      : super(key: key);

  @override
  _ChatScreenTestState createState() => _ChatScreenTestState();
}

class _ChatScreenTestState extends State<ChatScreenTest> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    super.initState();
    connectSocket();
  }

  // void connectSocket() {
  //   socket = IO.io('http://192.168.0.104:3003', <String, dynamic>{
  //     'transports': ['websocket'],
  //     'autoConnect': true,
  //   });
  //
  //   socket.connect();
  //
  //   socket.onConnect((_) {
  //     print('Connected to the server');
  //     socket.emit('userOnline', {"userId": widget.senderId}); // Notify server user is online
  //     joinChatRoom();
  //     fetchMessages();
  //   });
  //
  //   // Listen for incoming messages
  //   socket.on('receiveMessage', (data) {
  //     if (data != null) {
  //       setState(() {
  //         messages.add({
  //           'chatId': data['chatId'] ?? '',
  //           'senderId': data['senderId'] ?? '',
  //           'receiverId': data['receiverId'] ?? '',
  //           'messageType': data['messageType'] ?? '',
  //           'content': data['content'] ?? '',
  //           'files': data['files'] ?? [],
  //         });
  //       });
  //       // Acknowledge receipt of the message
  //       socket.emit('messageReceived', {
  //         'chatId': data['chatId'],
  //         'messageId': data['id']
  //       });
  //     }
  //   });
  //
  //   socket.onDisconnect((_) {
  //     print('Disconnected from the server');
  //   });
  // }

  // StreamSocket streamSocket = StreamSocket();
  void connectSocket() {
    socket.onConnect((_) {
      print('Connected to the server');
      socket.emit('userOnline',  widget.senderId);
      fetchMessages();
    });

    socket.onConnectError((error) {
      print('Connection Error: $error');
    });

    socket.onError((error) {
      print('Socket Error: $error');
    });

    socket.onDisconnect((_) {
      print('Disconnected from the server');
    });

  }

  void fun(){

  }

  void fetchMessages() {
    socket.emitWithAck('getAllChatMessages', {
      "chatId": "675d7466bef3490642f6c863",
      "page": 1,
      "limit": 10,
    }, ack: (response) {
      if (response != null && response['success']) {
        Map<String, dynamic> data = response['data'];
        // Process the fetched messages
        // setState(() {
        //   messages = data.map((msg) => Message.fromJson(msg)).toList();
        // });
        print("dataC -> ${data.length}");
        print('Messages fetched successfully.');
      } else {
        print('Failed to fetch messages: ${response?['error']}');
      }
    },binary: false);
  }

  void sendMessage() {
    if (_controller.text.isNotEmpty) {
      socket.emit('sendMessage', {
        'chatId': "675d7466bef3490642f6c863",
        'senderId': widget.senderId,
        'receiverId': widget.receiverId,
        'messageType': "text",
        'content': _controller.text,
        'files': [],
      });
      _controller.clear();
    }
  }

  @override
  void dispose() {
    // socket.disconnect();
    // socket.dispose();
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat between ${widget.senderId} and ${widget.receiverId}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                return ListTile(
                  title: Text('${msg['senderId']}: ${msg['content']}'),
                  subtitle: Text('To: ${msg['receiverId']}'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Send a message',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
