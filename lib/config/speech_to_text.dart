import 'package:speech_to_text/speech_to_text.dart' as stt;

final speech = stt.SpeechToText();

Future<void> _initializeSpeech() async {
  bool available = await speech.initialize();
  if (available) {
    speech.listen(
      onResult: (result) {
        print('Recognized words: ${result.recognizedWords}');
      },
      localeId: 'en_US', // Chắc chắn rằng localeId là 'en_US' (Tiếng Anh Mỹ)
    );
  } else {
    print("Speech recognition is not available");
  }
}
