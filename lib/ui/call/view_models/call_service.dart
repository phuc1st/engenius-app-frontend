// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_webrtc/flutter_webrtc.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
// import 'call_view_model.dart';
//
// final callServiceProvider = Provider<CallService>((ref) {
//   return CallService(ref);
// });
//
// class CallService {
//   final Ref ref;
//   late WebSocketChannel _channel;
//   RTCPeerConnection? _peerConnection;
//   MediaStream? _localStream;
//   final String userId = "100";
//   bool _isCaller = false;
//   bool _isReconnecting = false;
//   Timer? _reconnectTimer;
//
//   CallService(this.ref);
//
//   Future<void> init() async {
//     try {
//       final status = await [Permission.camera, Permission.microphone].request();
//       if (!status[Permission.camera]!.isGranted ||
//           !status[Permission.microphone]!.isGranted) {
//         throw Exception('Camera or microphone permission denied');
//       }
//
//       await _connectWebSocket();
//       print("✅ WebSocket connected successfully!");
//     } catch (e) {
//       print("❌ WebSocket connection failed: $e");
//       _scheduleReconnect();
//     }
//   }
//
//   Future<void> _connectWebSocket() async {
//     _channel = WebSocketChannel.connect(
//       Uri.parse('ws://192.168.1.3:8083/call/ws?userId=$userId'),
//     );
//
//     _channel.stream.listen(
//       _onMessageReceived,
//       onError: (error) {
//         print("❌ WebSocket error: $error");
//         _scheduleReconnect();
//       },
//       onDone: () {
//         print("⚠️ WebSocket closed");
//         if (!_isReconnecting) {
//           _scheduleReconnect();
//         }
//       },
//     );
//   }
//
//   void _scheduleReconnect() {
//     if (_reconnectTimer != null) return;
//
//     _isReconnecting = true;
//     _reconnectTimer = Timer.periodic(Duration(seconds: 5), (timer) async {
//       print("🔄 Attempting to reconnect to WebSocket...");
//       try {
//         await _connectWebSocket();
//         timer.cancel();
//         _reconnectTimer = null;
//         _isReconnecting = false;
//
//         if (ref.read(callStateNotifierProvider).isConnected) {
//           _send({
//             'type': 'reconnect',
//             'from': userId,
//             'partnerId': ref.read(callStateNotifierProvider).partnerId,
//           });
//         }
//       } catch (e) {
//         print("❌ Reconnect failed: $e");
//       }
//     });
//   }
//
//   void _onMessageReceived(dynamic message) async {
//     try {
//       final data = jsonDecode(message);
//       print("📩 Received WebSocket message: $data");
//
//       switch (data['type']) {
//         case 'partnerFound':
//           _handlePartnerFound(data['partnerId']);
//           break;
//         case 'partnerDisconnected':
//           _handlePartnerDisconnected();
//           break;
//         case 'offer':
//           await _handleOffer(data);
//           break;
//         case 'answer':
//           await _handleAnswer(data);
//           break;
//         case 'candidate':
//           await _handleCandidate(data);
//           break;
//         case 'connectionStatus':
//           print("🔗 Connection status: ${data['status']}");
//           break;
//       }
//     } catch (e) {
//       print("⚠️ Error processing message: $e");
//     }
//   }
//
//   void _handlePartnerFound(String partnerId) {
//     ref.read(callStateNotifierProvider.notifier)
//       ..setPartner(partnerId)
//       ..updateConnection(true);
//
//     _isCaller = userId.compareTo(partnerId) > 0;
//     _startCall();
//   }
//
//   void _handlePartnerDisconnected() {
//     ref.read(callStateNotifierProvider.notifier).updateConnection(false);
//     _showDisconnectMessage();
//     findNewPartner();
//   }
//
//   void _showDisconnectMessage() {
//     final context = ref.read(navigatorKeyProvider).currentContext;
//     if (context != null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Partner has disconnected')),
//       );
//     }
//   }
//
//   Future<void> _startCall() async {
//     try {
//       final state = ref.read(callStateNotifierProvider);
//       await _initializeMediaAndPeerConnection();
//
//       if (_isCaller) {
//         final offer = await _peerConnection!.createOffer();
//         await _peerConnection!.setLocalDescription(offer);
//         print("📤 Sending offer to partner ${state.partnerId}");
//
//         _send({
//           'type': 'offer',
//           'to': state.partnerId,
//           'offer': offer.toMap(),
//           'from': userId,
//         });
//       }
//     } catch (e) {
//       print("⚠️ Error in _startCall: $e");
//       _showError("Failed to start call");
//     }
//   }
//
//   Future<void> _initializeMediaAndPeerConnection() async {
//     final state = ref.read(callStateNotifierProvider);
//
//     _localStream ??= await navigator.mediaDevices.getUserMedia({
//       'audio': state.isMicOn,
//       'video': {
//         'facingMode': state.isFrontCamera ? 'user' : 'environment',
//         'width': {'ideal': 320},
//         'height': {'ideal': 600},
//         'frameRate': {'ideal': 30},
//       },
//     });
//
//     state.localRenderer.srcObject = _localStream;
//
//     if (_peerConnection == null) {
//       await _createPeerConnection();
//     }
//   }
//
//   Future<void> _createPeerConnection() async {
//     try {
//       _peerConnection = await createPeerConnection({
//         'iceServers': [
//           {'urls': 'stun:stun.l.google.com:19302'},
//         ],
//         'sdpSemantics': 'unified-plan'
//       });
//       print("✅ PeerConnection created successfully!");
//
//       _peerConnection?.onIceCandidate = (candidate) {
//         print("🔍 ICE Candidate: ${candidate.toMap()}");
//         final partnerId = ref.read(callStateNotifierProvider).partnerId;
//         if (candidate.candidate != null && partnerId != null) {
//           _send({
//             'type': 'candidate',
//             'to': partnerId,
//             'candidate': candidate.toMap(),
//           });
//         }
//       };
//
//       _peerConnection?.onIceConnectionState = (state) {
//         print("🔄 ICE Connection State: $state");
//         if (state == RTCIceConnectionState.RTCIceConnectionStateDisconnected) {
//           _handleIceDisconnected();
//         }
//       };
//
//       _peerConnection?.onTrack = (event) {
//         if (event.streams.isNotEmpty) {
//           ref.read(callStateNotifierProvider.notifier)
//             ..updateRemoteStream(event.streams[0])
//             ..updateConnection(true);
//         }
//       };
//
//       _peerConnection?.onConnectionState = (state) {
//         print("🔗 PeerConnection State: $state");
//       };
//
//       if (_localStream != null) {
//         _localStream!.getTracks().forEach((track) {
//           _peerConnection?.addTrack(track, _localStream!);
//         });
//       }
//     } catch (e) {
//       print("⚠️ Error in _createPeerConnection: $e");
//       throw e;
//     }
//   }
//
//   void _handleIceDisconnected() {
//     print("🔄 ICE disconnected, attempting to restart ICE...");
//     _peerConnection?.restartIce();
//   }
//
//   Future<void> _handleOffer(dynamic data) async {
//     try {
//       if (_peerConnection == null || _localStream == null) {
//         await _initializeMediaAndPeerConnection();
//       }
//
//       await _peerConnection!.setRemoteDescription(
//         RTCSessionDescription(data['offer']['sdp'], data['offer']['type']),
//       );
//
//       final answer = await _peerConnection!.createAnswer();
//       await _peerConnection!.setLocalDescription(answer);
//
//       _send({
//         'type': 'answer',
//         'to': data['from'],
//         'answer': answer.toMap(),
//       });
//     } catch (e) {
//       print("⚠️ Error in _handleOffer: $e");
//       _showError("Failed to handle offer");
//     }
//   }
//
//   Future<void> _handleAnswer(dynamic data) async {
//     try {
//       final answer = RTCSessionDescription(
//         data['answer']['sdp'],
//         data['answer']['type'],
//       );
//       await _peerConnection?.setRemoteDescription(answer);
//     } catch (e) {
//       print("⚠️ Error in _handleAnswer: $e");
//       _showError("Failed to handle answer");
//     }
//   }
//
//   Future<void> _handleCandidate(dynamic data) async {
//     try {
//       final candidate = RTCIceCandidate(
//         data['candidate']['candidate'],
//         data['candidate']['sdpMid'],
//         data['candidate']['sdpMLineIndex'],
//       );
//       await _peerConnection?.addCandidate(candidate);
//     } catch (e) {
//       print("⚠️ Error in _handleCandidate: $e");
//     }
//   }
//
//   void _send(Map<String, dynamic> data) {
//     final jsonData = jsonEncode(data);
//     print("📤 Sending data (size: ${jsonData.length} bytes)");
//     try {
//       if (_channel.closeCode == null) {
//         _channel.sink.add(jsonData);
//       } else {
//         print("⚠️ WebSocket is closed, cannot send message");
//         _scheduleReconnect();
//       }
//     } catch (e) {
//       print("⚠️ Error sending message: $e");
//     }
//   }
//
//   Future<void> endCall() async {
//     print("📴 Ending call and cleaning up resources...");
//     try {
//       _send({
//         'type': 'disconnect',
//         'from': userId,
//         'to': ref.read(callStateNotifierProvider).partnerId,
//       });
//
//       await _peerConnection?.close();
//       _peerConnection = null;
//
//       await _localStream?.dispose();
//       _localStream = null;
//
//       ref.read(callStateNotifierProvider.notifier).resetState();
//     } catch (e) {
//       print("⚠️ Error ending call: $e");
//     }
//   }
//
//   Future<void> findNewPartner() async {
//     await endCall();
//
//     ref.read(callStateNotifierProvider.notifier).resetState();
//
//     if (_channel.closeCode != null) {
//       await _connectWebSocket();
//     }
//
//     print("🔄 Looking for new partner...");
//     _send({
//       'type': 'findPartner',
//       'from': userId,
//     });
//   }
//
//   void _showError(String message) {
//     final context = ref.read(navigatorKeyProvider).currentContext;
//     if (context != null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(message)),
//       );
//     }
//   }
//
//   void dispose() {
//     _reconnectTimer?.cancel();
//     _channel.sink.close();
//     _peerConnection?.close();
//     _localStream?.dispose();
//   }
// }
