import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:toeic/data/services/api/model/learn_vocabulary_response/flash_card_response.dart';

class FlashcardCard extends StatelessWidget {
  final FlashCardResponse card;
  final double offsetX;
  final double offsetY;
  final bool? directionTextIsRight;
  final AudioPlayer audioPlayer;

  const FlashcardCard({
    super.key,
    required this.card,
    required this.offsetX,
    required this.offsetY,
    required this.directionTextIsRight,
    required this.audioPlayer,
  });

  @override
  Widget build(BuildContext context) {
    final rotationAngle = offsetX / 500;

    return Transform.translate(
      offset: Offset(offsetX, offsetY),
      child: Transform.rotate(
        angle: rotationAngle,
        child: Container(
          width: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(3, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (directionTextIsRight != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    color: directionTextIsRight!
                        ? Colors.green
                        : Colors.orange.shade500,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: Center(
                    child: Text(
                      directionTextIsRight! ? "Đã hiểu" : "Học lại",
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 40),
              Image.network("https://th.bing.com/th/id/OIP.6vjeUhmJD_30DKTKzXlV6QHaE7?w=261&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7", height: 200),
              const SizedBox(height: 16),
              Text(card.word,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(card.phonetic,
                  style: const TextStyle(fontSize: 20, fontStyle: FontStyle.italic)),
              const SizedBox(height: 8),
              IconButton(
                onPressed: () => audioPlayer.play(UrlSource(card.audio)),
                icon: const Icon(Icons.volume_up, color: Colors.blue),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
