import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'call_state.dart';

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

  @override
  void dispose() {
    state.localRenderer.dispose();
    state.remoteRenderer.dispose();
    super.dispose();
  }
}