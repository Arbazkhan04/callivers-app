import 'dart:io';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

// class ChatApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(home: ChatScreen());
//   }
// }


class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late IO.Socket socket;
  final TextEditingController _messageController = TextEditingController();
  List<Map<String, dynamic>> messages = [];
  final ImagePicker _picker = ImagePicker();
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool _isRecording = false;

  String userId = 'user1'; // Simulated user ID
  String receiverId = 'user2';

  @override
  void initState() {
    super.initState();
    _connectSocket();
    _initRecorder();
  }

  void _connectSocket() {
    try {
      // socket = IO.io('http://localhost:3003', IO.OptionBuilder()
      //     .setTransports(['websocket'])
      //     .disableAutoConnect()
      //     .build());
      //
      // socket.connect();
      //
      // socket.onConnect((_) {
      //   print('Connected');
      //   socket.emit('join', userId);
      // });
      //
      // socket.on('receiveMessage', (data) {
      //   setState(() {
      //     messages.add({'type': 'text', 'message': data['message'], 'sender': data['senderId']});
      //   });
      // });
      //
      // socket.onConnectError((data) => print('Connection Error: $data'));
      // socket.onError((data) => print('Socket Error: $data'));
      // Dart client
       socket = io('http://localhost:3003',
          OptionBuilder()
              .setTransports(['websocket']) // for Flutter or Dart VM
              .disableAutoConnect()  // disable auto-connection
              .setExtraHeaders({'foo': 'bar'}) // optional
              .build()
      );
      socket.connect();
    } catch (e, stack) {
      print('Socket Connection Error: $e\n$stack');
    }
  }

  Future<void> _initRecorder() async {
    try {
      await _recorder.openRecorder();
    } catch (e, stack) {
      print('Recorder Initialization Error: $e\n$stack');
    }
  }

  void _sendTextMessage() {
    try {
      final message = _messageController.text;
      if (message.isNotEmpty) {
        socket.emit('sendMessage', {'senderId': userId, 'receiverId': receiverId, 'message': message});
        setState(() {
          messages.add({'type': 'text', 'message': message, 'sender': userId});
        });
        _messageController.clear();
      }
    } catch (e, stack) {
      print('Send Text Message Error: $e\n$stack');
    }
  }

  Future<void> _sendImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        String filePath = image.path;
        FormData formData = FormData.fromMap({'file': await MultipartFile.fromFile(filePath)});
        Response response = await Dio().post('http://localhost:3003/upload', data: formData);
        String imageUrl = response.data['url'];

        socket.emit('sendMessage', {'senderId': userId, 'receiverId': receiverId, 'message': imageUrl});
        setState(() {
          messages.add({'type': 'image', 'message': imageUrl, 'sender': userId});
        });
      }
    } catch (e, stack) {
      print('Send Image Error: $e\n$stack');
    }
  }

  Future<void> _recordVoice() async {
    try {
      if (!_isRecording) {
        final directory = await getApplicationDocumentsDirectory();
        String filePath = '${directory.path}/voice.aac';
        await _recorder.startRecorder(toFile: filePath);
        setState(() => _isRecording = true);
      } else {
        final filePath = await _recorder.stopRecorder();
        setState(() => _isRecording = false);

        FormData formData = FormData.fromMap({'file': await MultipartFile.fromFile(filePath!)});
        Response response = await Dio().post('http://localhost:3003/upload', data: formData);
        String voiceUrl = response.data['url'];

        socket.emit('sendMessage', {'senderId': userId, 'receiverId': receiverId, 'message': voiceUrl});
        setState(() {
          messages.add({'type': 'voice', 'message': voiceUrl, 'sender': userId});
        });
      }
    } catch (e, stack) {
      print('Record Voice Error: $e\n$stack');
    }
  }

  Widget _buildMessage(Map<String, dynamic> msg) {
    try {
      if (msg['type'] == 'text') {
        return Text(msg['message']);
      } else if (msg['type'] == 'image') {
        return Image.network(msg['message'], height: 150, width: 150, errorBuilder: (context, error, stackTrace) {
          print('Image Load Error: $error');
          return Icon(Icons.broken_image);
        });
      } else if (msg['type'] == 'voice') {
        return IconButton(
          icon: Icon(Icons.play_arrow),
          onPressed: () {
            try {
              FlutterSoundPlayer().startPlayer(fromURI: msg['message']);
            } catch (e, stack) {
              print('Play Voice Error: $e\n$stack');
            }
          },
        );
      }
      return SizedBox.shrink();
    } catch (e, stack) {
      print('Build Message Error: $e\n$stack');
      return Text('Error displaying message.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (_, i) => _buildMessage(messages[i]),
            ),
          ),
          Row(
            children: [
              IconButton(icon: Icon(Icons.image), onPressed: _sendImage),
              IconButton(icon: Icon(_isRecording ? Icons.stop : Icons.mic), onPressed: _recordVoice),
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(hintText: 'Message'),
                ),
              ),
              IconButton(icon: Icon(Icons.send), onPressed: _sendTextMessage),
            ],
          )
        ],
      ),
    );
  }
}