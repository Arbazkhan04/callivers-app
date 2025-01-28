// import 'dart:core';
//
// import 'package:flutter/foundation.dart'
//     show debugDefaultTargetPlatformOverride;
import 'dart:convert';

import 'package:calliverse/Constants/app_config.dart';
import 'package:calliverse/Provider/authen_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

// class WebRTCHomePage extends StatefulWidget {
//   @override
//   _WebRTCHomePageState createState() => _WebRTCHomePageState();
// }
//
// class _WebRTCHomePageState extends State<WebRTCHomePage> {
//   final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
//
//   @override
//   void initState() {
//     super.initState();
//     initRenderers();
//     _getUserMedia();
//   }
//
//   @override
//   void dispose() {
//     _localRenderer.dispose();
//     super.dispose();
//   }
//
//   Future<void> initRenderers() async {
//     await _localRenderer.initialize();
//   }
//
//   Future<void> _getUserMedia() async {
//     final Map<String, dynamic> mediaConstraints = {
//       'audio': true,
//       'video': {
//         'facingMode': 'user',
//       },
//     };
//
//     try {
//       MediaStream stream =
//       await navigator.mediaDevices.getUserMedia(mediaConstraints);
//       _localRenderer.srcObject = stream;
//       setState(() {});
//     } catch (e) {
//       print('Error accessing user media: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter WebRTC Example'),
//       ),
//       body: Center(
//         child: _localRenderer.srcObject != null
//             ? RTCVideoView(_localRenderer, mirror: true)
//             : Text('Loading video...'),
//       ),
//     );
//   }
// }
// Home Page to create or join a room
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
// import 'call_page.dart'; // Ensure this path is correct

// home_page.dart
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'call_page.dart'; // Ensure this path is correct

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _roomController = TextEditingController();
  final uuid = Uuid();

  // Replace this with the token you generated
  // final String jwtToken = 'YOUR_GENERATED_JWT_TOKEN_HERE';
  final String staticToken = 'testtoken123';
  void _createRoom() {
    final provider = Provider.of<AuthenProvider>(context,listen: false);
    String roomId = uuid.v4().substring(0, 6); // Short unique room ID
    print("roomId $roomId");
    print("roomTokenId ${provider.userInfoData?.token ?? ""}");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CallPage(
          roomId: roomId,
          isCreator: true,
          jwtToken: staticToken,
        ),
      ),
    );
  }

  void _joinRoom() {
    final provider = Provider.of<AuthenProvider>(context,listen: false);

    String roomId = _roomController.text.trim();
    if (roomId.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage(
            roomId: roomId,
            isCreator: false,
            jwtToken: staticToken,

          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a room ID')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter WebRTC Chat'),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: _createRoom,
                child: Text('Create Room'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _roomController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Room ID',
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _joinRoom,
                child: Text('Join Room'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ));
  }
}


// class CallPage extends StatefulWidget {
//   final String roomId;
//   final bool isCreator;
//
//   CallPage({required this.roomId, required this.isCreator});
//
//   @override
//   _CallPageState createState() => _CallPageState();
// }
//
// class _CallPageState extends State<CallPage> {
//   late WebSocketChannel _channel;
//   RTCVideoRenderer _localRenderer = RTCVideoRenderer();
//   RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
//
//   RTCPeerConnection? _peerConnection;
//   MediaStream? _localStream;
//
//   final Map<String, dynamic> _iceServers = {
//     'iceServers': [
//       {'urls': 'stun:stun.l.google.com:19302'},
//       // You can add TURN servers here if needed
//     ]
//   };
//
//   bool _isCameraOn = true;
//   bool _isConnected = false;
//
//   @override
//   void initState() {
//     super.initState();
//     initRenderers();
//     connectToSignalingServer();
//   }
//
//   @override
//   void dispose() {
//     _localRenderer.dispose();
//     _remoteRenderer.dispose();
//     _peerConnection?.close();
//     _channel.sink.close();
//     _localStream?.dispose();
//     super.dispose();
//   }
//
//   Future<void> initRenderers() async {
//     await _localRenderer.initialize();
//     await _remoteRenderer.initialize();
//   }
//
//   void connectToSignalingServer() {
//     // Replace 'localhost' with your server IP or domain
//     _channel = IOWebSocketChannel.connect('ws://$mIpURL:8080');
//
//     _channel.stream.listen((message) {
//       print('Received message: $message');
//       Map<String, dynamic> data = jsonDecode(message);
//       switch (data['type']) {
//         case 'new-peer':
//           if (widget.isCreator) {
//             _createOffer();
//           }
//           break;
//         case 'offer':
//           _handleOffer(data['payload']);
//           break;
//         case 'answer':
//           _handleAnswer(data['payload']);
//           break;
//         case 'candidate':
//           _handleCandidate(data['payload']);
//           break;
//         case 'peer-disconnected':
//           _onPeerDisconnected();
//           break;
//         default:
//           break;
//       }
//     }, onDone: () {
//       print('WebSocket closed');
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Disconnected from signaling server')),
//         );
//       }
//     }, onError: (error) {
//       print('WebSocket error: $error');
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error connecting to signaling server')),
//         );
//       }
//     });
//
//     // After connecting, join the room
//     _joinRoom();
//   }
//
//   void _joinRoom() {
//     Map<String, dynamic> message = {
//       'type': 'join',
//       'room': widget.roomId,
//       'payload': {},
//     };
//     _channel.sink.add(jsonEncode(message));
//   }
//
//   Future<void> _createOffer() async {
//     await _createPeerConnection();
//     RTCSessionDescription offer = await _peerConnection!.createOffer();
//     await _peerConnection!.setLocalDescription(offer);
//
//     // Send the offer to the signaling server
//     Map<String, dynamic> message = {
//       'type': 'offer',
//       'room': widget.roomId,
//       'payload': offer.toMap(),
//     };
//     _channel.sink.add(jsonEncode(message));
//   }
//
//   Future<void> _handleOffer(Map<String, dynamic> offer) async {
//     await _createPeerConnection();
//     await _peerConnection!.setRemoteDescription(
//         RTCSessionDescription(offer['sdp'], offer['type']));
//     RTCSessionDescription answer = await _peerConnection!.createAnswer();
//     await _peerConnection!.setLocalDescription(answer);
//
//     // Send the answer back to the signaling server
//     Map<String, dynamic> message = {
//       'type': 'answer',
//       'room': widget.roomId,
//       'payload': answer.toMap(),
//     };
//     _channel.sink.add(jsonEncode(message));
//   }
//
//   Future<void> _handleAnswer(Map<String, dynamic> answer) async {
//     await _peerConnection!.setRemoteDescription(
//         RTCSessionDescription(answer['sdp'], answer['type']));
//   }
//
//   Future<void> _handleCandidate(Map<String, dynamic> candidate) async {
//     RTCIceCandidate iceCandidate = RTCIceCandidate(
//       candidate['candidate'],
//       candidate['sdpMid'],
//       candidate['sdpMLineIndex'],
//     );
//     await _peerConnection!.addCandidate(iceCandidate);
//   }
//
//   Future<void> _createPeerConnection() async {
//     _peerConnection =
//     await createPeerConnection(_iceServers, {'mandatory': {}, 'optional': []});
//
//     // Get user media
//     _localStream = await _getUserMedia();
//     _localRenderer.srcObject = _localStream;
//
//     // Add all tracks to the peer connection
//     _localStream?.getTracks().forEach((track) {
//       _peerConnection!.addTrack(track, _localStream!);
//     });
//
//     // Listen for remote streams
//     _peerConnection!.onTrack = (RTCTrackEvent event) {
//       if (event.track.kind == 'video') {
//         setState(() {
//           _remoteRenderer.srcObject = event.streams[0];
//         });
//       }
//     };
//
//     // Listen for ICE candidates
//     _peerConnection!.onIceCandidate = (RTCIceCandidate candidate) {
//       if (candidate.candidate != null) {
//         Map<String, dynamic> message = {
//           'type': 'candidate',
//           'room': widget.roomId,
//           'payload': {
//             'candidate': candidate.candidate,
//             'sdpMid': candidate.sdpMid,
//             'sdpMLineIndex': candidate.sdpMLineIndex,
//           },
//         };
//         _channel.sink.add(jsonEncode(message));
//       }
//     };
//
//     // Listen for connection state changes
//     _peerConnection!.onConnectionState = (RTCPeerConnectionState state) {
//       print('Connection state: $state');
//       if (state == RTCPeerConnectionState.RTCPeerConnectionStateConnected) {
//         setState(() {
//           _isConnected = true;
//         });
//       } else if (state == RTCPeerConnectionState.RTCPeerConnectionStateDisconnected ||
//           state == RTCPeerConnectionState.RTCPeerConnectionStateFailed ||
//           state == RTCPeerConnectionState.RTCPeerConnectionStateClosed) {
//         _onPeerDisconnected();
//       }
//     };
//   }
//
//   Future<MediaStream> _getUserMedia() async {
//     final Map<String, dynamic> mediaConstraints = {
//       'audio': true,
//       'video': {
//         'facingMode': 'user',
//       },
//     };
//
//     MediaStream stream =
//     await navigator.mediaDevices.getUserMedia(mediaConstraints);
//     return stream;
//   }
//
//   void _onPeerDisconnected() {
//     // Handle peer disconnection
//     setState(() {
//       _remoteRenderer.srcObject = null;
//       _isConnected = false;
//     });
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Peer disconnected')),
//     );
//   }
//
//   void _toggleCamera() async {
//     if (_localStream == null) return;
//     bool enabled = !_isCameraOn;
//     _localStream!.getVideoTracks().forEach((track) {
//       track.enabled = enabled;
//     });
//     setState(() {
//       _isCameraOn = enabled;
//     });
//   }
//
//   void _endCall() {
//     // Close peer connection and WebSocket
//     _peerConnection?.close();
//     _channel.sink.close();
//
//     // Navigate back to HomePage
//     Navigator.popUntil(context, (route) => route.isFirst);
//   }
//
//   void _leaveRoom() {
//     // Notify the signaling server about leaving
//     Map<String, dynamic> message = {
//       'type': 'leave',
//       'room': widget.roomId,
//       'payload': {},
//     };
//     _channel.sink.add(jsonEncode(message));
//
//     // Close peer connection and WebSocket
//     _peerConnection?.close();
//     _channel.sink.close();
//
//     // Navigate back to HomePage
//     Navigator.popUntil(context, (route) => route.isFirst);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Room ID: ${widget.roomId}'),
//           actions: [
//             IconButton(
//               icon: Icon(Icons.call_end),
//               onPressed: _endCall,
//               tooltip: 'End Call',
//               color: Colors.red,
//             ),
//           ],
//         ),
//         body: Stack(
//           children: [
//             Column(
//               children: [
//                 Expanded(
//                   child: RTCVideoView(
//                     _remoteRenderer,
//                     objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
//                     mirror: false,
//                   ),
//                 ),
//                 Container(
//                   height: 150,
//                   color: Colors.black54,
//                   child: RTCVideoView(
//                     _localRenderer,
//                     mirror: true,
//                   ),
//                 ),
//               ],
//             ),
//             Positioned(
//               bottom: 20,
//               left: 20,
//               right: 20,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   FloatingActionButton(
//                     heroTag: 'camera',
//                     onPressed: _toggleCamera,
//                     backgroundColor: _isCameraOn ? Colors.blue : Colors.grey,
//                     child: Icon(
//                       _isCameraOn ? Icons.videocam : Icons.videocam_off,
//                     ),
//                     tooltip: _isCameraOn ? 'Turn Camera Off' : 'Turn Camera On',
//                   ),
//                   FloatingActionButton(
//                     heroTag: 'leave',
//                     onPressed: _leaveRoom,
//                     backgroundColor: Colors.orange,
//                     child: Icon(Icons.exit_to_app),
//                     tooltip: 'Leave Room',
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ));
//   }
// }

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//
//   final TextEditingController _roomController = TextEditingController();
//   final uuid = Uuid();
//
//   void _createRoom() {
//     String roomId = uuid.v4().substring(0, 6); // Short unique room ID
//     print("roomId $roomId");
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => CallPage(
//           roomId: roomId,
//           isCreator: true,
//         ),
//       ),
//     );
//   }
//
//   void _joinRoom() {
//     String roomId = _roomController.text.trim();
//     if (roomId.isNotEmpty) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => CallPage(
//             roomId: roomId,
//             isCreator: false,
//           ),
//         ),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please enter a room ID')),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Flutter WebRTC Chat'),
//         ),
//         body: Padding(
//           padding: EdgeInsets.all(20),
//           child: Column(
//             children: [
//               ElevatedButton(
//                 onPressed: _createRoom,
//                 child: Text('Create Room'),
//               ),
//               SizedBox(height: 20),
//               TextField(
//                 controller: _roomController,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Room ID',
//                 ),
//               ),
//               SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: _joinRoom,
//                 child: Text('Join Room'),
//               ),
//             ],
//           ),
//         ));
//   }
// }
//
// // Call Page to handle WebRTC connection
// class CallPage extends StatefulWidget {
//   final String roomId;
//   final bool isCreator;
//
//   CallPage({required this.roomId, required this.isCreator});
//
//   @override
//   _CallPageState createState() => _CallPageState();
// }
//
// class _CallPageState extends State<CallPage> {
//   late WebSocketChannel _channel;
//   RTCVideoRenderer _localRenderer = RTCVideoRenderer();
//   RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
//
//   RTCPeerConnection? _peerConnection;
//   MediaStream? _localStream;
//
//   final Map<String, dynamic> _iceServers = {
//     'iceServers': [
//       {'urls': 'stun:stun.l.google.com:19302'},
//     ]
//   };
//
//   @override
//   void initState() {
//     super.initState();
//     initRenderers();
//     connectToSignalingServer();
//   }
//
//   @override
//   void dispose() {
//     _localRenderer.dispose();
//     _remoteRenderer.dispose();
//     _peerConnection?.close();
//     _channel.sink.close();
//     super.dispose();
//   }
//
//   Future<void> initRenderers() async {
//     await _localRenderer.initialize();
//     await _remoteRenderer.initialize();
//   }
//
//   void connectToSignalingServer() {
//     // Replace 'localhost' with your server IP if testing on real devices
//     _channel = IOWebSocketChannel.connect('ws://$mIpURL:8080');
//
//     _channel.stream.listen((message) {
//       print('Received message: $message');
//       Map<String, dynamic> data = jsonDecode(message);
//       switch (data['type']) {
//         case 'new-peer':
//           if (widget.isCreator) {
//             _createOffer();
//           }
//           break;
//         case 'offer':
//           _handleOffer(data['payload']);
//           break;
//         case 'answer':
//           _handleAnswer(data['payload']);
//           break;
//         case 'candidate':
//           _handleCandidate(data['payload']);
//           break;
//         case 'peer-disconnected':
//           _onPeerDisconnected();
//           break;
//         default:
//           break;
//       }
//     }, onDone: () {
//       print('WebSocket closed');
//     }, onError: (error) {
//       print('WebSocket error: $error');
//     });
//
//     // After connecting, join the room
//     _joinRoom();
//   }
//
//   void _joinRoom() {
//     Map<String, dynamic> message = {
//       'type': 'join',
//       'room': widget.roomId,
//       'payload': {},
//     };
//     _channel.sink.add(jsonEncode(message));
//   }
//
//   Future<void> _createOffer() async {
//     await _createPeerConnection();
//     RTCSessionDescription offer = await _peerConnection!.createOffer();
//     await _peerConnection!.setLocalDescription(offer);
//
//     // Send the offer to the signaling server
//     Map<String, dynamic> message = {
//       'type': 'offer',
//       'room': widget.roomId,
//       'payload': offer.toMap(),
//     };
//     _channel.sink.add(jsonEncode(message));
//   }
//
//   Future<void> _handleOffer(Map<String, dynamic> offer) async {
//     await _createPeerConnection();
//     await _peerConnection!.setRemoteDescription(
//         RTCSessionDescription(offer['sdp'], offer['type']));
//     RTCSessionDescription answer = await _peerConnection!.createAnswer();
//     await _peerConnection!.setLocalDescription(answer);
//
//     // Send the answer back to the signaling server
//     Map<String, dynamic> message = {
//       'type': 'answer',
//       'room': widget.roomId,
//       'payload': answer.toMap(),
//     };
//     _channel.sink.add(jsonEncode(message));
//   }
//
//   Future<void> _handleAnswer(Map<String, dynamic> answer) async {
//     await _peerConnection!.setRemoteDescription(
//         RTCSessionDescription(answer['sdp'], answer['type']));
//   }
//
//   Future<void> _handleCandidate(Map<String, dynamic> candidate) async {
//     RTCIceCandidate iceCandidate = RTCIceCandidate(
//       candidate['candidate'],
//       candidate['sdpMid'],
//       candidate['sdpMLineIndex'],
//     );
//     await _peerConnection!.addCandidate(iceCandidate);
//   }
//
//   Future<void> _createPeerConnection() async {
//     _peerConnection =
//     await createPeerConnection(_iceServers, {'mandatory': {}, 'optional': []});
//
//     // Get user media
//     _localStream = await _getUserMedia();
//     _localRenderer.srcObject = _localStream;
//
//     // Add all tracks to the peer connection
//     _localStream?.getTracks().forEach((track) {
//       _peerConnection!.addTrack(track, _localStream!);
//     });
//
//     // Listen for remote streams
//     _peerConnection!.onTrack = (RTCTrackEvent event) {
//       if (event.track.kind == 'video') {
//         _remoteRenderer.srcObject = event.streams[0];
//       }
//     };
//
//     // Listen for ICE candidates
//     _peerConnection!.onIceCandidate = (RTCIceCandidate candidate) {
//       if (candidate.candidate != null) {
//         Map<String, dynamic> message = {
//           'type': 'candidate',
//           'room': widget.roomId,
//           'payload': {
//             'candidate': candidate.candidate,
//             'sdpMid': candidate.sdpMid,
//             'sdpMLineIndex': candidate.sdpMLineIndex,
//           },
//         };
//         _channel.sink.add(jsonEncode(message));
//       }
//     };
//   }
//
//   Future<MediaStream> _getUserMedia() async {
//     final Map<String, dynamic> mediaConstraints = {
//       'audio': true,
//       'video': {
//         'facingMode': 'user',
//       },
//     };
//
//     MediaStream stream =
//     await navigator.mediaDevices.getUserMedia(mediaConstraints);
//     return stream;
//   }
//
//   void _onPeerDisconnected() {
//     // Handle peer disconnection
//     _remoteRenderer.srcObject = null;
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Peer disconnected')),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Room ID: ${widget.roomId}'),
//         ),
//         body: Column(
//           children: [
//             Expanded(
//               child: RTCVideoView(_localRenderer, mirror: true),
//             ),
//             Expanded(
//               child: RTCVideoView(_remoteRenderer),
//             ),
//           ],
//         ));
//   }
// }