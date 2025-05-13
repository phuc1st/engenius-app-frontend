import 'dart:ui';

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
  final bool isSwapped;
  final Offset localVideoPosition;
  final double localVideoWidth;
  final double localVideoHeight;
  final bool isReconnecting;

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
    this.isSwapped = false,
    this.localVideoPosition = const Offset(20, 100),
    this.localVideoWidth = 120,
    this.localVideoHeight = 180,
    this.isReconnecting = false,
  });

  CallState copyWith({
    RTCVideoRenderer? localRenderer,
    RTCVideoRenderer? remoteRenderer,
    bool? isCameraOn,
    bool? isMicOn,
    bool? isFrontCamera,
    bool? isConnected,
    String? callId,
    String? partnerId,
    bool? isLocalVideoEnabled,
    bool? isSwapped,
    Offset? localVideoPosition,
    double? localVideoWidth,
    double? localVideoHeight,
    bool? isReconnecting,
  }) {
    return CallState(
      localRenderer: localRenderer ?? this.localRenderer,
      remoteRenderer: remoteRenderer ?? this.remoteRenderer,
      isCameraOn: isCameraOn ?? this.isCameraOn,
      isMicOn: isMicOn ?? this.isMicOn,
      isFrontCamera: isFrontCamera ?? this.isFrontCamera,
      isConnected: isConnected ?? this.isConnected,
      callId: callId ?? this.callId,
      partnerId: partnerId ?? this.partnerId,
      isLocalVideoEnabled: isLocalVideoEnabled ?? this.isLocalVideoEnabled,
      isSwapped: isSwapped ?? this.isSwapped,
      localVideoPosition: localVideoPosition ?? this.localVideoPosition,
      localVideoWidth: localVideoWidth ?? this.localVideoWidth,
      localVideoHeight: localVideoHeight ?? this.localVideoHeight,
      isReconnecting: isReconnecting ?? this.isReconnecting,
    );
  }
}