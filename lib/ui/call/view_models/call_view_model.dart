// call_view_model.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:toeic/ui/call/view_models/call_state.dart';

final navigatorKeyProvider = Provider<GlobalKey<NavigatorState>>((ref) {
  return GlobalKey<NavigatorState>();
});



final callStateNotifierProvider = StateNotifierProvider<CallStateNotifier, CallState>((ref) {
  return CallStateNotifier();
});

class CallStateNotifier extends StateNotifier<CallState> {
  CallStateNotifier() : super(CallState(
    localRenderer: RTCVideoRenderer()..initialize(),
    remoteRenderer: RTCVideoRenderer()..initialize(),
  ));

  void updateConnection(bool isConnected) {
    state = state.copyWith(isConnected: isConnected);
  }

  void setPartner(String partnerId) {
    state = state.copyWith(partnerId: partnerId);
  }

  void updateRemoteStream(MediaStream stream) {
    state.remoteRenderer.srcObject = stream;
    state = state.copyWith(); // Trigger rebuild
  }

  void toggleCamera() async {
    final newState = !state.isCameraOn;
    if (state.localRenderer.srcObject != null) {
      final tracks = state.localRenderer.srcObject!.getVideoTracks();
      if (tracks.isNotEmpty) {
        tracks.first.enabled = newState;
      }
    }
    state = state.copyWith(isCameraOn: newState);
  }

  void toggleMic() async {
    final newState = !state.isMicOn;
    if (state.localRenderer.srcObject != null) {
      final tracks = state.localRenderer.srcObject!.getAudioTracks();
      if (tracks.isNotEmpty) {
        tracks.first.enabled = newState;
      }
    }
    state = state.copyWith(isMicOn: newState);
  }

  void switchCamera() async {
    if (state.localRenderer.srcObject != null) {
      final tracks = state.localRenderer.srcObject!.getVideoTracks();
      if (tracks.isNotEmpty) {
        await tracks.first.switchCamera();
        state = state.copyWith(isFrontCamera: !state.isFrontCamera);
      }
    }
  }

  void toggleLocalVideo() {
    state = state.copyWith(isLocalVideoEnabled: !state.isLocalVideoEnabled);
  }

  void swapVideos() {
    state = state.copyWith(isSwapped: !state.isSwapped);
  }

  void updateLocalVideoPosition(Offset delta, Size screenSize) {
    Offset newPosition = state.localVideoPosition + delta;
    double maxX = screenSize.width - state.localVideoWidth;
    double maxY = screenSize.height - state.localVideoHeight - 100;

    newPosition = Offset(
      newPosition.dx.clamp(0, maxX).toDouble(),
      newPosition.dy.clamp(0, maxY).toDouble(),
    );

    state = state.copyWith(localVideoPosition: newPosition);
  }

  void setReconnecting(bool isReconnecting) {
    state = state.copyWith(isReconnecting: isReconnecting);
  }

  void resetState() {
    state.localRenderer.srcObject = null;
    state.remoteRenderer.srcObject = null;
    state = CallState(
      localRenderer: state.localRenderer,
      remoteRenderer: state.remoteRenderer,
    );
  }

  @override
  void dispose() {
    state.localRenderer.dispose();
    state.remoteRenderer.dispose();
    super.dispose();
  }
}