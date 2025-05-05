import 'package:flutter_webrtc/flutter_webrtc.dart';

class CallState {
  final RTCVideoRenderer localRenderer;
  final RTCVideoRenderer remoteRenderer;
  final bool isCameraOn;
  final bool isMicOn;
  final bool isFrontCamera;
  final bool isConnected;
  final String? callId;
  final String? partnerId;
  final bool isLocalVideoEnabled;

  CallState({
    required this.localRenderer,
    required this.remoteRenderer,
    this.isCameraOn = true,
    this.isMicOn = true,
    this.isFrontCamera = true,
    this.isConnected = false,
    this.callId,
    this.partnerId,
    this.isLocalVideoEnabled = true,
  });

  CallState copyWith({
    bool? isCameraOn,
    bool? isMicOn,
    bool? isFrontCamera,
    bool? isConnected,
    String? callId,
    String? partnerId,
    bool? isLocalVideoEnabled,
  }) {
    return CallState(
      localRenderer: localRenderer,
      remoteRenderer: remoteRenderer,
      isCameraOn: isCameraOn ?? this.isCameraOn,
      isMicOn: isMicOn ?? this.isMicOn,
      isFrontCamera: isFrontCamera ?? this.isFrontCamera,
      isConnected: isConnected ?? this.isConnected,
      callId: callId ?? this.callId,
      partnerId: partnerId ?? this.partnerId,
      isLocalVideoEnabled: isLocalVideoEnabled ?? this.isLocalVideoEnabled,
    );
  }
}