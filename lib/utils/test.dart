import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FlashCardResponse {
  final String word;
  final String pronunciation;
  final String imageUrl;
  final bool memorized;

  FlashCardResponse({
    required this.word,
    required this.pronunciation,
    required this.imageUrl,
    this.memorized = false,
  });

  FlashCardResponse copyWith({
    String? word,
    String? pronunciation,
    String? imageUrl,
    bool? memorized,
  }) {
    return FlashCardResponse(
      word: word ?? this.word,
      pronunciation: pronunciation ?? this.pronunciation,
      imageUrl: imageUrl ?? this.imageUrl,
      memorized: memorized ?? this.memorized,
    );
  }
}

class FlashcardScreen extends ConsumerStatefulWidget {
  const FlashcardScreen({super.key});

  @override
  ConsumerState<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends ConsumerState<FlashcardScreen> {
  int currentIndex = 0;

  final List<FlashCardResponse> flashCards = [
    FlashCardResponse(
      word: "consequence",
      pronunciation: "/ˈkɒnsɪkwəns/",
      imageUrl: "https://i.imgur.com/BfTQbqM.png", // Replace with your image
    ),
    // Thêm các flashcard khác
  ];

  final List<FlashCardResponse> learnedFlashcards = [];

  void _handleSwipe(bool isRight) {
    final currentCard = flashCards[currentIndex];
    final updatedCard = currentCard.copyWith(memorized: isRight);
    learnedFlashcards.add(updatedCard);

    setState(() {
      currentIndex++;
    });

    if (currentIndex >= flashCards.length) {
      _saveResultsAndNavigate();
    }
  }

  void _saveResultsAndNavigate() {
    // TODO: Lưu kết quả lên server hoặc điều hướng sang trang kết quả
    print("Bạn đã học xong. Kết quả:");
    for (final card in learnedFlashcards) {
      print("${card.word} - ${card.memorized ? 'Đã hiểu' : 'Học lại'}");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (flashCards.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (currentIndex >= flashCards.length) {
      return const Center(child: Text("Bạn đã hoàn thành tất cả flashcard!"));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Flashcards")),
      body: Center(
        child: DraggableFlashCard(
          flashCard: flashCards[currentIndex],
          onSwipe: _handleSwipe,
        ),
      ),
    );
  }
}

class DraggableFlashCard extends StatefulWidget {
  final FlashCardResponse flashCard;
  final void Function(bool isRight) onSwipe;

  const DraggableFlashCard({
    super.key,
    required this.flashCard,
    required this.onSwipe,
  });

  @override
  State<DraggableFlashCard> createState() => _DraggableFlashCardState();
}

class _DraggableFlashCardState extends State<DraggableFlashCard>
    with SingleTickerProviderStateMixin {
  Offset position = Offset.zero;
  double angle = 0;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    setState(() {
      position += details.delta;
      angle = position.dx / 300;
    });
  }

  void _handlePanEnd(DragEndDetails details) {
    final velocity = details.velocity.pixelsPerSecond.dx;

    if (position.dx > 150 || velocity > 1000) {
      widget.onSwipe(true); // Swipe right
    } else if (position.dx < -150 || velocity < -1000) {
      widget.onSwipe(false); // Swipe left
    } else {
      setState(() {
        position = Offset.zero;
        angle = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isRight = position.dx > 0;
    final isSwiping = position.dx.abs() > 20;

    return GestureDetector(
      onPanUpdate: _handlePanUpdate,
      onPanEnd: _handlePanEnd,
      child: Transform.translate(
        offset: position,
        child: Transform.rotate(
          angle: angle,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 8,
                child: Container(
                  width: 320,
                  height: 480,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(widget.flashCard.imageUrl, height: 180),
                      const SizedBox(height: 24),
                      Text(
                        widget.flashCard.word,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.flashCard.pronunciation,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (isSwiping)
                Positioned(
                  top: 20,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isRight ? Colors.green : Colors.orange,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      isRight ? 'Đã Hiểu' : 'Học lại',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
