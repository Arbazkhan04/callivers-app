// call_page.dart
import 'dart:convert';
import 'package:calliverse/Constants/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
class PermissionsHandler {
  static Future<bool> requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.microphone,
      Permission.notification,
    ].request();

    bool allGranted = statuses.values.every((status) => status.isGranted);
    return allGranted;
  }
}
class CallPage extends StatefulWidget {
  final String roomId;
  final bool isCreator;
  final String jwtToken; // Accept JWT token

  CallPage({required this.roomId, required this.isCreator, required this.jwtToken});

  @override
  _CallPageState createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  late WebSocketChannel _channel;
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();

  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;

  final Map<String, dynamic> _iceServers = {
    'iceServers': [
      {'urls': 'stun:stun.l.google.com:19302'},
      // Add TURN servers here if needed
    ]
  };

  bool _isCameraOn = true;
  bool _isScreenSharing = false;
  bool _isFrontCamera = true;
  bool _isConnected = false;

  // For full-screen toggling
  bool _isRemoteFullScreen = false;
  bool _isLocalFullScreen = false;

  bool _isLoading = false; // For loading indicators

  @override
  void initState() {
    super.initState();
    _initializeRenderers();
    _connectToSignalingServer();
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    _peerConnection?.close();
    _channel.sink.close();
    _localStream?.dispose();
    super.dispose();
  }

  Future<void> _initializeRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }

  void _connectToSignalingServer() {
    // Replace 'YOUR_SERVER_IP' with your signaling server's IP or domain
    // Example: 'ws://192.168.1.100:8080'
    _channel = IOWebSocketChannel.connect('ws://$mIpURL:8080');

    _channel.stream.listen((message) {
      print('Received message: $message');
      Map<String, dynamic> data = jsonDecode(message);
      if (data['type'] == 'error') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['payload']['message'])),
        );
        return;
      }
      switch (data['type']) {
        case 'new-peer':
          if (widget.isCreator) {
            _createOffer();
          }
          break;
        case 'offer':
          _handleOffer(data['payload']);
          break;
        case 'answer':
          _handleAnswer(data['payload']);
          break;
        case 'candidate':
          _handleCandidate(data['payload']);
          break;
        case 'peer-disconnected':
          _onPeerDisconnected();
          break;
        default:
          break;
      }
    }, onDone: () {
      print('WebSocket closed');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Disconnected from signaling server')),
        );
      }
    }, onError: (error) {
      print('WebSocket error: $error');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error connecting to signaling server')),
        );
      }
    });

    // After connecting, join the room with JWT token
    _joinRoom();
  }

  void _joinRoom() {
    Map<String, dynamic> message = {
      'type': 'join',
      'room': widget.roomId,
      'payload': {
        'token': widget.jwtToken, // Include JWT token
      },
    };
    _channel.sink.add(jsonEncode(message));
  }

  Future<void> _createOffer() async {
    setState(() {
      _isLoading = true;
    });
    await _createPeerConnection();
    RTCSessionDescription offer = await _peerConnection!.createOffer();
    await _peerConnection!.setLocalDescription(offer);

    // Send the offer to the signaling server
    Map<String, dynamic> message = {
      'type': 'offer',
      'room': widget.roomId,
      'payload': offer.toMap(),
    };
    _channel.sink.add(jsonEncode(message));
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _handleOffer(Map<String, dynamic> offer) async {
    setState(() {
      _isLoading = true;
    });
    await _createPeerConnection();
    await _peerConnection!.setRemoteDescription(
        RTCSessionDescription(offer['sdp'], offer['type']));
    RTCSessionDescription answer = await _peerConnection!.createAnswer();
    await _peerConnection!.setLocalDescription(answer);

    // Send the answer back to the signaling server
    Map<String, dynamic> message = {
      'type': 'answer',
      'room': widget.roomId,
      'payload': answer.toMap(),
    };
    _channel.sink.add(jsonEncode(message));
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _handleAnswer(Map<String, dynamic> answer) async {
    await _peerConnection!.setRemoteDescription(
        RTCSessionDescription(answer['sdp'], answer['type']));
  }

  Future<void> _handleCandidate(Map<String, dynamic> candidate) async {
    RTCIceCandidate iceCandidate = RTCIceCandidate(
      candidate['candidate'],
      candidate['sdpMid'],
      candidate['sdpMLineIndex'],
    );
    await _peerConnection!.addCandidate(iceCandidate);
  }

  Future<void> _createPeerConnection() async {
    _peerConnection = await createPeerConnection(_iceServers, {});

    // Get user media
    _localStream = await _getUserMedia();
    _localRenderer.srcObject = _localStream;

    // Add all tracks to the peer connection
    _localStream?.getTracks().forEach((track) {
      _peerConnection!.addTrack(track, _localStream!);
    });

    // Listen for remote streams
    _peerConnection!.onTrack = (RTCTrackEvent event) {
      if (event.track.kind == 'video') {
        setState(() {
          _remoteRenderer.srcObject = event.streams[0];
        });
      }
    };

    // Listen for ICE candidates
    _peerConnection!.onIceCandidate = (RTCIceCandidate candidate) {
      if (candidate.candidate != null) {
        Map<String, dynamic> message = {
          'type': 'candidate',
          'room': widget.roomId,
          'payload': {
            'candidate': candidate.candidate,
            'sdpMid': candidate.sdpMid,
            'sdpMLineIndex': candidate.sdpMLineIndex,
          },
        };
        _channel.sink.add(jsonEncode(message));
      }
    };

    // Listen for connection state changes
    _peerConnection!.onConnectionState = (RTCPeerConnectionState state) {
      print('Connection state: $state');
      if (state == RTCPeerConnectionState.RTCPeerConnectionStateConnected) {
        setState(() {
          _isConnected = true;
        });
      } else if (state == RTCPeerConnectionState.RTCPeerConnectionStateDisconnected ||
          state == RTCPeerConnectionState.RTCPeerConnectionStateFailed ||
          state == RTCPeerConnectionState.RTCPeerConnectionStateClosed) {
        _onPeerDisconnected();
      }
    };
  }

  Future<MediaStream> _getUserMedia() async {
    final Map<String, dynamic> mediaConstraints = {
      'audio': true,
      'video': {
        'facingMode': _isFrontCamera ? 'user' : 'environment',
      },
    };

    MediaStream stream =
    await navigator.mediaDevices.getUserMedia(mediaConstraints);
    return stream;
  }

  void _onPeerDisconnected() {
    // Handle peer disconnection
    setState(() {
      _remoteRenderer.srcObject = null;
      _isConnected = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Peer disconnected')),
    );
  }

  void _toggleCamera() async {
    if (_localStream == null) return;
    bool enabled = !_isCameraOn;
    _localStream!.getVideoTracks().forEach((track) {
      track.enabled = enabled;
    });
    setState(() {
      _isCameraOn = enabled;
    });
  }

  void _switchCamera() async {
    if (_localStream == null) return;
    final videoTracks = _localStream!.getVideoTracks();
    if (videoTracks.isEmpty) return;

    try {
      await Helper.switchCamera(videoTracks.first);
      setState(() {
        _isFrontCamera = !_isFrontCamera;
      });
    } catch (e) {
      print('Error switching camera: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error switching camera')),
      );
    }
  }
// Example in CallPage.dart
  void _shareScreen() async {
    if (_isScreenSharing) {
      // Stop screen sharing
      await _stopScreenSharing();
      // await ScreenCaptureServiceController.stopService();
    } else {
      // Request permissions
      bool permissionsGranted = await PermissionsHandler.requestPermissions();
      if (!permissionsGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Permissions not granted')),
        );
        return;
      }

      // Start screen sharing
      try {
        // await ScreenCaptureServiceController.startService();
        await _startScreenSharing();
      } catch (e) {
        print('Error sharing screen: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error sharing screen')),
        );
      }
    }
    setState(() {
      _isScreenSharing = !_isScreenSharing;
    });
  }

  Future<void> _startScreenSharing() async {
    try {
      // Note: Screen sharing is fully supported on Web and Desktop.
      // On mobile platforms, additional configurations or permissions might be required.
      MediaStream screenStream = await navigator.mediaDevices.getDisplayMedia({
        'video': {
          'mandatory': {
            'chromeMediaSource': 'screen',
            'maxWidth': 1920,
            'maxHeight': 1080,
          },
          'facingMode': 'user',
          'optional': [],
        },
        'audio': false,
      });

      if (_peerConnection != null) {
        // Remove existing video sender
        List<RTCRtpSender> senders = await _peerConnection!.getSenders();
        RTCRtpSender? videoSender;
        try {
          videoSender = senders.firstWhere(
                (sender) => sender.track?.kind == 'video',
          );
        } catch (e) {
          videoSender = null;
        }

        if (videoSender != null && videoSender.track != null) {
          await _peerConnection!.removeTrack(videoSender);
        }

        // Add screen track
        List<MediaStreamTrack> screenTracks = screenStream.getVideoTracks();
        if (screenTracks.isNotEmpty) {
          await _peerConnection!.addTrack(screenTracks.first, screenStream);
          _localRenderer.srcObject = screenStream;

          // Listen for when screen sharing ends
          screenTracks.first.onEnded = () {
            _stopScreenSharing();
            setState(() {
              _isScreenSharing = false;
            });
          };
        }
      }
    } catch (e) {
      print('Error sharing screen: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sharing screen')),
      );
    }
  }

  Future<void> _stopScreenSharing() async {
    try {
      if (_peerConnection == null) return;

      // Remove screen track and add back the camera track
      List<RTCRtpSender> senders = await _peerConnection!.getSenders();
      RTCRtpSender? screenSender;
      try {
        screenSender = senders.firstWhere(
              (sender) =>
          sender.track?.kind == 'video' &&
              sender.track!.label!.contains('screen'),
        );
      } catch (e) {
        screenSender = null;
      }

      if (screenSender != null && screenSender.track != null) {
        await _peerConnection!.removeTrack(screenSender);
      }

      // Get camera stream again
      MediaStream cameraStream = await _getUserMedia();

      // Add camera track back
      List<MediaStreamTrack> cameraTracks = cameraStream.getVideoTracks();
      if (cameraTracks.isNotEmpty) {
        await _peerConnection!.addTrack(cameraTracks.first, cameraStream);
        _localRenderer.srcObject = cameraStream;

        setState(() {
          _isCameraOn = cameraTracks.first.enabled;
        });
      }
    } catch (e) {
      print('Error stopping screen sharing: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error stopping screen sharing')),
      );
    }
  }

  void _endCall() {
    // Close peer connection and WebSocket
    _peerConnection?.close();
    _channel.sink.close();

    // Navigate back to HomePage
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  void _leaveRoom() {
    // Notify the signaling server about leaving
    Map<String, dynamic> message = {
      'type': 'leave',
      'room': widget.roomId,
      'payload': {},
    };
    _channel.sink.add(jsonEncode(message));

    // Close peer connection and WebSocket
    _peerConnection?.close();
    _channel.sink.close();

    // Navigate back to HomePage
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  void _toggleRemoteFullScreen() {
    setState(() {
      _isRemoteFullScreen = !_isRemoteFullScreen;
    });
  }

  void _toggleLocalFullScreen() {
    setState(() {
      _isLocalFullScreen = !_isLocalFullScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Room ID: ${widget.roomId}'),
        actions: [
          IconButton(
            icon: Icon(Icons.call_end),
            onPressed: _endCall,
            tooltip: 'End Call',
            color: Colors.red,
          ),
        ],
      ),
      body: Stack(
        children: [
          // Remote Video
          GestureDetector(
            onDoubleTap: _toggleRemoteFullScreen,
            child: Container(
              color: Colors.black,
              child: _remoteRenderer.srcObject != null
                  ? RTCVideoView(
                _remoteRenderer,
                objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                mirror: false,
              )
                  : Center(
                child: Text(
                  'Waiting for peer to join...',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),

          // Local Video (Picture-in-Picture)
          Positioned(
            top: 20,
            right: 20,
            child: GestureDetector(
              onDoubleTap: _toggleLocalFullScreen,
              child: Container(
                width: _isLocalFullScreen ? MediaQuery.of(context).size.width : 120,
                height: _isLocalFullScreen ? MediaQuery.of(context).size.height : 160,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: RTCVideoView(
                  _localRenderer,
                  mirror: true,
                ),
              ),
            ),
          ),

          // Control Buttons
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Toggle Camera
                    FloatingActionButton(
                      heroTag: 'camera',
                      onPressed: _toggleCamera,
                      backgroundColor: _isCameraOn ? Colors.blue : Colors.grey,
                      child: Icon(
                        _isCameraOn ? Icons.videocam : Icons.videocam_off,
                      ),
                      tooltip: _isCameraOn ? 'Turn Camera Off' : 'Turn Camera On',
                    ),

                    // Switch Camera
                    FloatingActionButton(
                      heroTag: 'switch_camera',
                      onPressed: _switchCamera,
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.switch_camera),
                      tooltip: 'Switch Camera',
                    ),

                    // Share Screen
                    FloatingActionButton(
                      heroTag: 'share_screen',
                      onPressed: _shareScreen,
                      backgroundColor: _isScreenSharing ? Colors.red : Colors.blue,
                      child: Icon(
                        _isScreenSharing ? Icons.stop_screen_share : Icons.screen_share,
                      ),
                      tooltip: _isScreenSharing ? 'Stop Sharing Screen' : 'Share Screen',
                    ),

                    // Leave Room
                    FloatingActionButton(
                      heroTag: 'leave',
                      onPressed: _leaveRoom,
                      backgroundColor: Colors.orange,
                      child: Icon(Icons.exit_to_app),
                      tooltip: 'Leave Room',
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Loading Indicator
          if (_isLoading)
            Container(
              color: Colors.black54,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),

          // Full-Screen Overlays
          if (_isRemoteFullScreen)
            Positioned.fill(
              child: GestureDetector(
                onTap: _toggleRemoteFullScreen,
                child: Container(
                  color: Colors.black,
                  child: _remoteRenderer.srcObject != null
                      ? RTCVideoView(
                    _remoteRenderer,
                    objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                    mirror: false,
                  )
                      : Container(),
                ),
              ),
            ),

          if (_isLocalFullScreen)
            Positioned.fill(
              child: GestureDetector(
                onTap: _toggleLocalFullScreen,
                child: Container(
                  color: Colors.black54,
                  alignment: Alignment.center,
                  child: _localRenderer.srcObject != null
                      ? RTCVideoView(
                    _localRenderer,
                    objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                    mirror: true,
                  )
                      : Container(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class ScreenCaptureService {
  static const MethodChannel _channel = MethodChannel('screen_capture_service');

  static Future<void> startForegroundService() async {
    try {
      await _channel.invokeMethod('startForegroundService');
    } on PlatformException catch (e) {
      print("Failed to start foreground service: '${e.message}'.");
    }
  }

  static Future<void> stopForegroundService() async {
    try {
      await _channel.invokeMethod('stopForegroundService');
    } on PlatformException catch (e) {
      print("Failed to stop foreground service: '${e.message}'.");
    }
  }
}