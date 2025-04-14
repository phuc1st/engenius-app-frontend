import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toeic/data/services/api/model/learn_vocabulary_response/flash_card_response.dart';
import 'package:toeic/provider/learn_vocabulary_provider.dart';

class FlashCardScreen extends ConsumerStatefulWidget {
  final String topicId;
  const FlashCardScreen({Key? key, required this.topicId}) : super(key: key);

  @override
  ConsumerState<FlashCardScreen> createState() => _FlashCardScreenState();
}

class _FlashCardScreenState extends ConsumerState<FlashCardScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Danh sách flashcard hiện tại và bản gốc để phục vụ reset
  List<FlashCardResponse> flashcards = [];
  List<FlashCardResponse> originalFlashcards = [];

  int understoodCount = 0;
  int notUnderstoodCount = 0;

  @override
  void initState() {
    super.initState();
    // Khi init, gọi viewModel để lấy flashcard theo topicId
    Future.microtask(() {
      ref
          .read(flashCardViewModelProvider.notifier)
          .getFlashCards(widget.topicId);
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Lắng nghe trạng thái từ viewModel (Riverpod)
    final flashCardsState = ref.watch(flashCardViewModelProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Flashcards"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: flashCardsState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text("Lỗi: $error")),
        data: (data) {
          // Gán dữ liệu ban đầu nếu chưa có
          if (originalFlashcards.isEmpty && data.isNotEmpty) {
            originalFlashcards = List.from(data);
            flashcards = List.from(data);
          }
          return Column(
            children: [
              // Thanh tiến độ: hiển thị số flashcard đã học (ví dụ "3/10")
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${originalFlashcards.length - flashcards.length} / ${originalFlashcards.length}",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              // Phần chính hiển thị flashcard với DragTarget ở bên trái và bên phải
              Expanded(
                child: Stack(
                  children: [
                    // DragTarget bên trái (cho "Học lại")
                    Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: DragTarget<FlashCardResponse>(
                        builder: (context, candidateData, rejectedData) {
                          return Container(
                            // Hiển thị vùng đón có màu nền mờ nếu có đối tượng kéo vào
                            color: candidateData.isNotEmpty
                                ? Colors.red.withAlpha(100)
                                : Colors.transparent,
                          );
                        },
                        onAcceptWithDetails:
                            (DragTargetDetails<FlashCardResponse> details) {
                          final flashCard = details.data;
                          setState(() {
                            // Nếu thẻ được kéo chính là thẻ đầu tiên, di chuyển nó về cuối danh sách
                            if (flashcards.isNotEmpty &&
                                flashcards.first.id == flashCard.id) {
                              final removed = flashcards.removeAt(0);
                              flashcards.add(removed);
                              notUnderstoodCount++;
                            }
                          });
                        },
                      ),
                    ),
                    // DragTarget bên phải (cho "Đã hiểu")
                    Positioned(
                      right: 0,
                      top: 0,
                      bottom: 0,
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: DragTarget<FlashCardResponse>(
                        builder: (context, candidateData, rejectedData) {
                          return Container(
                            color: candidateData.isNotEmpty
                                ? Colors.green.withAlpha(100)
                                : Colors.transparent,
                          );
                        },
                        onAcceptWithDetails:
                            (DragTargetDetails<FlashCardResponse> details) async {
                          final flashCard = details.data;
                          setState(() {
                            if (flashcards.isNotEmpty &&
                                flashcards.first.id == flashCard.id) {
                              flashcards.removeAt(0);
                              understoodCount++;
                            }
                          });
                          // Cập nhật trạng thái flashcard sang memorized = true trong viewModel
                          // await ref
                          //     .read(flashCardViewModelProvider.notifier)
                          //     .updateFlashCardStatus(flashCard.id, true);
                          // Nếu danh sách rỗng, lưu kết quả học
                          if (flashcards.isEmpty) {
                            // await ref
                            //     .read(flashCardViewModelProvider.notifier)
                            //     .saveFlashCardResults(originalFlashcards);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Đã lưu kết quả học")),
                            );
                          }
                        },
                      ),
                    ),
                    // Hiển thị flashcard dạng draggable ở giữa
                    Center(
                      child: flashcards.isEmpty
                          ? const Text("Bạn đã hoàn thành tất cả flashcard!")
                          : DraggableFlashCard(
                        flashCard: flashcards.first,
                        audioPlayer: _audioPlayer,
                      ),
                    ),
                  ],
                ),
              ),
              // Nút reset để khôi phục lại danh sách flashcard nếu cần.
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: () {
                        setState(() {
                          flashcards = List.from(originalFlashcards);
                          understoodCount = 0;
                          notUnderstoodCount = 0;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

///
/// DraggableFlashCard: Widget hiển thị flashcard với nội dung gồm hình ảnh, từ, phiên âm, và nút phát âm.
/// Khi người dùng kéo, ở đỉnh flashcard sẽ hiển thị overlay:
/// - Nếu kéo sang phải: hiển thị "Đã hiểu"
/// - Nếu kéo sang trái: hiển thị "Học lại"
///
class DraggableFlashCard extends StatefulWidget {
  final FlashCardResponse flashCard;
  final AudioPlayer audioPlayer;
  const DraggableFlashCard({
    Key? key,
    required this.flashCard,
    required this.audioPlayer,
  }) : super(key: key);

  @override
  _DraggableFlashCardState createState() => _DraggableFlashCardState();
}

class _DraggableFlashCardState extends State<DraggableFlashCard> {
  double dragOffsetX = 0.0;
  OverlayEntry? overlayEntry;

  // Tạo overlay widget dựa theo hướng kéo
  OverlayEntry _createOverlayEntry() {
    String overlayText = "";
    if (dragOffsetX > 0) {
      overlayText = "Đã hiểu";
    } else if (dragOffsetX < 0) {
      overlayText = "Học lại";
    }
    // Vị trí có thể hiệu chỉnh sao cho nằm ngay trên đỉnh của flashcard
    return OverlayEntry(
      builder: (context) => Positioned(
        // Vị trí top tùy chỉnh theo thiết kế, ví dụ 50 điểm từ trên
        top: 50,
        // Căn giữa theo chiều ngang
        left: MediaQuery.of(context).size.width / 2 - 100,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 200,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                overlayText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showOverlay() {
    if (overlayEntry == null) {
      overlayEntry = _createOverlayEntry();
      Overlay.of(context)?.insert(overlayEntry!);
    }
  }

  void _updateOverlay() {
    if (overlayEntry != null) {
      // Khi update, ta loại bỏ overlay cũ và thêm overlay mới
      overlayEntry!.remove();
      overlayEntry = _createOverlayEntry();
      Overlay.of(context)?.insert(overlayEntry!);
    }
  }

  void _removeOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    // Sử dụng Listener để bắt các sự kiện di chuyển của con trỏ
    return Listener(
      onPointerDown: (_) {
        _showOverlay();
      },
      onPointerMove: (event) {
        setState(() {
          dragOffsetX += event.delta.dx;
        });
        _updateOverlay();
      },
      onPointerUp: (_) {
        _removeOverlay();
        setState(() {
          dragOffsetX = 0.0;
        });
      },
      child: Draggable<FlashCardResponse>(
        data: widget.flashCard,
        // Ở đây feedback chỉ hiển thị Card gốc, vì overlay đã được xử lý ngoài
        feedback: Material(
          color: Colors.transparent,
          child: _buildCard(),
        ),
        childWhenDragging: Container(),
        child: _buildCard(),
      ),
    );
  }

  Widget _buildCard() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Hình ảnh flashcard – đảm bảo asset đã khai báo
            SizedBox(
              height: 200,
              child: Image.asset(widget.flashCard.image,
                  fit: BoxFit.contain),
            ),
            const SizedBox(height: 16),
            // Từ flashcard
            Text(
              widget.flashCard.word,
              style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Phiên âm
            Text(
              widget.flashCard.phonetic,
              style: const TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey),
            ),
            const SizedBox(height: 20),
            // Nút phát âm (ví dụ dùng một URL audio)
            ElevatedButton.icon(
              onPressed: () => widget.audioPlayer
                  .play(UrlSource(widget.flashCard.audio)),
              icon: const Icon(Icons.volume_up),
              label: const Text("Phát âm"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

