import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toeic/provider/learn_vocabulary_provider.dart';
import 'package:toeic/ui/learn_vocabulary/flash_card/widgets/flash_card.dart';
import 'package:toeic/ui/learn_vocabulary/flash_card/widgets/flashcard_counter.dart';
import 'package:toeic/ui/learn_vocabulary/flash_card/widgets/flashcard_progress.dart';

class FlashcardScreen2 extends ConsumerStatefulWidget {
  final int progressId;

  const FlashcardScreen2({super.key, required this.progressId});

  @override
  ConsumerState<FlashcardScreen2> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends ConsumerState<FlashcardScreen2> {
  double _offsetX = 0.0;
  double _offsetY = 0.0;
  bool? _directionTextIsRight;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(flashCardViewModelProvider.notifier)
          .getFlashCards(widget.progressId);
    });
  }

  void _handleSwipeEnd() {
    setState(() {
      if (_offsetX > 100) {
        ref.read(flashCardViewModelProvider.notifier).swipeRight();
      } else if (_offsetX < -100) {
        ref.read(flashCardViewModelProvider.notifier).swipeLeft();
      }

      _offsetX = 0.0;
      _offsetY = 0.0;
      _directionTextIsRight = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(flashCardViewModelProvider);
    final flashCards = state.flashCards;
    return Scaffold(
      appBar: AppBar(title: const Text("Flashcards")),
      body:
          state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : state.error != null
              ? Center(child: Text("Lỗi: ${state.error}"))
              : SingleChildScrollView(
                child: Column(
                  children: [
                    FlashcardProgress(
                      rightCount: state.rightCount,
                      total: flashCards.length + state.rightCount,
                    ),
                    const SizedBox(height: 30),
                    if (flashCards.isNotEmpty) ...[
                      Center(
                        child: GestureDetector(
                          onPanUpdate: (details) {
                            setState(() {
                              _offsetX += details.delta.dx;
                              _offsetY += details.delta.dy;
                              _directionTextIsRight = _offsetX > 0;
                            });
                          },
                          onPanEnd: (_) => _handleSwipeEnd(),
                          child: FlashcardCard(
                            card: flashCards[0],
                            offsetX: _offsetX,
                            offsetY: _offsetY,
                            directionTextIsRight: _directionTextIsRight,
                            audioPlayer: _audioPlayer,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      FlashcardCounter(
                        left: state.leftCount,
                        right: state.rightCount,
                      ),
                    ] else
                      Expanded(
                        child: Center(
                          child: const Text(
                            "Hết thẻ!",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
    );
  }
}
