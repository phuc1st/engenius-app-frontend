import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:toeic/ui/call/view_models/call_view_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

final callServiceProvider = Provider<CallService>((ref) {
  return CallService(ref);
});

class CallService {
  final Ref ref;
  WebSocketChannel? _channel;
  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;
  String? userId;
  String? partnerId;

  CallService(this.ref);

  Future<void> init() async {
    userId = DateTime.now().millisecondsSinceEpoch.toString();
    _connectToWebSocket();

    final localStream = await navigator.mediaDevices.getUserMedia({
      'audio': true,
      'video': {'facingMode': 'user'},
    });

    _localStream = localStream;
    final state = ref.read(callStateNotifierProvider);
    state.localRenderer.srcObject = localStream;
  }

  void _connectToWebSocket() {
    _channel = WebSocketChannel.connect(
      Uri.parse('ws://192.168.1.3:8083/call/ws?userId=$userId'),
    );

    _channel!.stream.listen((message) {
      final data = jsonDecode(message);
      final type = data['type'];

      switch (type) {
        case 'connectionStatus':
          print('✅ Connected to signaling server');
          _findPartner();
          break;
        case 'partnerFound':
          partnerId = data['partnerId'];
          ref.read(callStateNotifierProvider.notifier).setPartner(partnerId!);
          _createPeerConnection(partnerId!);
          break;
        case 'offer':
          _handleOffer(data);
          break;
        case 'answer':
          _handleAnswer(data);
          break;
        case 'ice':
          _handleIceCandidate(data);
          break;
        case 'partnerDisconnected':
          endCall();
          break;
      }
    });
  }

  void _findPartner() {
    _sendMessage({'type': 'findPartner', 'from': userId});
  }

  Future<void> _createPeerConnection(String partnerId) async {
    print("🔧 Bắt đầu tạo PeerConnection...");

    final configuration = {
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'}
      ],
      'sdpSemantics': 'unified-plan', // thêm dòng này để tương thích tốt hơn
    };

    try {
      try {
        print("⚙️ Đang tạo PeerConnection...");
        _peerConnection = await createPeerConnection(configuration);
        print("✅ Tạo PeerConnection thành công");
      } catch (e, stack) {
        print("❌ Lỗi khi gọi createPeerConnection: $e");
        print(stack);
        return;
      }
      print("@");
      // Thiết lập các callback cho peer connection
      _peerConnection!.onIceCandidate = (RTCIceCandidate candidate) {
        print("📨 Gửi ICE candidate");
        _sendMessage({
          'type': 'ice',
          'to': partnerId,
          'from': userId,
          'candidate': candidate.toMap(),
        });
      };

      _peerConnection!.onTrack = (RTCTrackEvent event) {
        print("📡 Đã nhận được track từ peer: ${event.track.id}");
        if (event.streams.isNotEmpty) {
          ref.read(callStateNotifierProvider.notifier).updateRemoteStream(event.streams[0]);
        }
      };

      // Kiểm tra local stream
      if (_localStream == null) {
        print("❌ Local stream null. Không thể add track.");
        return;
      }

      final videoTracks = _localStream!.getVideoTracks();
      final audioTracks = _localStream!.getAudioTracks();
      print("🎥 Video tracks: ${videoTracks.length}, 🎤 Audio tracks: ${audioTracks.length}");

      for (var track in _localStream!.getTracks()) {
        try {
          _peerConnection!.addTrack(track, _localStream!);
          print("✅ Added track: ${track.id}");
        } catch (e) {
          print("❌ Lỗi khi add track ${track.id}: $e");
        }
      }

      // Tạo offer và gửi cho partner
      try {
        final offer = await _peerConnection!.createOffer();
        print("📜 Offer created: ${offer.sdp?.substring(0, 60)}...");
        try {
          print("✅ Đã set local description và tạo offer");
          await _peerConnection!.setLocalDescription(offer);
          print("COC");
        } catch (e, stack) {
          print("❌ Lỗi khi gọi setLocalDescription: $e");
          print(stack);
        }


        _sendMessage({
          'type': 'offer',
          'from': userId,
          'to': partnerId,
          'sdp': offer.sdp,
          'sdpType': offer.type,
        });
      } catch (e, stack) {
        print("❌ Lỗi khi tạo/gán offer: $e");
        print(stack);
      }

    } catch (e, stack) {
      print("❌ Lỗi khi tạo peer connection: $e");
      print(stack);
    }
  }

  Future<void> _handleOffer(Map<String, dynamic> data) async {
    await _createPeerConnection(partnerId!);

    await _peerConnection!.setRemoteDescription(
      RTCSessionDescription(data['sdp'], data['sdpType']),
    );
    final answer = await _peerConnection!.createAnswer();
    await _peerConnection!.setLocalDescription(answer);

    _sendMessage({
      'type': 'answer',
      'from': userId,
      'to': partnerId,
      'sdp': answer.sdp,
      'sdpType': answer.type,
    });
  }

  Future<void> _handleAnswer(Map<String, dynamic> data) async {
    await _peerConnection!.setRemoteDescription(
      RTCSessionDescription(data['sdp'], data['sdpType']),
    );
    ref.read(callStateNotifierProvider.notifier).updateConnection(true);
  }

  void _handleIceCandidate(Map<String, dynamic> data) {
    final candidate = RTCIceCandidate(
      data['candidate']['candidate'],
      data['candidate']['sdpMid'],
      data['candidate']['sdpMLineIndex'],
    );
    _peerConnection?.addCandidate(candidate);
  }

  void _sendMessage(Map<String, dynamic> data) {
    _channel?.sink.add(jsonEncode(data));
  }

  void findNewPartner() {
    endCall();
    _findPartner();
  }

  void endCall() {
    _peerConnection?.close();
    _peerConnection = null;
    _localStream?.dispose();
    _sendMessage({'type': 'disconnect', 'from': userId});
    ref.read(callStateNotifierProvider.notifier).resetState();
  }
}
