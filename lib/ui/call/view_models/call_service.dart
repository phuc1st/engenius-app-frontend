import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:permission_handler/permission_handler.dart';
import 'package:toeic/ui/call/viewmodels/call_view_model.dart';

final callServiceProvider = Provider<CallService>((ref) {
  return CallService(ref);
});

class CallService {
  final Ref ref;
  IO.Socket? _socket;
  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;

  CallService(this.ref);

  Future<void> init() async {
    await [Permission.camera, Permission.microphone].request();

    _socket = IO.io('http://your-call-service:9092', <String, dynamic>{
      'transports': ['websocket'],
      'query': {'userId': 'current-user-id'},
    });

    _setupSocketListeners();
  }

  void _setupSocketListeners() {
    _socket?.on('connect', (_) {
      ref.read(callStateNotifierProvider.notifier).updateConnection(true);
    });

    _socket?.on('partnerFound', (partnerId) {
      ref.read(callStateNotifierProvider.notifier).setPartner(partnerId);
      _startCall();
    });

    _socket?.on('offer', (data) => _handleOffer(data));
    _socket?.on('answer', (data) => _handleAnswer(data));
    _socket?.on('candidate', (data) => _handleCandidate(data));
    _socket?.on('disconnect', (_) {
      ref.read(callStateNotifierProvider.notifier).updateConnection(false);
    });
  }

  Future<void> _startCall() async {
    final state = ref.read(callStateNotifierProvider);
    _localStream = await navigator.mediaDevices.getUserMedia({
      'audio': state.isMicOn,
      'video': {
        'facingMode': state.isFrontCamera ? 'user' : 'environment',
        'width': 640,
        'height': 480,
      },
    });

    state.localRenderer.srcObject = _localStream;
    await _createPeerConnection();

    final offer = await _peerConnection!.createOffer();
    await _peerConnection!.setLocalDescription(offer);

    _socket?.emit('offer', {
      'to': state.partnerId,
      'offer': offer.toMap(),
    });
  }

  Future<void> _createPeerConnection() async {
    _peerConnection = await createPeerConnection({
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'},
        // Thêm TURN server nếu cần
      ],
    });

    _peerConnection?.onIceCandidate = (candidate) {
      if (candidate.candidate != null) {
        _socket?.emit('candidate', {
          'to': ref.read(callStateNotifierProvider).partnerId,
          'candidate': candidate.toMap(),
        });
      }
    };

    _peerConnection?.onAddStream = (stream) {
      ref.read(callStateNotifierProvider).remoteRenderer.srcObject = stream;
    };

    _peerConnection?.addStream(_localStream!);
  }

  Future<void> _handleOffer(dynamic data) async {
    await _createPeerConnection();

    final offer = RTCSessionDescription(
      data['offer']['sdp'],
      data['offer']['type'],
    );

    await _peerConnection!.setRemoteDescription(offer);
    final answer = await _peerConnection!.createAnswer();
    await _peerConnection!.setLocalDescription(answer);

    _socket?.emit('answer', {
      'to': data['from'],
      'answer': answer.toMap(),
    });
  }

  Future<void> _handleAnswer(dynamic data) async {
    final answer = RTCSessionDescription(
      data['answer']['sdp'],
      data['answer']['type'],
    );
    await _peerConnection!.setRemoteDescription(answer);
  }

  Future<void> _handleCandidate(dynamic data) async {
    final candidate = RTCIceCandidate(
      data['candidate']['candidate'],
      data['candidate']['sdpMid'],
      data['candidate']['sdpMLineIndex'],
    );
    await _peerConnection?.addIceCandidate(candidate);
  }

  Future<void> endCall() async {
    await _peerConnection?.close();
    await _localStream?.dispose();
    _socket?.disconnect();
  }
}