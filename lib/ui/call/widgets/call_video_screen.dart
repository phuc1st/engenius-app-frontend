// video_call_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:toeic/ui/call/view_models/call_service.dart';
import 'package:toeic/ui/call/view_models/call_service_2.dart';
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
    // Khởi tạo các dịch vụ cuộc gọi sau khi widget đã render lần đầu
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(callServiceProvider).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(callStateNotifierProvider);
    final notifier = ref.read(callStateNotifierProvider.notifier);
    final callService = ref.read(callServiceProvider);
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          state.isConnected ? "Đang kết nối..." : "Đang tìm kiếm...",
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.swap_horiz, color: Colors.white),
            onPressed: notifier.swapVideos,
          ),
          IconButton(
            icon: Icon(
              state.isLocalVideoEnabled ? Icons.visibility : Icons.visibility_off,
              color: Colors.white,
            ),
            onPressed: notifier.toggleLocalVideo,
          ),
        ],
      ),
      body: Stack(
        children: [
          // Video chính (hiển thị video từ xa hoặc video cục bộ nếu swap)
          _buildVideoWidget(
            isLocal: state.isSwapped,
            isMain: true,
            size: Size(screenSize.width, screenSize.height),
            myVideo: RTCVideoView(state.localRenderer),
            yourVideo: RTCVideoView(state.remoteRenderer),
            isCameraOn: state.isCameraOn,
          ),
          // Video cục bộ ở vị trí draggable (nếu bật hiển thị)
          if (state.isLocalVideoEnabled)
            Positioned(
              left: state.localVideoPosition.dx,
              top: state.localVideoPosition.dy,
              child: GestureDetector(
                onPanUpdate: (details) {
                  notifier.updateLocalVideoPosition(details.delta, screenSize);
                },
                child: _buildVideoWidget(
                  isLocal: !state.isSwapped,
                  isMain: false,
                  size: Size(state.localVideoWidth, state.localVideoHeight),
                  myVideo: RTCVideoView(state.localRenderer),
                  yourVideo: RTCVideoView(state.remoteRenderer),
                  isCameraOn: state.isCameraOn,
                ),
              ),
            ),

          // Control panel
          _buildControlPanel(notifier, callService, state),
        ],
      ),
    );
  }

  Widget _buildVideoWidget({
    required bool isLocal,
    required bool isMain,
    required Size size,
    required Widget myVideo,
    required Widget yourVideo,
    required bool isCameraOn,
  }) {
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        border: Border.all(
          color: isMain ? Colors.pinkAccent : Colors.blueAccent,
          width: 2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isLocal && isCameraOn) Expanded(child: myVideo),
          if (!isLocal) Expanded(child: yourVideo),
          if (isLocal && !isCameraOn)
            Icon(
              Icons.videocam_off,
              size: isMain ? 50 : 30,
              color: Colors.white,
            ),
        ],
      ),
    );
  }

  Widget _buildControlPanel(
      CallStateNotifier notifier,
      CallService callService,
      CallState state,
      ) {
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
            icon:
            Icon(state.isCameraOn ? Icons.videocam : Icons.videocam_off),
            color: state.isCameraOn ? Colors.white : Colors.red,
            onPressed: notifier.toggleCamera,
          ),
          IconButton(
            icon: const Icon(Icons.video_settings),
            color: Colors.white,
            onPressed: notifier.toggleLocalVideo,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            color: Colors.white,
            onPressed: () {
              // Thay vì gọi notifier.findNewPartner
              callService.findNewPartner();

              // Hiển thị thông báo đang tìm kiếm
              final context = ref.read(navigatorKeyProvider).currentContext;
              if (context != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Finding new partner...')),
                );
              }
            },
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
