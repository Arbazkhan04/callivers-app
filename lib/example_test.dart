// import 'package:calliverse/Provider/authen_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_webrtc/flutter_webrtc.dart';
// import 'package:provider/provider.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;
//
// import 'main.dart';
//
//
//
//
// /// Model for call history (mock data)
// class CallHistoryEntry {
//   final String avatarUrl;
//   final String name;
//   final bool isMissed;
//   final String timeAgo;
//
//   CallHistoryEntry({
//     required this.avatarUrl,
//     required this.name,
//     required this.isMissed,
//     required this.timeAgo,
//   });
// }
//
// /// Screen displaying the call list (similar to WhatsApp Calls tab)
// class CallHistoryScreen extends StatefulWidget {
//   const CallHistoryScreen({Key? key}) : super(key: key);
//
//   @override
//   State<CallHistoryScreen> createState() => _CallHistoryScreenState();
// }
//
// class _CallHistoryScreenState extends State<CallHistoryScreen> {
//   // Mock data for demonstration
//   final List<CallHistoryEntry> _calls = [
//     CallHistoryEntry(
//       avatarUrl: 'https://i.pravatar.cc/100?img=1',
//       name: 'Pranav Ray',
//       isMissed: true,
//       timeAgo: '15 min ago',
//     ),
//     CallHistoryEntry(
//       avatarUrl: 'https://i.pravatar.cc/100?img=2',
//       name: 'Lindsey George',
//       isMissed: true,
//       timeAgo: '15 min ago',
//     ),
//     CallHistoryEntry(
//       avatarUrl: 'https://i.pravatar.cc/100?img=3',
//       name: 'Wilson Botosh',
//       isMissed: true,
//       timeAgo: '15 min ago',
//     ),
//     CallHistoryEntry(
//       avatarUrl: 'https://i.pravatar.cc/100?img=4',
//       name: 'Phillip Dorwart',
//       isMissed: true,
//       timeAgo: '15 min ago',
//     ),
//     CallHistoryEntry(
//       avatarUrl: 'https://i.pravatar.cc/100?img=5',
//       name: 'Zaire Vaccaro',
//       isMissed: true,
//       timeAgo: '15 min ago',
//     ),
//     CallHistoryEntry(
//       avatarUrl: 'https://i.pravatar.cc/100?img=6',
//       name: 'Mira Schleifer',
//       isMissed: true,
//       timeAgo: '15 min ago',
//     ),
//     CallHistoryEntry(
//       avatarUrl: 'https://i.pravatar.cc/100?img=7',
//       name: 'Jocelyn Carder',
//       isMissed: true,
//       timeAgo: '15 min ago',
//     ),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Calls'),
//       ),
//       body: ListView.builder(
//         itemCount: _calls.length,
//         itemBuilder: (context, index) {
//           final call = _calls[index];
//           return ListTile(
//             leading: CircleAvatar(
//               backgroundImage: NetworkImage(call.avatarUrl),
//               radius: 24,
//             ),
//             title: Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     call.name,
//                     style: const TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 if (call.isMissed)
//                   const Padding(
//                     padding: EdgeInsets.only(left: 4),
//                     child: Icon(Icons.call_end, color: Colors.red, size: 16),
//                   ),
//               ],
//             ),
//             subtitle: Text(call.timeAgo),
//             trailing: SizedBox(
//               width: 80,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // Video call icon
//                   InkWell(
//                     onTap: () => _startCall(
//                       calleeId: "675b242d98062c96f6a78150",
//                       callType: 'video',
//                     ),
//                     child: const Icon(Icons.video_call, color: Colors.blue),
//                   ),
//                   // Audio call icon
//                   InkWell(
//                     onTap: () => _startCall(
//                       calleeId: "675b242d98062c96f6a78150",
//                       callType: 'audio',
//                     ),
//                     child: const Icon(Icons.call, color: Colors.blue),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // In WhatsApp, this might open "New Call" or contacts
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('New call or Add contact')),
//           );
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
//
//   void _startCall({required String calleeId, required String callType}) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (_) => CallScreen(
//           calleeId: calleeId,
//           callType: callType,
//         ),
//       ),
//     );
//   }
// }
//
// /// The screen that handles the actual call (WebRTC + Socket.io)
// class CallScreen extends StatefulWidget {
//   final String calleeId;   // The person we're calling
//   final String callType;   // 'audio' or 'video'
//
//   const CallScreen({
//     Key? key,
//     required this.calleeId,
//     required this.callType,
//   }) : super(key: key);
//
//   @override
//   State<CallScreen> createState() => _CallScreenState();
// }
//
// class _CallScreenState extends State<CallScreen> {
//   // Socket
//   // late IO.Socket socket;
//
//   // WebRTC
//   RTCPeerConnection? _peerConnection;
//   MediaStream? _localStream;
//   MediaStream? _remoteStream;
//
//   final _localRenderer = RTCVideoRenderer();
//   final _remoteRenderer = RTCVideoRenderer();
//
//   // For demonstration, we treat this device as the "caller"
//   // final String Provider.of<AuthenProvider>(context,listen: false).userInfoData?.userId = Provider.of<AuthenProvider>(context,listen: false).userInfoData.userId;
//   String? _callId;
//
//   bool get _isVideoCall => widget.callType == 'video';
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeRenderers();
//     _connectSocket();
//   }
//
//   Future<void> _initializeRenderers() async {
//     await _localRenderer.initialize();
//     await _remoteRenderer.initialize();
//   }
//
//   @override
//   void dispose() {
//     _localRenderer.dispose();
//     _remoteRenderer.dispose();
//     socket.dispose();
//     _peerConnection?.dispose();
//     super.dispose();
//   }
//
//   /// Connect to Socket.IO server (no third-arg callback used)
//   void _connectSocket() {
//     socket = IO.io(
//       'YOUR_SOCKET_SERVER_URL', // e.g. 'http://192.168.0.100:3000'
//       IO.OptionBuilder()
//           .setTransports(['websocket'])
//           .enableReconnection()
//           .build(),
//     );
//
//     socket.onConnect((_) {
//       debugPrint("Socket connected.");
//       // For demo, immediately initiate a call
//       _initiateCall();
//     });
//
//     // Listen for events from the server
//     socket.on('callRequest', _onCallRequest);
//     socket.on('callAccepted', _onCallAccepted);
//     socket.on('callMissed', _onCallMissed);
//     socket.on('callEnded', _onCallEnded);
//     socket.on('iceCandidate', _onRemoteCandidate);
//
//     socket.connect();
//   }
//
//   /// Create a PeerConnection
//   Future<RTCPeerConnection> _createPeerConnection() async {
//     final config = {
//       'iceServers': [
//         {'urls': 'stun:stun.l.google.com:19302'},
//         // For real usage, add TURN servers
//       ],
//     };
//     final constraints = {
//       'mandatory': {
//         'OfferToReceiveAudio': true,
//         'OfferToReceiveVideo': _isVideoCall,
//       },
//       'optional': [],
//     };
//
//     final pc = await createPeerConnection(config, constraints);
//
//     pc.onIceCandidate = (candidate) {
//       if (candidate != null) {
//         debugPrint("Local ICE candidate: ${candidate.toMap()}");
//         // Send to server (no third arg callback)
//         socket.emit('iceCandidate', {
//           "callId": _callId,
//           "candidate": candidate.candidate,
//           "sdpMid": candidate.sdpMid,
//           "sdpMLineIndex": candidate.sdpMLineIndex,
//         });
//       }
//     };
//
//     pc.onTrack = (event) {
//       if (event.streams.isNotEmpty) {
//         setState(() {
//           _remoteStream = event.streams[0];
//           _remoteRenderer.srcObject = _remoteStream;
//         });
//       }
//     };
//
//     return pc;
//   }
//
//   /// Create local media stream
//   Future<void> _createLocalStream() async {
//     final mediaConstraints = <String, dynamic>{
//       'audio': true,
//       'video': _isVideoCall
//           ? {
//         'mandatory': {
//           'minWidth': 640,
//           'minHeight': 480,
//           'minFrameRate': 30,
//         },
//         'facingMode': 'user',
//         'optional': [],
//       }
//           : false,
//     };
//
//     _localStream = await navigator.mediaDevices.getUserMedia(mediaConstraints);
//     _localRenderer.srcObject = _localStream;
//
//     // Add tracks to peer connection
//     for (var track in _localStream!.getTracks()) {
//       _peerConnection?.addTrack(track, _localStream!);
//     }
//   }
//
//   /// Caller side: initiate the call
//   Future<void> _initiateCall() async {
//     // 1) Create peer connection
//     _peerConnection = await _createPeerConnection();
//
//     // 2) Create local stream
//     await _createLocalStream();
//
//     // 3) Create offer
//     final offer = await _peerConnection!.createOffer();
//     await _peerConnection!.setLocalDescription(offer);
//
//     // 4) Emit 'initiateCall' without callback
//     socket.emit('initiateCall', {
//       "callerId": Provider.of<AuthenProvider>(context,listen: false).userInfoData?.userId,
//       "calleeId": widget.calleeId,
//       "callType": _isVideoCall ? 'video' : 'audio',
//       "offer": offer.sdp,
//       "candidates": [],
//     });
//     // The server will respond with separate events (e.g. callAccepted or callMissed).
//   }
//
//   /// If we are the callee, the server sends 'callRequest'
//   void _onCallRequest(dynamic data) async {
//     /*
//       data = {
//         "callId": ...,
//         "callerId": ...,
//         "callType": ...,
//         "offer": ...,
//         "candidates": ...
//       }
//     */
//     debugPrint("Incoming callRequest: $data");
//
//     setState(() {
//       _callId = data['callId'];
//     });
//
//     // 1) Create PeerConnection if not already created
//     _peerConnection = await _createPeerConnection();
//
//     // 2) Create local stream
//     await _createLocalStream();
//
//     // 3) Set remote description
//     final remoteOffer = RTCSessionDescription(data['offer'], 'offer');
//     await _peerConnection!.setRemoteDescription(remoteOffer);
//
//     // 4) (Optional) add any ICE candidates from data['candidates'] if provided
//
//     // 5) Show incoming call UI or auto-accept. For demonstration => auto-accept:
//     _acceptCall();
//   }
//
//   /// Accept call (callee side)
//   Future<void> _acceptCall() async {
//     if (_peerConnection == null || _callId == null) return;
//
//     // Create answer
//     final answer = await _peerConnection!.createAnswer();
//     await _peerConnection!.setLocalDescription(answer);
//
//     // Emit 'acceptCall' (no 3rd arg)
//     socket.emit('acceptCall', {
//       "callId": _callId,
//       "answer": answer.sdp,
//       "candidates": [],
//     });
//   }
//
//   /// Caller side receives 'callAccepted'
//   void _onCallAccepted(dynamic data) async {
//     /*
//       data = {
//         "callId": ...,
//         "answer": ...,
//         "candidates": ...
//       }
//     */
//     debugPrint("callAccepted: $data");
//
//     setState(() {
//       _callId = data['callId'];
//     });
//
//     final remoteDesc = RTCSessionDescription(data['answer'], 'answer');
//     await _peerConnection!.setRemoteDescription(remoteDesc);
//
//     // Add any ICE candidates if present
//   }
//
//   /// If call is missed after 30s
//   void _onCallMissed(dynamic data) {
//     debugPrint("callMissed: $data");
//     _cleanupAndPop();
//   }
//
//   /// If call ends => both sides
//   void _onCallEnded(dynamic data) {
//     debugPrint("callEnded: $data");
//     _cleanupAndPop();
//   }
//
//   /// Remote ICE candidate
//   void _onRemoteCandidate(dynamic data) async {
//     /*
//       data = {
//         "candidate": "...",
//         "sdpMid": "...",
//         "sdpMLineIndex": ...
//       }
//     */
//     debugPrint("Remote ICE candidate: $data");
//     if (data != null && data['candidate'] != null) {
//       final candidate = RTCIceCandidate(
//         data['candidate'],
//         data['sdpMid'],
//         data['sdpMLineIndex'],
//       );
//       await _peerConnection?.addCandidate(candidate);
//     }
//   }
//
//   /// End call from our side
//   void _endCall() {
//     if (_callId != null) {
//       socket.emit('endCall', {
//         "callId": _callId,
//       });
//     }
//     _cleanupAndPop();
//   }
//
//   /// Archive call example
//   void _archiveCall() {
//     if (_callId == null) return;
//     socket.emit('archiveCall', {
//       "callId": _callId,
//       "userId": Provider.of<AuthenProvider>(context,listen: false).userInfoData?.userId,
//     });
//     // Server should respond with a separate event or do nothing
//   }
//
//   /// Get call details
//   void _getCallDetails() {
//     if (_callId == null) return;
//     socket.emit('getCallDetails', {
//       "callId": _callId,
//     });
//     // Again, server might respond with a separate event or data
//   }
//
//   /// Cleanup local streams, peerconnection, then pop
//   void _cleanupAndPop() {
//     _peerConnection?.close();
//     _peerConnection = null;
//
//     _localStream?.dispose();
//     _localStream = null;
//     _localRenderer.srcObject = null;
//
//     _remoteStream?.dispose();
//     _remoteStream = null;
//     _remoteRenderer.srcObject = null;
//
//     if (mounted) {
//       Navigator.pop(context);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final isAudio = !_isVideoCall;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           '${_isVideoCall ? "Video" : "Audio"} Call with ${widget.calleeId}',
//         ),
//         actions: [
//           // Archive button (example usage)
//           IconButton(
//             onPressed: _archiveCall,
//             icon: const Icon(Icons.archive_outlined),
//           ),
//           // Get call details
//           IconButton(
//             onPressed: _getCallDetails,
//             icon: const Icon(Icons.info_outline),
//           ),
//           // End call
//           IconButton(
//             onPressed: _endCall,
//             icon: const Icon(Icons.call_end, color: Colors.red),
//           ),
//         ],
//       ),
//       body: SafeArea(
//         child: isAudio
//             ? _buildAudioUI()
//             : _buildVideoUI(),
//       ),
//     );
//   }
//
//   Widget _buildAudioUI() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Icon(Icons.mic, size: 80, color: Colors.blue),
//           const SizedBox(height: 20),
//           Text(
//             'Audio Call with ${widget.calleeId}',
//             style: const TextStyle(fontSize: 18),
//           ),
//           const SizedBox(height: 40),
//           ElevatedButton.icon(
//             onPressed: _endCall,
//             icon: const Icon(Icons.call_end, color: Colors.white),
//             label: const Text("End Call"),
//             style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildVideoUI() {
//     return Row(
//       children: [
//         Expanded(
//           child: Container(
//             color: Colors.black,
//             child: RTCVideoView(_localRenderer, mirror: true),
//           ),
//         ),
//         Expanded(
//           child: Container(
//             color: Colors.black87,
//             child: RTCVideoView(_remoteRenderer),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'Provider/authen_provider.dart';
import 'main.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // For demo, show two buttons => "Call History" and "User List"
    return Scaffold(
      appBar: AppBar(title: const Text('WhatsApp-like Calls')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text("Go to Call History"),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const CallHistoryScreen()),
                );
              },
            ),
            ElevatedButton(
              child: const Text("Go to User List"),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const UserListScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
//////////////////////////////////////// b /////////////////////

class UserInfoData {
  final String? userId;
  UserInfoData({this.userId});
}


///////////////////////////////////////// c ////////////////////////////////////////

class CallHistoryEntry {
  final String avatarUrl;
  final String name;
  final bool isMissed;
  final String timeAgo;

  CallHistoryEntry({
    required this.avatarUrl,
    required this.name,
    required this.isMissed,
    required this.timeAgo,
  });
}

class CallHistoryScreen extends StatefulWidget {
  const CallHistoryScreen({Key? key}) : super(key: key);

  @override
  State<CallHistoryScreen> createState() => _CallHistoryScreenState();
}

class _CallHistoryScreenState extends State<CallHistoryScreen> {
  final List<CallHistoryEntry> _calls = [
    CallHistoryEntry(
      avatarUrl: 'https://i.pravatar.cc/100?img=1',
      name: 'Pranav Ray',
      isMissed: true,
      timeAgo: '15 min ago',
    ),
    CallHistoryEntry(
      avatarUrl: 'https://i.pravatar.cc/100?img=2',
      name: 'Lindsey George',
      isMissed: false,
      timeAgo: '2 hours ago',
    ),
    // etc...
  ];

  void _startCall({required String calleeId, required String callType}) {
    print("objectcalleeId -> ${calleeId}");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CallScreen(
          calleeId: calleeId,
          callType: callType,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calls'),
      ),
      body: ListView.builder(
        itemCount: _calls.length,
        itemBuilder: (context, index) {
          final call = _calls[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(call.avatarUrl),
              radius: 24,
            ),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    call.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                if (call.isMissed)
                  const Padding(
                    padding: EdgeInsets.only(left: 4),
                    child: Icon(Icons.call_end, color: Colors.red, size: 16),
                  ),
              ],
            ),
            subtitle: Text(call.timeAgo),
            trailing: SizedBox(
              width: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => _startCall(
                      calleeId: "someMockUserIdA",
                      callType: 'video',
                    ),
                    child: const Icon(Icons.video_call, color: Colors.blue),
                  ),
                  InkWell(
                    onTap: () => _startCall(
                      calleeId: "someMockUserIdB",
                      callType: 'audio',
                    ),
                    child: const Icon(Icons.call, color: Colors.blue),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('New call or Add contact')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
//////////////////////////////////////// d ///////////////////////////////////

// Just for the demo. In real usage, fetch from your API.
const String mockJsonResponse = '''
{
  "success": true,
  "message": "Users fetched successfully.",
  "data": {
    "users": [
      {
        "_id": "675b242d98062c96f6a78150",
        "email": "mohsin@gmail.com",
        "isProfileCompleted": true,
        "bio": "Full Stack Developer",
        "firstName": "Mohsin",
        "lastName": "Zaehher",
        "profileImage": {
          "imageUrl": "https://i.pravatar.cc/100?img=9"
        }
      },
      {
        "_id": "675c2f3cad7f9ca029a25469",
        "email": "mohsinmaken3@gmail.com",
        "isProfileCompleted": true,
        "bio": "Mobile Developer",
        "firstName": "Mohsin",
        "lastName": "Maken",
        "profileImage": {
          "imageUrl": "https://i.pravatar.cc/100?img=11"
        }
      },
      {
        "_id": "675d70cebef3490642f6c854",
        "email": "securedoorstudio@gmail.com",
        "isProfileCompleted": true,
        "bio": "Mobile Developer",
        "firstName": "Secure",
        "lastName": "Door",
        "profileImage": {
          "imageUrl": "https://i.pravatar.cc/100?img=11"
        }
      }
    ]
  }
}
''';

class MyUser {
  final String id;
  final String email;
  final bool isProfileCompleted;
  final String? bio;
  final String? firstName;
  final String? lastName;
  final String? profileImageUrl;

  MyUser({
    required this.id,
    required this.email,
    required this.isProfileCompleted,
    this.bio,
    this.firstName,
    this.lastName,
    this.profileImageUrl,
  });

  factory MyUser.fromJson(Map<String, dynamic> json) {
    String? imageUrl;
    if (json['profileImage'] != null && json['profileImage']['imageUrl'] != null) {
      imageUrl = json['profileImage']['imageUrl'] as String;
    }
    return MyUser(
      id: json['_id'] as String,
      email: json['email'] as String,
      isProfileCompleted: json['isProfileCompleted'] as bool,
      bio: json['bio'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      profileImageUrl: imageUrl,
    );
  }
}

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final List<MyUser> _users = [];

  @override
  void initState() {
    super.initState();
    _parseUsersFromJson();
  }

  void _parseUsersFromJson() {
    final parsed = jsonDecode(mockJsonResponse) as Map<String, dynamic>;
    final data = parsed['data'] as Map<String, dynamic>;
    final usersList = data['users'] as List<dynamic>;

    _users.clear();
    for (var userJson in usersList) {
      _users.add(MyUser.fromJson(userJson));
    }
    setState(() {});
  }

  void _startCall({required String calleeId, required String callType}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CallScreen(
          calleeId: calleeId,
          callType: callType,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthenProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("All Users (Logged in as: ${auth.userInfoData?.userId})"),
      ),
      body: _users.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = _users[index];
          final displayName = (user.firstName != null || user.lastName != null)
              ? '${user.firstName ?? ''} ${user.lastName ?? ''}'.trim()
              : user.email;

          return ListTile(
            leading: CircleAvatar(
              radius: 24,
              backgroundImage: user.profileImageUrl != null
                  ? NetworkImage(user.profileImageUrl!)
                  : null,
              child: user.profileImageUrl == null
                  ? Text(
                user.email[0].toUpperCase(),
                style: const TextStyle(fontSize: 18, color: Colors.white),
              )
                  : null,
            ),
            title: Text(displayName.isNotEmpty ? displayName : user.email),
            subtitle: Text(user.bio ?? 'No bio'),
            trailing: SizedBox(
              width: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text("${}")
                  InkWell(
                    onTap: () => _startCall(
                      calleeId: user.id,
                      callType: 'video',
                    ),
                    child: const Icon(Icons.video_call, color: Colors.blue),
                  ),
                  InkWell(
                    onTap: () => _startCall(
                      calleeId: user.id,
                      callType: 'audio',
                    ),
                    child: const Icon(Icons.call, color: Colors.blue),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


///////////////////////////////////////////// e ////////////////////////////////////////////////


class CallScreen extends StatefulWidget {
  final String calleeId; // The person we're calling
  final String callType; // 'audio' or 'video'

  const CallScreen({
    Key? key,
    required this.calleeId,
    required this.callType,
  }) : super(key: key);

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {

  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;
  MediaStream? _remoteStream;

  final _localRenderer = RTCVideoRenderer();
  final _remoteRenderer = RTCVideoRenderer();

  String? _callId;

  bool get _isVideoCall => widget.callType == 'video';

  // Handy: current user ID from provider
  String get _currentUserId {
    final auth = Provider.of<AuthenProvider>(context, listen: false);
    return auth.userInfoData?.userId ?? 'unknownCaller';
  }

  @override
  void initState() {
    super.initState();
    // print("objectcalleeId -> ${calleeId}");
    debugPrint("CallScreen initState => calleeId: ${widget.calleeId}, callType: ${widget.callType}");
    _initializeRenderers();
    _connectSocketAndJoin();
  }

  Future<void> _initializeRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }

  @override
  void dispose() {
    debugPrint("CallScreen dispose => cleaning up");
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    socket?.dispose();
    _peerConnection?.dispose();
    super.dispose();
  }

  // 1) Connect to socket + "join"
  void _connectSocketAndJoin() {
    debugPrint("Connecting to socket...");

    // When connected:
    // socket.onConnect((_) {
    //   debugPrint("Socket connected => id: ${socket!.id}");
    //   // Let the server know which userId is connected
    //   debugPrint("Emitted join with userId=$_currentUserId");
    //
    //   // For this screen, we always assume _currentUserId is caller => initiate call
    //   // But if you're the callee, the server's 'callRequest' event will arrive, so let's do it this way:
    // });
      socket.emit('join', { "userId": _currentUserId });
      _initiateCall();

    // Catch any errors
    socket!.onConnectError((data) => debugPrint("Socket connect error: $data"));
    socket!.onError((data) => debugPrint("Socket general error: $data"));
    socket!.onDisconnect((data) => debugPrint("Socket disconnected: $data"));

    // 2) Setup all event listeners
    socket!.on('callRequest', _onCallRequest);
    socket!.on('callAccepted', _onCallAccepted);
    socket!.on('callMissed', _onCallMissed);
    socket!.on('callEnded', _onCallEnded);
    socket!.on('iceCandidate', _onRemoteCandidate);

    // Also listen onAny for debugging:
    socket!.onAny((event, data) {
      debugPrint("onAny => event: $event | data: $data");
    });

    // socket!.connect();
  }

  // 2) Create peer connection
  Future<RTCPeerConnection> _createPeerConnection() async {
    final configuration = {
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'}
      ]
    };

    final constraints = {
      'mandatory': {
        'OfferToReceiveAudio': true,
        'OfferToReceiveVideo': _isVideoCall,
      },
      'optional': [],
    };

    final pc = await createPeerConnection(configuration, constraints);

    // local iceCandidate => send to server
    pc.onIceCandidate = (candidate) {
      if (candidate != null) {
        debugPrint("onIceCandidate => candidate: ${candidate.toMap()}");
        socket?.emit('iceCandidate', {
          "callId": _callId,
          "candidate": candidate.toMap(),
        });
      }
    };

    // remote track => set to _remoteRenderer
    pc.onTrack = (rtcTrackEvent) {
      debugPrint("onTrack => streams: ${rtcTrackEvent.streams.length}");
      if (rtcTrackEvent.streams.isNotEmpty) {
        setState(() {
          _remoteStream = rtcTrackEvent.streams[0];
          _remoteRenderer.srcObject = _remoteStream;
        });
      }
    };

    return pc;
  }

  // 3) Create local media stream
  Future<void> _createLocalStream() async {
    final mediaConstraints = {
      'audio': true,
      'video': _isVideoCall
          ? {
        'facingMode': 'user',
      }
          : false,
    };

    _localStream = await navigator.mediaDevices.getUserMedia(mediaConstraints);
    _localRenderer.srcObject = _localStream;

    for (var track in _localStream!.getTracks()) {
      await _peerConnection?.addTrack(track, _localStream!);
    }
  }

  // 4) Initiate call (caller side)
  Future<void> _initiateCall() async {
    debugPrint("Attempting to createPeerConnection + localStream + offer => calleeId=${widget.calleeId}");
    _peerConnection = await _createPeerConnection();
    await _createLocalStream();

    // createOffer
    final offer = await _peerConnection!.createOffer();
    await _peerConnection!.setLocalDescription(offer);

    // tell server => 'initiateCall'
    debugPrint("Emitting 'initiateCall' to server with calleeId=${widget.calleeId}");
    socket?.emitWithAck('initiateCall', {
      "callerId": _currentUserId,
      "calleeId": widget.calleeId,
      "callType": _isVideoCall ? "video" : "audio",
      "offer": offer.sdp,
    }, ack: (response) {
      debugPrint("initiateCall callback => $response");
      if (response != null && response['success'] == true) {
        _callId = response['callId'];
        debugPrint("Call created => _callId=$_callId");
      }
    });
  }

  // 5) We might be the callee => 'callRequest'
  void _onCallRequest(dynamic data) async {
    debugPrint("_onCallRequest => $data");
    _callId = data['callId'];

    // createPeerConnection + localStream
    _peerConnection = await _createPeerConnection();
    await _createLocalStream();

    // set remote desc
    final remoteOffer = RTCSessionDescription(data['offer'], 'offer');
    await _peerConnection!.setRemoteDescription(remoteOffer);

    // for simplicity, auto-accept
    _acceptCall();
  }

  // 6) Accept call (callee side)
  Future<void> _acceptCall() async {
    debugPrint("_acceptCall => _callId=$_callId");
    if (_peerConnection == null || _callId == null) return;

    final answer = await _peerConnection!.createAnswer();
    await _peerConnection!.setLocalDescription(answer);

    debugPrint("Emitting 'acceptCall' with callId=$_callId");
    socket?.emit('acceptCall', {
      "callId": _callId,
      "answer": answer.sdp,
    });
  }

  // 7) Caller => 'callAccepted'
  void _onCallAccepted(dynamic data) async {
    debugPrint("_onCallAccepted => $data");
    _callId = data['callId'];

    final remoteAnswer = RTCSessionDescription(data['answer'], 'answer');
    await _peerConnection!.setRemoteDescription(remoteAnswer);
    debugPrint("Remote description set with callId=$_callId");
  }

  // 8) Remote ICE
  void _onRemoteCandidate(dynamic data) async {
    debugPrint("_onRemoteCandidate => $data");
    if (data['candidate'] != null) {
      final candidateMap = Map<String, dynamic>.from(data['candidate']);
      final candidate = RTCIceCandidate(
        candidateMap['candidate'],
        candidateMap['sdpMid'],
        candidateMap['sdpMLineIndex'],
      );
      await _peerConnection?.addCandidate(candidate);
      debugPrint("Remote ICE candidate added.");
    }
  }

  // 9) Missed call
  void _onCallMissed(dynamic data) {
    debugPrint("_onCallMissed => $data");
    _cleanupAndPop();
  }

  // 10) Ended call
  void _onCallEnded(dynamic data) {
    debugPrint("_onCallEnded => $data");
    _cleanupAndPop();
  }

  void _endCall() {
    if (_callId != null) {
      debugPrint("Emitting 'endCall' => callId=$_callId");
      socket?.emit('endCall', {
        "callId": _callId,
      });
    }
    _cleanupAndPop();
  }

  void _cleanupAndPop() {
    debugPrint("_cleanupAndPop => closing peerConnection & streams");
    _peerConnection?.close();
    _peerConnection = null;

    _localStream?.dispose();
    _localRenderer.srcObject = null;
    _localStream = null;

    _remoteStream?.dispose();
    _remoteRenderer.srcObject = null;
    _remoteStream = null;

    if (mounted) {
      Navigator.pop(context);
    }
  }

  // Bonus: you can also add "archiveCall", "getCallDetails", etc. as needed.

  @override
  Widget build(BuildContext context) {
    final isAudio = !_isVideoCall;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${_isVideoCall ? "Video" : "Audio"} Call with ${widget.calleeId}',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.call_end, color: Colors.red),
            onPressed: _endCall,
          ),
        ],
      ),
      body: SafeArea(
        child: isAudio ? _buildAudioUI() : _buildVideoUI(),
      ),
    );
  }

  Widget _buildAudioUI() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.mic, size: 80, color: Colors.blue),
          const SizedBox(height: 20),
          Text(
            'Audio Call with ${widget.calleeId}',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 40),
          ElevatedButton.icon(
            onPressed: _endCall,
            icon: const Icon(Icons.call_end, color: Colors.white),
            label: const Text("End Call"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoUI() {
    return Row(
      children: [
        Expanded(
          child: Container(
            color: Colors.black,
            child: RTCVideoView(_localRenderer, mirror: true),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.black87,
            child: RTCVideoView(_remoteRenderer),
          ),
        ),
      ],
    );
  }
}
