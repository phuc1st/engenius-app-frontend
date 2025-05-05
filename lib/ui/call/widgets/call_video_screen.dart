import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:toeic/ui/call/view_models/call_service.dart';
import 'package:toeic/ui/call/view_models/call_state.dart';
import 'package:toeic/ui/call/view_models/call_view_model.dart';

class VideoCallScreen extends ConsumerStatefulWidget {
  const VideoCallScreen({super.key});

  @override
  ConsumerState<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends ConsumerState<VideoCallScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(callServiceProvider).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(callStateNotifierProvider);
    final notifier = ref.read(callStateNotifierProvider.notifier);
    final callService = ref.read(callServiceProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Remote video
          RTCVideoView(state.remoteRenderer),

          // Local video (draggable)
          if (state.isLocalVideoEnabled)
            Positioned(
              left: 20,
              top: 100,
              child: GestureDetector(
                onPanUpdate: (details) {
                  // Handle drag here if needed
                },
                child: Container(
                  width: 120,
                  height: 180,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                  child: state.isCameraOn
                      ? RTCVideoView(state.localRenderer)
                      : const Center(child: Icon(Icons.videocam_off, color: Colors.white)),
                ),
              ),
            ),

          // Control panel
          _buildControlPanel(notifier, callService, state),
        ],
      ),
    );
  }

  Widget _buildControlPanel(
      CallStateNotifier notifier, CallService callService, CallState state) {
    return Positioned(
      bottom: 30,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(state.isMicOn ? Icons.mic : Icons.mic_off),
            color: state.isMicOn ? Colors.white : Colors.red,
            onPressed: notifier.toggleMic,
          ),
          IconButton(
            icon: const Icon(Icons.cameraswitch),
            color: Colors.white,
            onPressed: notifier.switchCamera,
          ),
          IconButton(
            icon: Icon(state.isCameraOn ? Icons.videocam : Icons.videocam_off),
            color: state.isCameraOn ? Colors.white : Colors.red,
            onPressed: notifier.toggleCamera,
          ),
          IconButton(
            icon: const Icon(Icons.video_settings),
            color: Colors.white,
            onPressed: notifier.toggleLocalVideo,
          ),
          IconButton(
            icon: const Icon(Icons.call_end),
            color: Colors.red,
            onPressed: () {
              callService.endCall();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}